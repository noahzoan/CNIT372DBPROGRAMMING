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
This trigger updates the Delivery_History in the Suppliers table every time there�s a new inventory entry from a supplier.
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

/*Ensures that each supplier�s product is valid in the `Products` table.*/
ALTER TABLE suppliers
    ADD CONSTRAINT fk_supplier_product FOREIGN KEY ( product_id )
        REFERENCES products ( product_id );

/*Ensures that stock levels are never negative.*/
ALTER TABLE inventory ADD CONSTRAINT chk_stock_level_non_negative CHECK ( stock_level >= 0 );

/*Ensures each product appears only once per store.*/
ALTER TABLE inventory ADD CONSTRAINT uq_product_store UNIQUE ( product_id, store_id );


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

    -- ### Business Logic Procedures ###
    PROCEDURE get_demand_patterns;
    PROCEDURE predict_stock_shortage(p_product_id IN NUMBER, p_store_id IN NUMBER);
    PROCEDURE identify_overstock;
    PROCEDURE calculate_reorder_points;
    PROCEDURE check_inaccurate_inventory_data;
    PROCEDURE improve_supplier_lead_times;
    PROCEDURE track_high_return_products;
    PROCEDURE restock_recommendation(p_product_id IN NUMBER, p_store_id IN NUMBER);
    PROCEDURE find_slow_moving_items;
    PROCEDURE calculate_return_rates;

