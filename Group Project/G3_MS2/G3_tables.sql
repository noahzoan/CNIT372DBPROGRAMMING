-- Create Products table
CREATE TABLE Products (
    Product_ID INT PRIMARY KEY NOT NULL,
    Product_Name VARCHAR(50) NOT NULL
);

-- Create Inventory table
CREATE TABLE Inventory (
    Store_ID INT NOT NULL,
    Product_ID INT NOT NULL,
    Stock_Level INT NOT NULL CHECK (Stock_Level >= 0),
    Stock_Status_Date DATE NOT NULL,
    Stock_Status VARCHAR(20) NOT NULL,
    PRIMARY KEY (Store_ID, Product_ID),
    FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID)
);

-- Create Suppliers table
CREATE TABLE Suppliers (
    Supplier_ID INT PRIMARY KEY NOT NULL,
    Product_ID INT NOT NULL,
    Lead_Time INT NOT NULL CHECK (Lead_Time >= 0),
    Delivery_History VARCHAR(125),
    FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID)
);

-- Create SalesTransactions table
CREATE TABLE SalesTransactions (
    Transaction_ID INT PRIMARY KEY NOT NULL,
    Product_ID INT NOT NULL,
    Store_ID INT NOT NULL,
    Quantity_Sold INT NOT NULL CHECK (Quantity_Sold >= 0),
    Sale_Date DATE NOT NULL,
    FOREIGN KEY (Product_ID, Store_ID) REFERENCES Inventory(Product_ID, Store_ID)
);

-- 1. Insert data into Products table 
INSERT INTO Products (Product_ID, Product_Name) VALUES (101, 'Product A');
INSERT INTO Products (Product_ID, Product_Name) VALUES (102, 'Product B');
INSERT INTO Products (Product_ID, Product_Name) VALUES (103, 'Product C');
INSERT INTO Products (Product_ID, Product_Name) VALUES (104, 'Product D');
INSERT INTO Products (Product_ID, Product_Name) VALUES (105, 'Product E');
INSERT INTO Products (Product_ID, Product_Name) VALUES (106, 'Product F');
INSERT INTO Products (Product_ID, Product_Name) VALUES (107, 'Product G');
INSERT INTO Products (Product_ID, Product_Name) VALUES (108, 'Product H');
INSERT INTO Products (Product_ID, Product_Name) VALUES (109, 'Product I');
INSERT INTO Products (Product_ID, Product_Name) VALUES (110, 'Product J');
INSERT INTO Products (Product_ID, Product_Name) VALUES (111, 'Product K');
INSERT INTO Products (Product_ID, Product_Name) VALUES (112, 'Product L');
INSERT INTO Products (Product_ID, Product_Name) VALUES (113, 'Product M');
INSERT INTO Products (Product_ID, Product_Name) VALUES (114, 'Product N');
INSERT INTO Products (Product_ID, Product_Name) VALUES (115, 'Product O');
INSERT INTO Products (Product_ID, Product_Name) VALUES (116, 'Product P');
INSERT INTO Products (Product_ID, Product_Name) VALUES (117, 'Product Q');
INSERT INTO Products (Product_ID, Product_Name) VALUES (118, 'Product R');
INSERT INTO Products (Product_ID, Product_Name) VALUES (119, 'Product S');
INSERT INTO Products (Product_ID, Product_Name) VALUES (120, 'Product T');
INSERT INTO Products (Product_ID, Product_Name) VALUES (121, 'Product U');
INSERT INTO Products (Product_ID, Product_Name) VALUES (122, 'Product V');
INSERT INTO Products (Product_ID, Product_Name) VALUES (123, 'Product W');
INSERT INTO Products (Product_ID, Product_Name) VALUES (124, 'Product X');
INSERT INTO Products (Product_ID, Product_Name) VALUES (125, 'Product Y');
INSERT INTO Products (Product_ID, Product_Name) VALUES (126, 'Product Z');
INSERT INTO Products (Product_ID, Product_Name) VALUES (127, 'Product AA');
INSERT INTO Products (Product_ID, Product_Name) VALUES (128, 'Product BB');
INSERT INTO Products (Product_ID, Product_Name) VALUES (129, 'Product CC');
INSERT INTO Products (Product_ID, Product_Name) VALUES (130, 'Product DD');
INSERT INTO Products (Product_ID, Product_Name) VALUES (131, 'Product EE');
INSERT INTO Products (Product_ID, Product_Name) VALUES (132, 'Product FF');
INSERT INTO Products (Product_ID, Product_Name) VALUES (133, 'Product GG');
INSERT INTO Products (Product_ID, Product_Name) VALUES (134, 'Product HH');
INSERT INTO Products (Product_ID, Product_Name) VALUES (135, 'Product II');
INSERT INTO Products (Product_ID, Product_Name) VALUES (136, 'Product JJ');
INSERT INTO Products (Product_ID, Product_Name) VALUES (137, 'Product KK');
INSERT INTO Products (Product_ID, Product_Name) VALUES (138, 'Product LL');
INSERT INTO Products (Product_ID, Product_Name) VALUES (139, 'Product MM');
INSERT INTO Products (Product_ID, Product_Name) VALUES (140, 'Product NN');
INSERT INTO Products (Product_ID, Product_Name) VALUES (141, 'Product OO');
INSERT INTO Products (Product_ID, Product_Name) VALUES (142, 'Product PP');
INSERT INTO Products (Product_ID, Product_Name) VALUES (143, 'Product QQ');
INSERT INTO Products (Product_ID, Product_Name) VALUES (144, 'Product RR');
INSERT INTO Products (Product_ID, Product_Name) VALUES (145, 'Product SS');
INSERT INTO Products (Product_ID, Product_Name) VALUES (146, 'Product TT');
INSERT INTO Products (Product_ID, Product_Name) VALUES (147, 'Product UU');
INSERT INTO Products (Product_ID, Product_Name) VALUES (148, 'Product VV');
INSERT INTO Products (Product_ID, Product_Name) VALUES (149, 'Product WW');
INSERT INTO Products (Product_ID, Product_Name) VALUES (150, 'Product XX');

