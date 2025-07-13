/*Patterns in Product Demand Across Regions and Seasons: Aggregate sales data by region and season to identify demand patterns.*/
SELECT Store_ID, EXTRACT(MONTH FROM Sale_Date) AS Month, 
SUM(Quantity_Sold) AS Total_Sold
FROM SalesTransactions
GROUP BY Store_ID, EXTRACT(MONTH FROM Sale_Date)
ORDER BY Store_ID, Month;
/*Predict Stock Shortages Before They Occur: Implement a procedure to check stock levels and compare them with historical average sales. If stock is below a threshold, trigger a reorder.*/
CREATE OR REPLACE PROCEDURE predict_stock_shortage(p_product_id IN NUMBER, p_store_id IN NUMBER) IS
       v_avg_sales NUMBER;
       v_stock_level NUMBER;
   BEGIN
       -- Calculate average monthly sales for the product
       SELECT AVG(Quantity_Sold) INTO v_avg_sales
       FROM SalesTransactions
       WHERE Product_ID = p_product_id AND Store_ID = p_store_id;
       -- Check current stock level
       SELECT Stock_Level INTO v_stock_level
       FROM Inventory
       WHERE Product_ID = p_product_id AND Store_ID = p_store_id;
       -- Output message if stock level is below the average monthly sales
       IF v_stock_level < v_avg_sales THEN
           DBMS_OUTPUT.PUT_LINE('Stock level is low. Consider reordering.');
       END IF;
   END;
   /
/*Factors Contributing to Overstock Situations: Identify products with low sales but high stock levels to locate overstock.*/
 SELECT i.Product_ID, i.Store_ID, i.Stock_Level, COALESCE(SUM(st.Quantity_Sold), 0) AS Total_Sold
   FROM Inventory i
   LEFT JOIN SalesTransactions st ON i.Product_ID = st.Product_ID AND i.Store_ID = st.Store_ID
   GROUP BY i.Product_ID, i.Store_ID, i.Stock_Level
   HAVING i.Stock_Level > 1.5 * COALESCE(SUM(st.Quantity_Sold), 1);
/*Optimize Reorder Points for Product Categories: Calculate average lead times from suppliers and use historical sales to determine reorder points.*/
SELECT Product_ID, AVG(Lead_Time) AS Avg_Lead_Time, 
AVG(Quantity_Sold) * AVG(Lead_Time) AS Reorder_Point
FROM SalesTransactions st
JOIN Suppliers s ON st.Product_ID = s.Product_ID
   GROUP BY Product_ID;
/*Impact of Inaccurate Inventory Data on Sales Performance: Query to identify cases where a sale could not be completed due to low or inaccurate stock levels.*/
SELECT st.Transaction_ID, st.Product_ID, st.Store_ID, 
st.Quantity_Sold, i.Stock_Level
FROM SalesTransactions st
JOIN Inventory i ON st.Product_ID = i.Product_ID AND st.Store_ID 
= i.Store_ID
WHERE i.Stock_Level < st.Quantity_Sold;
/*Improve Supplier Lead Time Estimates: Calculate the lead time average for each supplier based on historical deliveries.*/
SELECT Supplier_ID, Product_ID, AVG(Lead_Time) AS Avg_Lead_Time
FROM Suppliers
GROUP BY Supplier_ID, Product_ID;
/*Products with Highest Return Rates and Their Impact on Inventory: Track return rates and identify products with high return rates.*/
   SELECT Product_ID, COUNT(*) AS Return_Count
   FROM SalesTransactions
   WHERE Quantity_Sold < 0
   GROUP BY Product_ID
   ORDER BY Return_Count DESC;
/*Reduce Time to Restock Shelves After Sell-Outs: Identify products with low stock and flag for immediate restocking based on supplier lead times.*/
   CREATE OR REPLACE PROCEDURE restock_recommendation(p_product_id IN NUMBER, p_store_id IN NUMBER) IS
       v_lead_time NUMBER;
       v_stock_level NUMBER;
   BEGIN
       -- Fetch supplier lead time for product
       SELECT AVG(Lead_Time) INTO v_lead_time
       FROM Suppliers
       WHERE Product_ID = p_product_id;
       -- Get current stock level
       SELECT Stock_Level INTO v_stock_level
       FROM Inventory
       WHERE Product_ID = p_product_id AND Store_ID = p_store_id;
       IF v_stock_level = 0 THEN
           DBMS_OUTPUT.PUT_LINE('Restock recommended for Product ' || p_product_id || ' at Store ' || p_store_id);
       END IF;
   END;
   /
/*Identify Slow-Moving Items and Adjust Stock Levels: Query to find products with minimal sales over a given period.*/
   SELECT Product_ID, Store_ID, SUM(Quantity_Sold) AS Total_Sold
   FROM SalesTransactions
   WHERE Sale_Date > ADD_MONTHS(SYSDATE, -6)
   GROUP BY Product_ID, Store_ID
   HAVING SUM(Quantity_Sold) < 10;
/*Impact of Return Rates on Inventory Management: Calculate the percentage of returns relative to total sales for each product.*/
   SELECT Product_ID,
          SUM(CASE WHEN Quantity_Sold < 0 THEN ABS(Quantity_Sold) ELSE 0 END) / SUM(ABS(Quantity_Sold)) * 100 AS Return_Rate
   FROM SalesTransactions
   GROUP BY Product_ID
   HAVING Return_Rate > 5;

