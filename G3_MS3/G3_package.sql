-- Triggers and Constraint

/*
This trigger checks that the stock level is sufficient before a sale proceeds. If the stock level is too low, an error is raised.
*/

CREATE OR REPLACE TRIGGER trg_check_stock_level BEFORE
    INSERT ON salestransactions
    FOR EACH ROW
DECLARE
    insufficient_stock EXCEPTION;
    stock_level NUMBER;
BEGIN
    -- Retrieve stock level for the product
    SELECT
        stock_level
    INTO stock_level
    FROM
        inventory
    WHERE
            product_id = :new.product_id
        AND store_id = :new.store_id;

    -- Check if stock is insufficient
    IF :new.quantity_sold > stock_level THEN
        RAISE insufficient_stock;
    END IF;
EXCEPTION
    WHEN insufficient_stock THEN
        raise_application_error(-20001, 'Insufficient stock for this transaction.');
END;
/

/*
This trigger updates the Delivery_History in the Suppliers table every time there’s a new inventory entry from a supplier.
*/
CREATE OR REPLACE TRIGGER trg_supplier_delivery AFTER
    INSERT ON inventory
    FOR EACH ROW
BEGIN
    UPDATE suppliers
    SET
        delivery_history = delivery_history
                           || ', Delivered on '
                           || to_char(sysdate, 'YYYY-MM-DD')
    WHERE
        supplier_id = (
            SELECT
                supplier_id
            FROM
                suppliers
            WHERE
                product_id = :new.product_id
        );

END;
/	

/* Ensures that each sale has a positive quantity */
ALTER TABLE salestransactions ADD CONSTRAINT chk_positive_quantity_sold CHECK ( quantity_sold > 0 );

/* Ensures each entry in the `Inventory` table references a valid product.*/
ALTER TABLE inventory
    ADD CONSTRAINT fk_inventory_product FOREIGN KEY ( product_id )
        REFERENCES products ( product_id );

/*Ensures that each supplier’s product is valid in the `Products` table.*/
ALTER TABLE suppliers
    ADD CONSTRAINT fk_supplier_product FOREIGN KEY ( product_id )
        REFERENCES products ( product_id );

/*Ensures that stock levels are never negative.*/
ALTER TABLE inventory ADD CONSTRAINT chk_stock_level_non_negative CHECK ( stock_level >= 0 );

/*Ensures each product appears only once per store.*/
ALTER TABLE inventory ADD CONSTRAINT uq_product_store UNIQUE ( product_id,
                                                               store_id );


--Package Implementation

CREATE OR REPLACE PACKAGE g3_inventory_pkg AS
    -- ### Products CRUD Operations ###
    PROCEDURE add_product (
        p_product_id   IN NUMBER,
        p_product_name IN VARCHAR2
    );

    PROCEDURE update_product (
        p_product_id   IN NUMBER,
        p_product_name IN VARCHAR2
    );

    PROCEDURE delete_product (
        p_product_id IN NUMBER
    );

    PROCEDURE get_product (
        p_product_id IN NUMBER
    );

    -- ### Inventory CRUD Operations ###
    PROCEDURE add_inventory (
        p_product_id  IN NUMBER,
        p_store_id    IN NUMBER,
        p_stock_level IN NUMBER
    );

    PROCEDURE update_inventory (
        p_product_id  IN NUMBER,
        p_store_id    IN NUMBER,
        p_stock_level IN NUMBER
    );

    PROCEDURE delete_inventory (
        p_product_id IN NUMBER,
        p_store_id   IN NUMBER
    );

    PROCEDURE get_inventory (
        p_product_id IN NUMBER,
        p_store_id   IN NUMBER
    );

    -- ### Suppliers CRUD Operations ###
    PROCEDURE add_supplier (
        p_supplier_id      IN NUMBER,
        p_product_id       IN NUMBER,
        p_lead_time        IN NUMBER,
        p_delivery_history IN VARCHAR2
    );

    PROCEDURE update_supplier (
        p_supplier_id      IN NUMBER,
        p_lead_time        IN NUMBER,
        p_delivery_history IN VARCHAR2
    );

    PROCEDURE delete_supplier (
        p_supplier_id IN NUMBER
    );

    PROCEDURE get_supplier (
        p_supplier_id IN NUMBER
    );

    -- ### Sales Transactions CRUD Operations ###
    PROCEDURE add_sale (
        p_transaction_id IN NUMBER,
        p_product_id     IN NUMBER,
        p_store_id       IN NUMBER,
        p_quantity_sold  IN NUMBER,
        p_sale_date      IN DATE
    );

    PROCEDURE update_sale (
        p_transaction_id IN NUMBER,
        p_quantity_sold  IN NUMBER,
        p_sale_date      IN DATE
    );

    PROCEDURE delete_sale (
        p_transaction_id IN NUMBER
    );

    PROCEDURE get_sale (
        p_transaction_id IN NUMBER
    );

    -- ### Utility Procedures for Business Rules ###
    PROCEDURE enforce_stock_level (
        p_product_id    IN NUMBER,
        p_store_id      IN NUMBER,
        p_quantity_sold IN NUMBER
    );