-- 2. Insert data into Inventory table 
INSERT INTO Inventory (Store_ID, Product_ID, Stock_Level, Stock_Status_Date, Stock_Status) 
VALUES (1, 101, 150, TO_DATE('2024-09-01', 'YYYY-MM-DD'), 'In Stock');
INSERT INTO Inventory (Store_ID, Product_ID, Stock_Level, Stock_Status_Date, Stock_Status) 
VALUES (1, 102, 10, TO_DATE('2024-09-02', 'YYYY-MM-DD'), 'Low Stock');
INSERT INTO Inventory (Store_ID, Product_ID, Stock_Level, Stock_Status_Date, Stock_Status) 
VALUES (2, 103, 0, TO_DATE('2024-09-03', 'YYYY-MM-DD'), 'Out of Stock');
INSERT INTO Inventory (Store_ID, Product_ID, Stock_Level, Stock_Status_Date, Stock_Status) 
VALUES (2, 104, 300, TO_DATE('2024-09-04', 'YYYY-MM-DD'), 'In Stock');
INSERT INTO Inventory (Store_ID, Product_ID, Stock_Level, Stock_Status_Date, Stock_Status) 
VALUES (3, 105, 200, TO_DATE('2024-09-05', 'YYYY-MM-DD'), 'In Stock');
INSERT INTO Inventory (Store_ID, Product_ID, Stock_Level, Stock_Status_Date, Stock_Status) 
VALUES (3, 106, 180, TO_DATE('2024-09-06', 'YYYY-MM-DD'), 'In Stock');
INSERT INTO Inventory (Store_ID, Product_ID, Stock_Level, Stock_Status_Date, Stock_Status) 
VALUES (4, 107, 0, TO_DATE('2024-09-07', 'YYYY-MM-DD'), 'Out of Stock');
INSERT INTO Inventory (Store_ID, Product_ID, Stock_Level, Stock_Status_Date, Stock_Status) 
VALUES (4, 108, 50, TO_DATE('2024-09-08', 'YYYY-MM-DD'), 'Low Stock');
INSERT INTO Inventory (Store_ID, Product_ID, Stock_Level, Stock_Status_Date, Stock_Status) 
VALUES (5, 109, 100, TO_DATE('2024-09-09', 'YYYY-MM-DD'), 'In Stock');
INSERT INTO Inventory (Store_ID, Product_ID, Stock_Level, Stock_Status_Date, Stock_Status) 
VALUES (5, 110, 10, TO_DATE('2024-09-10', 'YYYY-MM-DD'), 'Low Stock');
INSERT INTO Inventory (Store_ID, Product_ID, Stock_Level, Stock_Status_Date, Stock_Status) 
VALUES (6, 111, 200, TO_DATE('2024-09-11', 'YYYY-MM-DD'), 'In Stock');
INSERT INTO Inventory (Store_ID, Product_ID, Stock_Level, Stock_Status_Date, Stock_Status) 
VALUES (6, 112, 0, TO_DATE('2024-09-12', 'YYYY-MM-DD'), 'Out of Stock');
INSERT INTO Inventory (Store_ID, Product_ID, Stock_Level, Stock_Status_Date, Stock_Status) 
VALUES (7, 113, 80, TO_DATE('2024-09-13', 'YYYY-MM-DD'), 'In Stock');
INSERT INTO Inventory (Store_ID, Product_ID, Stock_Level, Stock_Status_Date, Stock_Status) 
VALUES (7, 114, 120, TO_DATE('2024-09-14', 'YYYY-MM-DD'), 'In Stock');
INSERT INTO Inventory (Store_ID, Product_ID, Stock_Level, Stock_Status_Date, Stock_Status) 
VALUES (8, 115, 70, TO_DATE('2024-09-15', 'YYYY-MM-DD'), 'Low Stock');
INSERT INTO Inventory (Store_ID, Product_ID, Stock_Level, Stock_Status_Date, Stock_Status) 
VALUES (8, 116, 250, TO_DATE('2024-09-16', 'YYYY-MM-DD'), 'In Stock');
INSERT INTO Inventory (Store_ID, Product_ID, Stock_Level, Stock_Status_Date, Stock_Status) 
VALUES (9, 117, 130, TO_DATE('2024-09-17', 'YYYY-MM-DD'), 'In Stock');
INSERT INTO Inventory (Store_ID, Product_ID, Stock_Level, Stock_Status_Date, Stock_Status) 
VALUES (9, 118, 90, TO_DATE('2024-09-18', 'YYYY-MM-DD'), 'Low Stock');
INSERT INTO Inventory (Store_ID, Product_ID, Stock_Level, Stock_Status_Date, Stock_Status) 
VALUES (10, 119, 0, TO_DATE('2024-09-19', 'YYYY-MM-DD'), 'Out of Stock');
INSERT INTO Inventory (Store_ID, Product_ID, Stock_Level, Stock_Status_Date, Stock_Status) 
VALUES (10, 120, 220, TO_DATE('2024-09-20', 'YYYY-MM-DD'), 'In Stock');
INSERT INTO Inventory (Store_ID, Product_ID, Stock_Level, Stock_Status_Date, Stock_Status) 
VALUES (11, 121, 80, TO_DATE('2024-09-21', 'YYYY-MM-DD'), 'Low Stock');
INSERT INTO Inventory (Store_ID, Product_ID, Stock_Level, Stock_Status_Date, Stock_Status) 
VALUES (11, 122, 150, TO_DATE('2024-09-22', 'YYYY-MM-DD'), 'In Stock');
INSERT INTO Inventory (Store_ID, Product_ID, Stock_Level, Stock_Status_Date, Stock_Status) 
VALUES (12, 123, 50, TO_DATE('2024-09-23', 'YYYY-MM-DD'), 'Low Stock');
INSERT INTO Inventory (Store_ID, Product_ID, Stock_Level, Stock_Status_Date, Stock_Status) 
VALUES (12, 124, 90, TO_DATE('2024-09-24', 'YYYY-MM-DD'), 'In Stock');
INSERT INTO Inventory (Store_ID, Product_ID, Stock_Level, Stock_Status_Date, Stock_Status) 
VALUES (13, 125, 0, TO_DATE('2024-09-25', 'YYYY-MM-DD'), 'Out of Stock');
INSERT INTO Inventory (Store_ID, Product_ID, Stock_Level, Stock_Status_Date, Stock_Status) 
VALUES (13, 126, 200, TO_DATE('2024-09-26', 'YYYY-MM-DD'), 'In Stock');
INSERT INTO Inventory (Store_ID, Product_ID, Stock_Level, Stock_Status_Date, Stock_Status) 
VALUES (14, 127, 150, TO_DATE('2024-09-27', 'YYYY-MM-DD'), 'In Stock');
INSERT INTO Inventory (Store_ID, Product_ID, Stock_Level, Stock_Status_Date, Stock_Status) 
VALUES (14, 128, 100, TO_DATE('2024-09-28', 'YYYY-MM-DD'), 'Low Stock');
INSERT INTO Inventory (Store_ID, Product_ID, Stock_Level, Stock_Status_Date, Stock_Status) 
VALUES (15, 129, 75, TO_DATE('2024-09-29', 'YYYY-MM-DD'), 'Low Stock');
INSERT INTO Inventory (Store_ID, Product_ID, Stock_Level, Stock_Status_Date, Stock_Status) 
VALUES (15, 130, 120, TO_DATE('2024-09-30', 'YYYY-MM-DD'), 'In Stock');
INSERT INTO Inventory (Store_ID, Product_ID, Stock_Level, Stock_Status_Date, Stock_Status) 
VALUES (16, 131, 10, TO_DATE('2024-10-01', 'YYYY-MM-DD'), 'Out of Stock');
INSERT INTO Inventory (Store_ID, Product_ID, Stock_Level, Stock_Status_Date, Stock_Status) 
VALUES (16, 132, 130, TO_DATE('2024-10-02', 'YYYY-MM-DD'), 'In Stock');
INSERT INTO Inventory (Store_ID, Product_ID, Stock_Level, Stock_Status_Date, Stock_Status) 
VALUES (17, 133, 80, TO_DATE('2024-10-03', 'YYYY-MM-DD'), 'Low Stock');
INSERT INTO Inventory (Store_ID, Product_ID, Stock_Level, Stock_Status_Date, Stock_Status) 
VALUES (17, 134, 140, TO_DATE('2024-10-04', 'YYYY-MM-DD'), 'In Stock');
INSERT INTO Inventory (Store_ID, Product_ID, Stock_Level, Stock_Status_Date, Stock_Status) 
VALUES (18, 135, 110, TO_DATE('2024-10-05', 'YYYY-MM-DD'), 'In Stock');
INSERT INTO Inventory (Store_ID, Product_ID, Stock_Level, Stock_Status_Date, Stock_Status) 
VALUES (18, 136, 60, TO_DATE('2024-10-06', 'YYYY-MM-DD'), 'Low Stock');
INSERT INTO Inventory (Store_ID, Product_ID, Stock_Level, Stock_Status_Date, Stock_Status) 
VALUES (19, 137, 0, TO_DATE('2024-10-07', 'YYYY-MM-DD'), 'Out of Stock');
INSERT INTO Inventory (Store_ID, Product_ID, Stock_Level, Stock_Status_Date, Stock_Status) 
VALUES (19, 138, 200, TO_DATE('2024-10-08', 'YYYY-MM-DD'), 'In Stock');
INSERT INTO Inventory (Store_ID, Product_ID, Stock_Level, Stock_Status_Date, Stock_Status) 
VALUES (20, 139, 150, TO_DATE('2024-10-09', 'YYYY-MM-DD'), 'In Stock');
INSERT INTO Inventory (Store_ID, Product_ID, Stock_Level, Stock_Status_Date, Stock_Status) 
VALUES (20, 140, 120, TO_DATE('2024-10-10', 'YYYY-MM-DD'), 'Low Stock');
INSERT INTO Inventory (Store_ID, Product_ID, Stock_Level, Stock_Status_Date, Stock_Status) 
VALUES (21, 141, 100, TO_DATE('2024-10-11', 'YYYY-MM-DD'), 'In Stock');
INSERT INTO Inventory (Store_ID, Product_ID, Stock_Level, Stock_Status_Date, Stock_Status) 
VALUES (21, 142, 10, TO_DATE('2024-10-12', 'YYYY-MM-DD'), 'Out of Stock');
INSERT INTO Inventory (Store_ID, Product_ID, Stock_Level, Stock_Status_Date, Stock_Status) 
VALUES (22, 143, 80, TO_DATE('2024-10-13', 'YYYY-MM-DD'), 'Low Stock');
INSERT INTO Inventory (Store_ID, Product_ID, Stock_Level, Stock_Status_Date, Stock_Status) 
VALUES (22, 144, 90, TO_DATE('2024-10-14', 'YYYY-MM-DD'), 'In Stock');
INSERT INTO Inventory (Store_ID, Product_ID, Stock_Level, Stock_Status_Date, Stock_Status) 
VALUES (23, 145, 0, TO_DATE('2024-10-15', 'YYYY-MM-DD'), 'Out of Stock');
INSERT INTO Inventory (Store_ID, Product_ID, Stock_Level, Stock_Status_Date, Stock_Status) 
VALUES (23, 146, 150, TO_DATE('2024-10-16', 'YYYY-MM-DD'), 'In Stock');
INSERT INTO Inventory (Store_ID, Product_ID, Stock_Level, Stock_Status_Date, Stock_Status) 
VALUES (24, 147, 100, TO_DATE('2024-10-17', 'YYYY-MM-DD'), 'Low Stock');
INSERT INTO Inventory (Store_ID, Product_ID, Stock_Level, Stock_Status_Date, Stock_Status) 
VALUES (24, 148, 120, TO_DATE('2024-10-18', 'YYYY-MM-DD'), 'In Stock');
INSERT INTO Inventory (Store_ID, Product_ID, Stock_Level, Stock_Status_Date, Stock_Status) 
VALUES (25, 149, 70, TO_DATE('2024-10-19', 'YYYY-MM-DD'), 'Low Stock');
INSERT INTO Inventory (Store_ID, Product_ID, Stock_Level, Stock_Status_Date, Stock_Status) 
VALUES (25, 150, 50, TO_DATE('2024-10-20', 'YYYY-MM-DD'), 'Low Stock');