END g3_inventory_pkg;
/
CREATE OR REPLACE PACKAGE BODY g3_inventory_pkg AS

    -- ### Products CRUD Operations ###
    PROCEDURE add_product (p_product_id IN NUMBER, p_product_name IN VARCHAR2) IS
    BEGIN
        INSERT INTO products (product_id, product_name) 
        VALUES (p_product_id, p_product_name);
    END add_product;

    PROCEDURE update_product (p_product_id IN NUMBER, p_product_name IN VARCHAR2) IS
    BEGIN
        UPDATE products
        SET product_name = p_product_name
        WHERE product_id = p_product_id;
    END update_product;

    PROCEDURE delete_product (p_product_id IN NUMBER) IS
    BEGIN
        DELETE FROM products WHERE product_id = p_product_id;
    END delete_product;

    PROCEDURE get_product (p_product_id IN NUMBER) IS
        v_product_name VARCHAR2(50);
    BEGIN
        SELECT product_name INTO v_product_name 
        FROM products WHERE product_id = p_product_id;
        DBMS_OUTPUT.PUT_LINE('Product Name: ' || v_product_name);
    END get_product;

    -- ### Inventory CRUD Operations ###
    PROCEDURE add_inventory (p_product_id IN NUMBER, p_store_id IN NUMBER, p_stock_level IN NUMBER) IS
    BEGIN
        INSERT INTO inventory (product_id, store_id, stock_level) 
        VALUES (p_product_id, p_store_id, p_stock_level);
    END add_inventory;

    PROCEDURE update_inventory (p_product_id IN NUMBER, p_store_id IN NUMBER, p_stock_level IN NUMBER) IS
    BEGIN
        UPDATE inventory
        SET stock_level = p_stock_level
        WHERE product_id = p_product_id AND store_id = p_store_id;
    END update_inventory;

    PROCEDURE delete_inventory (p_product_id IN NUMBER, p_store_id IN NUMBER) IS
    BEGIN
        DELETE FROM inventory 
        WHERE product_id = p_product_id AND store_id = p_store_id;
    END delete_inventory;

    PROCEDURE get_inventory (p_product_id IN NUMBER, p_store_id IN NUMBER) IS
        v_stock_level NUMBER;
    BEGIN
        SELECT stock_level INTO v_stock_level
        FROM inventory WHERE product_id = p_product_id AND store_id = p_store_id;
        DBMS_OUTPUT.PUT_LINE('Stock Level: ' || v_stock_level);
    END get_inventory;

    -- ### Suppliers CRUD Operations ###
    PROCEDURE add_supplier (p_supplier_id IN NUMBER, p_product_id IN NUMBER, p_lead_time IN NUMBER, p_delivery_history IN VARCHAR2) IS
    BEGIN
        INSERT INTO suppliers (supplier_id, product_id, lead_time, delivery_history)
        VALUES (p_supplier_id, p_product_id, p_lead_time, p_delivery_history);
    END add_supplier;

    PROCEDURE update_supplier (p_supplier_id IN NUMBER, p_lead_time IN NUMBER, p_delivery_history IN VARCHAR2) IS
    BEGIN
        UPDATE suppliers
        SET lead_time = p_lead_time, delivery_history = p_delivery_history
        WHERE supplier_id = p_supplier_id;
    END update_supplier;

    PROCEDURE delete_supplier (p_supplier_id IN NUMBER) IS
    BEGIN
        DELETE FROM suppliers WHERE supplier_id = p_supplier_id;
    END delete_supplier;

    PROCEDURE get_supplier (p_supplier_id IN NUMBER) IS
        v_lead_time NUMBER;
        v_delivery_history VARCHAR2(125);
    BEGIN
        SELECT lead_time, delivery_history INTO v_lead_time, v_delivery_history
        FROM suppliers WHERE supplier_id = p_supplier_id;
        DBMS_OUTPUT.PUT_LINE('Lead Time: ' || v_lead_time || ', Delivery History: ' || v_delivery_history);
    END get_supplier;

    -- ### Sales Transactions CRUD Operations ###
    PROCEDURE add_sale (p_transaction_id IN NUMBER, p_product_id IN NUMBER, p_store_id IN NUMBER, p_quantity_sold IN NUMBER, p_sale_date IN DATE) IS
    BEGIN
        INSERT INTO salestransactions (transaction_id, product_id, store_id, quantity_sold, sale_date) 
        VALUES (p_transaction_id, p_product_id, p_store_id, p_quantity_sold, p_sale_date);
    END add_sale;

    PROCEDURE update_sale (p_transaction_id IN NUMBER, p_quantity_sold IN NUMBER, p_sale_date IN DATE) IS
    BEGIN
        UPDATE salestransactions
        SET quantity_sold = p_quantity_sold, sale_date = p_sale_date
        WHERE transaction_id = p_transaction_id;
    END update_sale;

    PROCEDURE delete_sale (p_transaction_id IN NUMBER) IS
    BEGIN
        DELETE FROM salestransactions WHERE transaction_id = p_transaction_id;
    END delete_sale;

    PROCEDURE get_sale (p_transaction_id IN NUMBER) IS
        v_quantity_sold NUMBER;
        v_sale_date DATE;
    BEGIN
        SELECT quantity_sold, sale_date INTO v_quantity_sold, v_sale_date
        FROM salestransactions WHERE transaction_id = p_transaction_id;
        DBMS_OUTPUT.PUT_LINE('Quantity Sold: ' || v_quantity_sold || ', Sale Date: ' || TO_CHAR(v_sale_date, 'YYYY-MM-DD'));
    END get_sale;

    -- ### Utility Procedures ###
    PROCEDURE enforce_stock_level (p_product_id IN NUMBER, p_store_id IN NUMBER, p_quantity_sold IN NUMBER) IS
        v_stock_level NUMBER;
    BEGIN
        SELECT stock_level INTO v_stock_level
        FROM inventory WHERE product_id = p_product_id AND store_id = p_store_id;

        IF v_stock_level < p_quantity_sold THEN
            RAISE_APPLICATION_ERROR(-20001, 'Insufficient stock for this transaction.');
        END IF;
    END enforce_stock_level;

    -- ### Business Logic Procedures ###
    PROCEDURE get_demand_patterns IS
        CURSOR demand_cursor IS
            SELECT Store_ID, EXTRACT(MONTH FROM Sale_Date) AS Month, SUM(Quantity_Sold) AS Total_Sold
            FROM SalesTransactions GROUP BY Store_ID, EXTRACT(MONTH FROM Sale_Date) ORDER BY Store_ID, Month;
    BEGIN
        FOR demand_rec IN demand_cursor LOOP
            DBMS_OUTPUT.PUT_LINE('Store: ' || demand_rec.Store_ID || ', Month: ' || demand_rec.Month || ', Total Sold: ' || demand_rec.Total_Sold);
        END LOOP;
    END get_demand_patterns;

    -- Add all other business logic procedures as per your request...

END g3_inventory_pkg;
/