END g3_inventory_pkg;
/

-- Package Body: Implements the functionality declared in the package specification.
CREATE OR REPLACE PACKAGE BODY g3_inventory_pkg AS

    -- ### Products CRUD Operations ###
    PROCEDURE add_product (
        p_product_id   IN NUMBER,
        p_product_name IN VARCHAR2
    ) IS
    BEGIN
        INSERT INTO products (
            product_id,
            product_name
        ) VALUES (
            p_product_id,
            p_product_name
        );

    END add_product;

    PROCEDURE update_product (
        p_product_id   IN NUMBER,
        p_product_name IN VARCHAR2
    ) IS
    BEGIN
        UPDATE products
        SET
            product_name = p_product_name
        WHERE
            product_id = p_product_id;

    END update_product;

    PROCEDURE delete_product (
        p_product_id IN NUMBER
    ) IS
    BEGIN
        DELETE FROM products
        WHERE
            product_id = p_product_id;

    END delete_product;

    PROCEDURE get_product (
        p_product_id IN NUMBER
    ) IS
        v_product_name VARCHAR2(50);
    BEGIN
        SELECT
            product_name
        INTO v_product_name
        FROM
            products
        WHERE
            product_id = p_product_id;

        dbms_output.put_line('Product Name: ' || v_product_name);
    END get_product;

    -- ### Inventory CRUD Operations ###
    PROCEDURE add_inventory (
        p_product_id  IN NUMBER,
        p_store_id    IN NUMBER,
        p_stock_level IN NUMBER
    ) IS
    BEGIN
        INSERT INTO inventory (
            product_id,
            store_id,
            stock_level
        ) VALUES (
            p_product_id,
            p_store_id,
            p_stock_level
        );

    END add_inventory;

    PROCEDURE update_inventory (
        p_product_id  IN NUMBER,
        p_store_id    IN NUMBER,
        p_stock_level IN NUMBER
    ) IS
    BEGIN
        UPDATE inventory
        SET
            stock_level = p_stock_level
        WHERE
                product_id = p_product_id
            AND store_id = p_store_id;

    END update_inventory;

    PROCEDURE delete_inventory (
        p_product_id IN NUMBER,
        p_store_id   IN NUMBER
    ) IS
    BEGIN
        DELETE FROM inventory
        WHERE
                product_id = p_product_id
            AND store_id = p_store_id;

    END delete_inventory;

    PROCEDURE get_inventory (
        p_product_id IN NUMBER,
        p_store_id   IN NUMBER
    ) IS
        v_stock_level NUMBER;
    BEGIN
        SELECT
            stock_level
        INTO v_stock_level
        FROM
            inventory
        WHERE
                product_id = p_product_id
            AND store_id = p_store_id;

        dbms_output.put_line('Stock Level: ' || v_stock_level);
    END get_inventory;

    -- ### Suppliers CRUD Operations ###
    PROCEDURE add_supplier (
        p_supplier_id      IN NUMBER,
        p_product_id       IN NUMBER,
        p_lead_time        IN NUMBER,
        p_delivery_history IN VARCHAR2
    ) IS
    BEGIN
        INSERT INTO suppliers (
            supplier_id,
            product_id,
            lead_time,
            delivery_history
        ) VALUES (
            p_supplier_id,
            p_product_id,
            p_lead_time,
            p_delivery_history
        );

    END add_supplier;

    PROCEDURE update_supplier (
        p_supplier_id      IN NUMBER,
        p_lead_time        IN NUMBER,
        p_delivery_history IN VARCHAR2
    ) IS
    BEGIN
        UPDATE suppliers
        SET
            lead_time = p_lead_time,
            delivery_history = p_delivery_history
        WHERE
            supplier_id = p_supplier_id;

    END update_supplier;

    PROCEDURE delete_supplier (
        p_supplier_id IN NUMBER
    ) IS
    BEGIN
        DELETE FROM suppliers
        WHERE
            supplier_id = p_supplier_id;

    END delete_supplier;

    PROCEDURE get_supplier (
        p_supplier_id IN NUMBER
    ) IS
        v_lead_time        NUMBER;
        v_delivery_history VARCHAR2(125);
    BEGIN
        SELECT
            lead_time,
            delivery_history
        INTO
            v_lead_time,
            v_delivery_history
        FROM
            suppliers
        WHERE
            supplier_id = p_supplier_id;

        dbms_output.put_line('Lead Time: '
                             || v_lead_time
                             || ', Delivery History: '
                             || v_delivery_history);
    END get_supplier;

    -- ### Sales Transactions CRUD Operations ###
    PROCEDURE add_sale (
        p_transaction_id IN NUMBER,
        p_product_id     IN NUMBER,
        p_store_id       IN NUMBER,
        p_quantity_sold  IN NUMBER,
        p_sale_date      IN DATE
    ) IS
    BEGIN
        INSERT INTO salestransactions (
            transaction_id,
            product_id,
            store_id,
            quantity_sold,
            sale_date
        ) VALUES (
            p_transaction_id,
            p_product_id,
            p_store_id,
            p_quantity_sold,
            p_sale_date
        );

    END add_sale;

    PROCEDURE update_sale (
        p_transaction_id IN NUMBER,
        p_quantity_sold  IN NUMBER,
        p_sale_date      IN DATE
    ) IS
    BEGIN
        UPDATE salestransactions
        SET
            quantity_sold = p_quantity_sold,
            sale_date = p_sale_date
        WHERE
            transaction_id = p_transaction_id;

    END update_sale;

    PROCEDURE delete_sale (
        p_transaction_id IN NUMBER
    ) IS
    BEGIN
        DELETE FROM salestransactions
        WHERE
            transaction_id = p_transaction_id;

    END delete_sale;

    PROCEDURE get_sale (
        p_transaction_id IN NUMBER
    ) IS
        v_quantity_sold NUMBER;
        v_sale_date     DATE;
    BEGIN
        SELECT
            quantity_sold,
            sale_date
        INTO
            v_quantity_sold,
            v_sale_date
        FROM
            salestransactions
        WHERE
            transaction_id = p_transaction_id;

        dbms_output.put_line('Quantity Sold: '
                             || v_quantity_sold
                             || ', Sale Date: '
                             || to_char(v_sale_date, 'YYYY-MM-DD'));

    END get_sale;

    -- ### Utility Procedures for Business Rules ###
    PROCEDURE enforce_stock_level (
        p_product_id    IN NUMBER,
        p_store_id      IN NUMBER,
        p_quantity_sold IN NUMBER
    ) IS
        v_stock_level NUMBER;
    BEGIN
        SELECT
            stock_level
        INTO v_stock_level
        FROM
            inventory
        WHERE
                product_id = p_product_id
            AND store_id = p_store_id;

        IF v_stock_level < p_quantity_sold THEN
            raise_application_error(-20001, 'Insufficient stock for this transaction.');
        END IF;
    END enforce_stock_level;