-- 3. Insert data into Suppliers table 
INSERT INTO Suppliers (Supplier_ID, Product_ID, Lead_Time, Delivery_History) VALUES (1, 101, 5, 'Delivered on time');
INSERT INTO Suppliers (Supplier_ID, Product_ID, Lead_Time, Delivery_History) VALUES (2, 102, 15, 'Delivered late');
INSERT INTO Suppliers (Supplier_ID, Product_ID, Lead_Time, Delivery_History) VALUES (3, 103, 7, 'Delivered on time');
INSERT INTO Suppliers (Supplier_ID, Product_ID, Lead_Time, Delivery_History) VALUES (4, 104, 20, 'Delivered late');
INSERT INTO Suppliers (Supplier_ID, Product_ID, Lead_Time, Delivery_History) VALUES (5, 105, 3, 'Delivered on time');
INSERT INTO Suppliers (Supplier_ID, Product_ID, Lead_Time, Delivery_History) VALUES (6, 106, 6, 'Delivered late');
INSERT INTO Suppliers (Supplier_ID, Product_ID, Lead_Time, Delivery_History) VALUES (7, 107, 10, 'Delivered late');
INSERT INTO Suppliers (Supplier_ID, Product_ID, Lead_Time, Delivery_History) VALUES (8, 108, 12, 'Delivered on time');
INSERT INTO Suppliers (Supplier_ID, Product_ID, Lead_Time, Delivery_History) VALUES (9, 109, 2, 'Delivered on time');
INSERT INTO Suppliers (Supplier_ID, Product_ID, Lead_Time, Delivery_History) VALUES (10, 110, 25, 'Delivered late');
INSERT INTO Suppliers (Supplier_ID, Product_ID, Lead_Time, Delivery_History) VALUES (11, 111, 4, 'Delivered on time');
INSERT INTO Suppliers (Supplier_ID, Product_ID, Lead_Time, Delivery_History) VALUES (12, 112, 18, 'Delivered late');
INSERT INTO Suppliers (Supplier_ID, Product_ID, Lead_Time, Delivery_History) VALUES (13, 113, 5, 'Delivered on time');
INSERT INTO Suppliers (Supplier_ID, Product_ID, Lead_Time, Delivery_History) VALUES (14, 114, 7, 'Delivered late');
INSERT INTO Suppliers (Supplier_ID, Product_ID, Lead_Time, Delivery_History) VALUES (15, 115, 3, 'Delivered on time');
INSERT INTO Suppliers (Supplier_ID, Product_ID, Lead_Time, Delivery_History) VALUES (16, 116, 12, 'Delivered late');
INSERT INTO Suppliers (Supplier_ID, Product_ID, Lead_Time, Delivery_History) VALUES (17, 117, 10, 'Delivered late');
INSERT INTO Suppliers (Supplier_ID, Product_ID, Lead_Time, Delivery_History) VALUES (18, 118, 6, 'Delivered late');
INSERT INTO Suppliers (Supplier_ID, Product_ID, Lead_Time, Delivery_History) VALUES (19, 119, 15, 'Delivered late');
INSERT INTO Suppliers (Supplier_ID, Product_ID, Lead_Time, Delivery_History) VALUES (20, 120, 4, 'Delivered on time');
INSERT INTO Suppliers (Supplier_ID, Product_ID, Lead_Time, Delivery_History) VALUES (21, 121, 8, 'Delivered on time');
INSERT INTO Suppliers (Supplier_ID, Product_ID, Lead_Time, Delivery_History) VALUES (22, 122, 3, 'Delivered on time');
INSERT INTO Suppliers (Supplier_ID, Product_ID, Lead_Time, Delivery_History) VALUES (23, 123, 12, 'Delivered late');
INSERT INTO Suppliers (Supplier_ID, Product_ID, Lead_Time, Delivery_History) VALUES (24, 124, 6, 'Delivered on time');
INSERT INTO Suppliers (Supplier_ID, Product_ID, Lead_Time, Delivery_History) VALUES (25, 125, 9, 'Delivered late');
INSERT INTO Suppliers (Supplier_ID, Product_ID, Lead_Time, Delivery_History) VALUES (26, 126, 4, 'Delivered on time');
INSERT INTO Suppliers (Supplier_ID, Product_ID, Lead_Time, Delivery_History) VALUES (27, 127, 13, 'Delivered late');
INSERT INTO Suppliers (Supplier_ID, Product_ID, Lead_Time, Delivery_History) VALUES (28, 128, 11, 'Delivered on time');
INSERT INTO Suppliers (Supplier_ID, Product_ID, Lead_Time, Delivery_History) VALUES (29, 129, 6, 'Delivered on time');
INSERT INTO Suppliers (Supplier_ID, Product_ID, Lead_Time, Delivery_History) VALUES (30, 130, 8, 'Delivered late');
INSERT INTO Suppliers (Supplier_ID, Product_ID, Lead_Time, Delivery_History) VALUES (31, 131, 5, 'Delivered on time');
INSERT INTO Suppliers (Supplier_ID, Product_ID, Lead_Time, Delivery_History) VALUES (32, 132, 9, 'Delivered on time');
INSERT INTO Suppliers (Supplier_ID, Product_ID, Lead_Time, Delivery_History) VALUES (33, 133, 7, 'Delivered on time');
INSERT INTO Suppliers (Supplier_ID, Product_ID, Lead_Time, Delivery_History) VALUES (34, 134, 11, 'Delivered late');
INSERT INTO Suppliers (Supplier_ID, Product_ID, Lead_Time, Delivery_History) VALUES (35, 135, 6, 'Delivered on time');
INSERT INTO Suppliers (Supplier_ID, Product_ID, Lead_Time, Delivery_History) VALUES (36, 136, 3, 'Delivered on time');
INSERT INTO Suppliers (Supplier_ID, Product_ID, Lead_Time, Delivery_History) VALUES (37, 137, 14, 'Delivered late');
INSERT INTO Suppliers (Supplier_ID, Product_ID, Lead_Time, Delivery_History) VALUES (38, 138, 10, 'Delivered on time');
INSERT INTO Suppliers (Supplier_ID, Product_ID, Lead_Time, Delivery_History) VALUES (39, 139, 5, 'Delivered on time');
INSERT INTO Suppliers (Supplier_ID, Product_ID, Lead_Time, Delivery_History) VALUES (40, 140, 9, 'Delivered late');
INSERT INTO Suppliers (Supplier_ID, Product_ID, Lead_Time, Delivery_History) VALUES (41, 141, 8, 'Delivered on time');
INSERT INTO Suppliers (Supplier_ID, Product_ID, Lead_Time, Delivery_History) VALUES (42, 142, 7, 'Delivered late');
INSERT INTO Suppliers (Supplier_ID, Product_ID, Lead_Time, Delivery_History) VALUES (43, 143, 6, 'Delivered on time');
INSERT INTO Suppliers (Supplier_ID, Product_ID, Lead_Time, Delivery_History) VALUES (44, 144, 12, 'Delivered on time');
INSERT INTO Suppliers (Supplier_ID, Product_ID, Lead_Time, Delivery_History) VALUES (45, 145, 5, 'Delivered on time');
INSERT INTO Suppliers (Supplier_ID, Product_ID, Lead_Time, Delivery_History) VALUES (46, 146, 8, 'Delivered late');
INSERT INTO Suppliers (Supplier_ID, Product_ID, Lead_Time, Delivery_History) VALUES (47, 147, 4, 'Delivered on time');
INSERT INTO Suppliers (Supplier_ID, Product_ID, Lead_Time, Delivery_History) VALUES (48, 148, 9, 'Delivered late');
INSERT INTO Suppliers (Supplier_ID, Product_ID, Lead_Time, Delivery_History) VALUES (49, 149, 11, 'Delivered on time');
INSERT INTO Suppliers (Supplier_ID, Product_ID, Lead_Time, Delivery_History) VALUES (50, 150, 7, 'Delivered late');

-- 4. Insert data into SalesTransactions table
INSERT INTO SalesTransactions (Transaction_ID, Product_ID, Store_ID, Quantity_Sold, Sale_Date) 
VALUES (1001, 101, 1, 50, TO_DATE('2024-10-01', 'YYYY-MM-DD'));
INSERT INTO SalesTransactions (Transaction_ID, Product_ID, Store_ID, Quantity_Sold, Sale_Date) 
VALUES (1002, 102, 1, 5, TO_DATE('2024-10-02', 'YYYY-MM-DD'));
INSERT INTO SalesTransactions (Transaction_ID, Product_ID, Store_ID, Quantity_Sold, Sale_Date) 
VALUES (1003, 103, 2, 30, TO_DATE('2024-10-03', 'YYYY-MM-DD'));
INSERT INTO SalesTransactions (Transaction_ID, Product_ID, Store_ID, Quantity_Sold, Sale_Date) 
VALUES (1004, 104, 2, 0, TO_DATE('2024-10-04', 'YYYY-MM-DD')); -- Stockout
INSERT INTO SalesTransactions (Transaction_ID, Product_ID, Store_ID, Quantity_Sold, Sale_Date) 
VALUES (1005, 105, 3, 100, TO_DATE('2024-10-05', 'YYYY-MM-DD'));
INSERT INTO SalesTransactions (Transaction_ID, Product_ID, Store_ID, Quantity_Sold, Sale_Date) 
VALUES (1006, 106, 3, 75, TO_DATE('2024-10-06', 'YYYY-MM-DD'));
INSERT INTO SalesTransactions (Transaction_ID, Product_ID, Store_ID, Quantity_Sold, Sale_Date) 
VALUES (1007, 107, 4, 20, TO_DATE('2024-10-07', 'YYYY-MM-DD'));
INSERT INTO SalesTransactions (Transaction_ID, Product_ID, Store_ID, Quantity_Sold, Sale_Date) 
VALUES (1008, 108, 4, 0, TO_DATE('2024-10-08', 'YYYY-MM-DD')); -- Stockout
INSERT INTO SalesTransactions (Transaction_ID, Product_ID, Store_ID, Quantity_Sold, Sale_Date) 
VALUES (1009, 109, 5, 50, TO_DATE('2024-10-09', 'YYYY-MM-DD'));
INSERT INTO SalesTransactions (Transaction_ID, Product_ID, Store_ID, Quantity_Sold, Sale_Date) 
VALUES (1010, 110, 5, 15, TO_DATE('2024-10-10', 'YYYY-MM-DD'));
INSERT INTO SalesTransactions (Transaction_ID, Product_ID, Store_ID, Quantity_Sold, Sale_Date) 
VALUES (1011, 111, 6, 45, TO_DATE('2024-10-11', 'YYYY-MM-DD'));
INSERT INTO SalesTransactions (Transaction_ID, Product_ID, Store_ID, Quantity_Sold, Sale_Date) 
VALUES (1012, 112, 6, 0, TO_DATE('2024-10-12', 'YYYY-MM-DD')); -- Stockout
INSERT INTO SalesTransactions (Transaction_ID, Product_ID, Store_ID, Quantity_Sold, Sale_Date) 
VALUES (1013, 113, 7, 75, TO_DATE('2024-10-13', 'YYYY-MM-DD'));
INSERT INTO SalesTransactions (Transaction_ID, Product_ID, Store_ID, Quantity_Sold, Sale_Date) 
VALUES (1014, 114, 7, 35, TO_DATE('2024-10-14', 'YYYY-MM-DD'));
INSERT INTO SalesTransactions (Transaction_ID, Product_ID, Store_ID, Quantity_Sold, Sale_Date) 
VALUES (1015, 115, 8, 10, TO_DATE('2024-10-15', 'YYYY-MM-DD'));
INSERT INTO SalesTransactions (Transaction_ID, Product_ID, Store_ID, Quantity_Sold, Sale_Date) 
VALUES (1016, 116, 8, 80, TO_DATE('2024-10-16', 'YYYY-MM-DD'));
INSERT INTO SalesTransactions (Transaction_ID, Product_ID, Store_ID, Quantity_Sold, Sale_Date) 
VALUES (1017, 117, 9, 50, TO_DATE('2024-10-17', 'YYYY-MM-DD'));
INSERT INTO SalesTransactions (Transaction_ID, Product_ID, Store_ID, Quantity_Sold, Sale_Date) 
VALUES (1018, 118, 9, 15, TO_DATE('2024-10-18', 'YYYY-MM-DD'));
INSERT INTO SalesTransactions (Transaction_ID, Product_ID, Store_ID, Quantity_Sold, Sale_Date) 
VALUES (1019, 119, 10, 0, TO_DATE('2024-10-19', 'YYYY-MM-DD')); -- Stockout
INSERT INTO SalesTransactions (Transaction_ID, Product_ID, Store_ID, Quantity_Sold, Sale_Date) 
VALUES (1020, 120, 10, 100, TO_DATE('2024-10-20', 'YYYY-MM-DD'));
INSERT INTO SalesTransactions (Transaction_ID, Product_ID, Store_ID, Quantity_Sold, Sale_Date) 
VALUES (1021, 121, 11, 25, TO_DATE('2024-10-21', 'YYYY-MM-DD'));
INSERT INTO SalesTransactions (Transaction_ID, Product_ID, Store_ID, Quantity_Sold, Sale_Date) 
VALUES (1022, 122, 11, 30, TO_DATE('2024-10-22', 'YYYY-MM-DD'));
INSERT INTO SalesTransactions (Transaction_ID, Product_ID, Store_ID, Quantity_Sold, Sale_Date) 
VALUES (1023, 123, 12, 50, TO_DATE('2024-10-23', 'YYYY-MM-DD'));
INSERT INTO SalesTransactions (Transaction_ID, Product_ID, Store_ID, Quantity_Sold, Sale_Date) 
VALUES (1024, 124, 12, 15, TO_DATE('2024-10-24', 'YYYY-MM-DD'));
INSERT INTO SalesTransactions (Transaction_ID, Product_ID, Store_ID, Quantity_Sold, Sale_Date) 
VALUES (1025, 125, 13, 40, TO_DATE('2024-10-25', 'YYYY-MM-DD'));
INSERT INTO SalesTransactions (Transaction_ID, Product_ID, Store_ID, Quantity_Sold, Sale_Date) 
VALUES (1026, 126, 13, 60, TO_DATE('2024-10-26', 'YYYY-MM-DD'));
INSERT INTO SalesTransactions (Transaction_ID, Product_ID, Store_ID, Quantity_Sold, Sale_Date) 
VALUES (1027, 127, 14, 75, TO_DATE('2024-10-27', 'YYYY-MM-DD'));
INSERT INTO SalesTransactions (Transaction_ID, Product_ID, Store_ID, Quantity_Sold, Sale_Date) 
VALUES (1028, 128, 14, 10, TO_DATE('2024-10-28', 'YYYY-MM-DD'));
INSERT INTO SalesTransactions (Transaction_ID, Product_ID, Store_ID, Quantity_Sold, Sale_Date) 
VALUES (1029, 129, 15, 55, TO_DATE('2024-10-29', 'YYYY-MM-DD'));
INSERT INTO SalesTransactions (Transaction_ID, Product_ID, Store_ID, Quantity_Sold, Sale_Date) 
VALUES (1030, 130, 15, 35, TO_DATE('2024-10-30', 'YYYY-MM-DD'));
INSERT INTO SalesTransactions (Transaction_ID, Product_ID, Store_ID, Quantity_Sold, Sale_Date) 
VALUES (1031, 131, 16, 20, TO_DATE('2024-10-31', 'YYYY-MM-DD'));
INSERT INTO SalesTransactions (Transaction_ID, Product_ID, Store_ID, Quantity_Sold, Sale_Date) 
VALUES (1032, 132, 16, 90, TO_DATE('2024-11-01', 'YYYY-MM-DD'));
INSERT INTO SalesTransactions (Transaction_ID, Product_ID, Store_ID, Quantity_Sold, Sale_Date) 
VALUES (1033, 133, 17, 40, TO_DATE('2024-11-02', 'YYYY-MM-DD'));
INSERT INTO SalesTransactions (Transaction_ID, Product_ID, Store_ID, Quantity_Sold, Sale_Date) 
VALUES (1034, 134, 17, 50, TO_DATE('2024-11-03', 'YYYY-MM-DD'));
INSERT INTO SalesTransactions (Transaction_ID, Product_ID, Store_ID, Quantity_Sold, Sale_Date) 
VALUES (1035, 135, 18, 35, TO_DATE('2024-11-04', 'YYYY-MM-DD'));
INSERT INTO SalesTransactions (Transaction_ID, Product_ID, Store_ID, Quantity_Sold, Sale_Date) 
VALUES (1036, 136, 18, 60, TO_DATE('2024-11-05', 'YYYY-MM-DD'));
INSERT INTO SalesTransactions (Transaction_ID, Product_ID, Store_ID, Quantity_Sold, Sale_Date) 
VALUES (1037, 137, 19, 50, TO_DATE('2024-11-06', 'YYYY-MM-DD'));
INSERT INTO SalesTransactions (Transaction_ID, Product_ID, Store_ID, Quantity_Sold, Sale_Date) 
VALUES (1038, 138, 19, 15, TO_DATE('2024-11-07', 'YYYY-MM-DD'));
INSERT INTO SalesTransactions (Transaction_ID, Product_ID, Store_ID, Quantity_Sold, Sale_Date) 
VALUES (1039, 139, 20, 70, TO_DATE('2024-11-08', 'YYYY-MM-DD'));
INSERT INTO SalesTransactions (Transaction_ID, Product_ID, Store_ID, Quantity_Sold, Sale_Date) 
VALUES (1040, 140, 20, 50, TO_DATE('2024-11-09', 'YYYY-MM-DD'));