END g3_inventory_pkg;
/



--Milestone 1 Questions answer

/* Patterns in Product Demand Across Regions and Seasons: Aggregate sales data by region and season to identify demand patterns.*/
SELECT
    store_id,
    EXTRACT(MONTH FROM sale_date) AS month,
    SUM(quantity_sold)            AS total_sold
FROM
    salestransactions
GROUP BY
    store_id,
    EXTRACT(MONTH FROM sale_date)
ORDER BY
    store_id,
    month;

/*Predict Stock Shortages Before They Occur: Implement a procedure to check stock levels and compare them with historical average sales. If stock is below a threshold, trigger a reorder.*/
CREATE OR REPLACE PROCEDURE predict_stock_shortage (
    p_product_id IN NUMBER,
    p_store_id   IN NUMBER
) IS
    v_avg_sales   NUMBER;
    v_stock_level NUMBER;
BEGIN
       -- Calculate average monthly sales for the product
    SELECT
        AVG(quantity_sold)
    INTO v_avg_sales
    FROM
        salestransactions
    WHERE
            product_id = p_product_id
        AND store_id = p_store_id;
       -- Check current stock level
    SELECT
        stock_level
    INTO v_stock_level
    FROM
        inventory
    WHERE
            product_id = p_product_id
        AND store_id = p_store_id;
       -- Output message if stock level is below the average monthly sales
    IF v_stock_level < v_avg_sales THEN
        dbms_output.put_line('Stock level is low. Consider reordering.');
    END IF;
END;
/
/*Factors Contributing to Overstock Situations: Identify products with low sales but high stock levels to locate overstock.*/
SELECT
    i.product_id,
    i.store_id,
    i.stock_level,
    coalesce(SUM(st.quantity_sold),
             0) AS total_sold
FROM
    inventory         i
    LEFT JOIN salestransactions st ON i.product_id = st.product_id
                                      AND i.store_id = st.store_id
GROUP BY
    i.product_id,
    i.store_id,
    i.stock_level
HAVING
    i.stock_level > 1.5 * coalesce(SUM(st.quantity_sold),
                                   1);
/*Optimize Reorder Points for Product Categories: Calculate average lead times from suppliers and use historical sales to determine reorder points.*/
SELECT
    st.product_id,
    AVG(s.lead_time)                         AS avg_lead_time,
    AVG(st.quantity_sold) * AVG(s.lead_time) AS reorder_point
FROM
         salestransactions st
    JOIN suppliers s ON st.product_id = s.product_id
GROUP BY
    st.product_id;

/*Impact of Inaccurate Inventory Data on Sales Performance: Query to identify cases where a sale could not be completed due to low or inaccurate stock levels.*/
SELECT
    st.transaction_id,
    st.product_id,
    st.store_id,
    st.quantity_sold,
    i.stock_level
FROM
         salestransactions st
    JOIN inventory i ON st.product_id = i.product_id
                        AND st.store_id = i.store_id
WHERE
    i.stock_level < st.quantity_sold;
/*Improve Supplier Lead Time Estimates: Calculate lead time average for each supplier based on historical deliveries.*/
SELECT
    supplier_id,
    product_id,
    AVG(lead_time) AS avg_lead_time
FROM
    suppliers
GROUP BY
    supplier_id,
    product_id;
/*Products with Highest Return Rates and Their Impact on Inventory: Track return rates and identify products with high return rates.*/
SELECT
    product_id,
    COUNT(*) AS return_count
FROM
    salestransactions
WHERE
    quantity_sold < 0
GROUP BY
    product_id
ORDER BY
    return_count DESC;

/*Reduce Time to Restock Shelves After Sell-Outs : Identify products with low stock and flag for immediate restock based on supplier lead times.*/
CREATE OR REPLACE PROCEDURE restock_recommendation (
    p_product_id IN NUMBER,
    p_store_id   IN NUMBER
) IS
    v_lead_time   NUMBER;
    v_stock_level NUMBER;
BEGIN
       -- Fetch supplier lead time for product
    SELECT
        AVG(lead_time)
    INTO v_lead_time
    FROM
        suppliers
    WHERE
        product_id = p_product_id;
       -- Get current stock level
    SELECT
        stock_level
    INTO v_stock_level
    FROM
        inventory
    WHERE
            product_id = p_product_id
        AND store_id = p_store_id;

    IF v_stock_level = 0 THEN
        dbms_output.put_line('Restock recommended for Product '
                             || p_product_id
                             || ' at Store '
                             || p_store_id);
    END IF;

END;
/
/*Identify Slow-Moving Items and Adjust Stock Levels: Query to find products with minimal sales over a given period.*/

SELECT
    product_id,
    store_id,
    SUM(quantity_sold) AS total_sold
FROM
    salestransactions
WHERE
    sale_date > add_months(sysdate, - 6)
GROUP BY
    product_id,
    store_id
HAVING
    SUM(quantity_sold) < 10;

/*Impact of Return Rates on Inventory Management: Calculate the percentage of returns relative to total sales for each product.*/
SELECT
    product_id,
    SUM(
        CASE
            WHEN quantity_sold < 0 THEN
                abs(quantity_sold)
            ELSE
                0
        END
    ) / SUM(abs(quantity_sold)) * 100 AS return_rate
FROM
    salestransactions
GROUP BY
    product_id
HAVING
    SUM(
        CASE
            WHEN quantity_sold < 0 THEN
                abs(quantity_sold)
            ELSE
                0
        END
    ) / SUM(abs(quantity_sold)) * 100 > 5;