/*
Noah Zhou
CNIT372 Lab Section 006
Estimated Time Spent: 4 hour
Late hours used: [0]
*/

-- Question #1

SELECT ip.PartNumber, PartDescription, ROUND(AVG(OrderQuantity),1) AS AvgQuantity
FROM InventoryPart ip INNER JOIN CustOrderLine col
ON ip.PartNumber = col.PartNumber
WHERE CategoryID = 'ACCESS'
GROUP BY ip.PartNumber, PartDescription
ORDER BY AvgQuantity DESC;

/* Q1 Query Results

PARTNUMBER PARTDESCRIPTION                                    AVGQUANTITY
---------- -------------------------------------------------- -----------
MOD-001    PCI DATA/FAX/VOICE MODEM                                   8.3
MOD-002    112K DUAL MODEM                                            5.1
PRT-006    SINGLEHEAD THERMAL INKJET PRINTER                          3.8
PRT-004    3-IN-1 COLOR INKJET PRINTER                                3.6
SCN-002    SCANJET BUSINESS SERIES COLOR SCANNER                      3.5
PRT-003    LASER JET 2500SE                                           3.4
MOD-005    V.90/K56 FLEX 56K FAX MODEM                                3.1
PRT-001    LASER JET 1999SE                                           2.9
MOD-003    PCI MODEM                                                  2.4
PRT-002    LASER JET 2000SE                                           2.3
SCN-001    SCANJET CSE COLOR SCANNER                                  1.8

PARTNUMBER PARTDESCRIPTION                                    AVGQUANTITY
---------- -------------------------------------------------- -----------
MOD-004    PCI V.90 DATA/FAX/VOICE MODEM                              1.6

12 rows selected.

*/

-- Question #2A

SELECT TO_CHAR(OrderDate, 'MM') AS OrderMonth, TO_CHAR(OrderDate, 'YYYY') AS OrderYear, ROUND(AVG(OrderQuantity),1) AS AvgQuantity
FROM CustOrder co INNER JOIN CustOrderLine col
ON co.OrderID = col.OrderID
WHERE PartNumber = 'DVD-001'
GROUP BY TO_CHAR(OrderDate, 'YYYY'), TO_CHAR(OrderDate, 'MM')
ORDER BY OrderYear, OrderMonth;

/* Q2A Query Results

OR ORDE AVGQUANTITY
-- ---- -----------
07 2010         1.5
09 2010           4
10 2010           1
11 2010           2
12 2010           1
01 2011           1
02 2011           8
03 2011           1

8 rows selected.

*/

-- Question #2B
/* Q2B Non-Query Answer

Overall, the average order quantity stayed around 1 unit with a small increase
to 1.5 units in July 2010 and 2 units in November 2010. In September 2010,
there was a larger increase to an average order quantity of 4 units and in
February 2011, there was a significant increase to an average order quantity
of 8 units

*/

-- Question #3A

SELECT TO_CHAR(OrderDate, 'MM-YYYY') AS OrderMonthYear, ROUND(SUM(OrderQuantity), 1) AS TotalQuantity
FROM CustOrder co INNER JOIN CustOrderLine col
ON co.OrderID= col.OrderID
WHERE PartNumber = 'DVD-001'
GROUP BY TO_CHAR(OrderDate, 'MM-YYYY'), TO_CHAR(OrderDate, 'YYYY'), TO_CHAR(OrderDate, 'MM')
ORDER BY TO_CHAR(OrderDate, 'YYYY'), TO_CHAR(OrderDate, 'MM');

/* Q3A Query Results

ORDERMO TOTALQUANTITY
------- -------------
07-2010             3
09-2010            12
10-2010             1
11-2010             4
12-2010             3
01-2011             1
02-2011            16
03-2011             1

8 rows selected.

*/

-- Question #3B
/* Q3B Non-Query Answer

I would increase the inventory based on the trend seen in 2010 and would hold
at least 20 in reserve in case there is another large spike in orders for
DVD-001. Although it appears that there are less orders in 2011, orders could
increase as we move later in the year.

*/

-- Question #4

SELECT TO_CHAR(OrderDate, 'MM') AS OrderMonth, TO_CHAR(OrderDate, 'YYYY') AS OrderYear, COUNT(co.OrderID) AS NumberOfOrders
FROM CustOrder co INNER JOIN CustOrderLine col
ON co.OrderID = col.OrderID
WHERE PartNumber = 'DVD-001'
GROUP BY TO_CHAR(OrderDate, 'MM'), TO_CHAR(OrderDate, 'YYYY')
ORDER BY OrderYear, OrderMonth;

/* Q4 Query Result

OR ORDE NUMBEROFORDERS
-- ---- --------------
07 2010              2
09 2010              3
10 2010              1
11 2010              2
12 2010              3
01 2011              1
02 2011              2
03 2011              1

8 rows selected.


*/

-- Question #5A
/* Q5A Non-Query Answer

The shared underlying question that each part is attempting to answer is
customer demand for DVD-001 and whether there is a justification to increase
inventory in case demand rises

*/

-- Question #5B
/* Q5B Non-Query Answer

The sales vary between months, some months had a relatively small average
quantity sold as well as total quantity sold while the number of orders per
month typically was around 1-3 orders per month. 2 different months had spikes
in quantity sold but the number of orders per month remained within the typical
range.

*/

-- Question #5C
/* Q5C Non-Query Answer

The answers for each question support each other in which the total quantity
sold divided by the orders per month is the average sold per month. This
definitely increases confidence in the results

*/

-- Question #6A

SELECT s.OrderID, s.ShipmentID, si.PackageNumber, ShippedDate, ShipName, ShipAddress
FROM Shipment s INNER JOIN ShippedItem si
ON s.OrderID = si.OrderID
INNER JOIN PackingSlip ps
ON si.ShipmentID = ps.ShipmentID
WHERE si.OrderID = '2000000007';

/* Q6A Query Results

ORDERID    SHIPMENTID PACKAGENUMBER SHIPPEDDA SHIPNAME             SHIPADDRESS
---------- ---------- ------------- --------- -------------------- ----------------------------------------
2000000007 H003                   1 05-JUL-10 Evelyn Cassens       6094 Pearson Ave.
2000000007 H003                   1 05-JUL-10 Evelyn Cassens       6094 Pearson Ave.
2000000007 H003                   1 05-JUL-10 Evelyn Cassens       6094 Pearson Ave.
2000000007 H003                   2 05-JUL-10 Evelyn Cassens       6094 Pearson Ave.
2000000007 H003                   2 05-JUL-10 Evelyn Cassens       6094 Pearson Ave.
2000000007 H003                   2 05-JUL-10 Evelyn Cassens       6094 Pearson Ave.
2000000007 H003                   3 05-JUL-10 Evelyn Cassens       6094 Pearson Ave.
2000000007 H003                   3 05-JUL-10 Evelyn Cassens       6094 Pearson Ave.
2000000007 H003                   3 05-JUL-10 Evelyn Cassens       6094 Pearson Ave.

9 rows selected.

*/

-- Question 6B
/* Q6B Non-Query Answer

The results show duplicate values for packages with a number of 1, 2, and 3.
This happens because some tables might have duplicate values which cause it
to appear more than once when running a query.

*/

-- Question #7A

SELECT CustLastName ||', '|| CustFirstName AS CustName, c.CustomerID, OrderID
FROM Customer c LEFT JOIN CustOrder co
ON c.CustomerID = co.CustomerID
WHERE State = 'PA' AND CompanyName IS NULL;

/* Q7A Query Results

CUSTNAME                              CUSTOMERID ORDERID
------------------------------------- ---------- ----------
Wolfe, Thomas                         I-300149   2001000670
Wolfe, Thomas                         I-300149   2001000736
Wolfe, Thomas                         I-300149   2001000751
Wolfe, Thomas                         I-300149   2001000768
Wolfe, Thomas                         I-300149   2000000497
Kaleta, Don                           I-300028

6 rows selected.

*/

-- Question #7B

SELECT CustLastName ||', '|| CustFirstName AS CustName, c.CustomerID, OrderID
FROM Customer c RIGHT JOIN CustOrder co
ON c.CustomerID = co.CustomerID
WHERE State = 'PA' AND CompanyName IS NULL;

/* Q7B Query Results

CUSTNAME                              CUSTOMERID ORDERID
------------------------------------- ---------- ----------
Wolfe, Thomas                         I-300149   2001000670
Wolfe, Thomas                         I-300149   2001000736
Wolfe, Thomas                         I-300149   2001000751
Wolfe, Thomas                         I-300149   2001000768
Wolfe, Thomas                         I-300149   2000000497

*/

-- Question #8

SELECT PartNumber, CategoryName
FROM InventoryPart ip FULL OUTER JOIN Category c
ON ip.CategoryID = c.CategoryID


/* Q8 Query Results

PARTNUMBER CATEGORYNAME
---------- ------------------------------
ADT-001    Storage
ADT-002    Cables
ADT-003    Cables
ADT-004    Cables
ADT-005    Cables
ADT-006    Cables
ADT-007    Cables
BB-001     Basics
BB-002     Basics
BB-003     Basics
BB-004     Basics

PARTNUMBER CATEGORYNAME
---------- ------------------------------
BB-005     Basics
BRK-001    Cables
BRK-002    Cables
BRK-003    Cables
BRK-004    Cables
BRK-005    Cables
BRK-006    Cables
BRK-007    Cables
BRK-008    Cables
BRK-009    Cables
BRK-010    Cables

PARTNUMBER CATEGORYNAME
---------- ------------------------------
BRK-011    Cables
C-001      Basics
C-002      Basics
C-003      Basics
CAB-001    Cables
CAB-002    Cables
CAB-003    Cables
CAB-004    Cables
CAB-005    Cables
CAB-006    Cables
CAB-007    Cables

PARTNUMBER CATEGORYNAME
---------- ------------------------------
CAB-008    Cables
CAB-009
CAB-010
CAB-011
CAB-012
CAB-013
CAB-014
CAB-015
CAB-016
CAB-017
CAB-018

PARTNUMBER CATEGORYNAME
---------- ------------------------------
CAB-019
CAB-020
CAB-021
CAB-022
CAB-023
CAB-024
CAB-025
CAB-026
CAB-027
CAB-028
CD-001     Storage

PARTNUMBER CATEGORYNAME
---------- ------------------------------
CD-002     Storage
CD-003     Storage
CD-004     Storage
CF-001     Processors
CF-002     Processors
CF-003     Processors
CF-004     Processors
CF-005     Processors
CF-006     Processors
CF-007     Processors
CF-008     Processors

PARTNUMBER CATEGORYNAME
---------- ------------------------------
CF-009     Processors
CRD-001
CRD-002
CRD-003
CRD-004
CRD-005
CRD-006
CRD-007
CRD-008
CRD-009
CTR-001    Computers

PARTNUMBER CATEGORYNAME
---------- ------------------------------
CTR-002    Computers
CTR-003    Computers
CTR-004    Computers
CTR-005    Computers
CTR-006    Computers
CTR-007    Computers
CTR-008    Computers
CTR-009    Computers
CTR-010    Computers
CTR-011    Computers
CTR-012    Computers

PARTNUMBER CATEGORYNAME
---------- ------------------------------
CTR-013    Computers
CTR-014    Computers
CTR-015    Computers
CTR-016    Computers
CTR-017    Computers
CTR-018    Computers
CTR-019    Computers
CTR-020    Computers
CTR-021    Computers
CTR-022    Computers
CTR-023    Computers

PARTNUMBER CATEGORYNAME
---------- ------------------------------
CTR-024    Computers
CTR-025    Computers
CTR-026    Computers
CTR-027    Computers
CTR-028    Computers
CTR-029    Computers
DVD-001    Storage
DVD-002    Storage
ICAB-001   Cables
ICAB-002   Cables
ICAB-003   Cables

PARTNUMBER CATEGORYNAME
---------- ------------------------------
ICAB-004   Cables
ICAB-005   Cables
ICAB-006   Cables
ICAB-007   Cables
ICAB-008   Cables
KEY-001    Basics
KEY-002    Basics
KEY-003    Basics
KEY-004    Basics
KEY-005    Basics
KEY-006    Basics

PARTNUMBER CATEGORYNAME
---------- ------------------------------
KEY-007    Basics
KEY-008    Basics
KEY-009    Basics
MEM-001    Storage
MEM-002    Storage
MEM-003    Storage
MEM-004    Storage
MEM-005    Storage
MEM-006    Storage
MEM-007    Storage
MEM-008    Storage

PARTNUMBER CATEGORYNAME
---------- ------------------------------
MEM-009    Storage
MEM-010    Storage
MEM-011    Storage
MEM-012    Storage
MIC-001    Basics
MIC-002    Basics
MIC-003    Basics
MIC-004    Basics
MIC-005    Basics
MIC-006    Basics
MIC-007    Basics

PARTNUMBER CATEGORYNAME
---------- ------------------------------
MIC-008    Basics
MIC-009    Basics
MIC-010    Basics
MIC-011    Basics
MIC-012    Basics
MOD-001    Accessories
MOD-002    Accessories
MOD-003    Accessories
MOD-004    Accessories
MOD-005    Accessories
MOM-001    Basics

PARTNUMBER CATEGORYNAME
---------- ------------------------------
MOM-002    Basics
MOM-003    Basics
MOM-004    Basics
MON-001    Basics
MON-002    Basics
MON-003    Basics
MON-004    Basics
MON-005    Basics
MON-006    Basics
MON-007    Basics
MON-008    Basics

PARTNUMBER CATEGORYNAME
---------- ------------------------------
P-001      Processors
P-002      Processors
P-003      Processors
P-004      Processors
P-005      Processors
P-006      Processors
P-007      Processors
P-008      Processors
P-009      Processors
P-010      Processors
POW-001    Cables

PARTNUMBER CATEGORYNAME
---------- ------------------------------
POW-002    Cables
POW-003    Cables
PRT-001    Accessories
PRT-002    Accessories
PRT-003    Accessories
PRT-004    Accessories
PRT-005    Accessories
PRT-006    Accessories
PS-001     Power
PS-002     Power
PS-003     Power

PARTNUMBER CATEGORYNAME
---------- ------------------------------
PS-004     Power
SCN-001    Accessories
SCN-002    Accessories
SCN-003    Accessories
SFT-001    Software
SFT-002    Software
SFT-003    Software
SFT-004    Software
SFT-005    Software
SFT-006    Software
SFT-007    Software

PARTNUMBER CATEGORYNAME
---------- ------------------------------
SFT-008    Software
SFT-009    Software
SP-001     Basics
SP-002     Basics
SP-003     Basics
           Tablets

204 rows selected.

*/

-- Question #9A

SELECT CustFirstName ||' '|| CustLastName AS CustName, c.CustomerID, OrderDate, s.ShipmentID, si.PackageNumber, ShipName, ShippedDate
FROM Customer c LEFT JOIN CustOrder co
ON c.CustomerID = co.CustomerID
LEFT JOIN Shipment s
ON co.OrderID = s.OrderID
LEFT JOIN ShippedItem si
ON s.ShipmentID = si.ShipmentID
LEFT JOIN PackingSlip ps
ON si.PackageNumber = ps.PackageNumber
WHERE s.OrderID = '2001000807';

/* Q9A Query Results

CUSTNAME                             CUSTOMERID ORDERDATE SHIPMENTID PACKAGENUMBER SHIPNAME             SHIPPEDDA
------------------------------------ ---------- --------- ---------- ------------- -------------------- ---------
Cecil Scheetz                        C-300003   31-MAR-11 H384                     Cecil Scheetz

*/

-- Question #9B

SELECT CustFirstName ||' '|| CustLastName AS CustName, c.CustomerID, OrderDate, s.ShipmentID, ShipName, ShippedDate
FROM Customer c LEFT JOIN CustOrder co
ON c.CustomerID = co.CustomerID
LEFT JOIN Shipment s
ON co.OrderID = s.OrderID
LEFT JOIN ShippedItem si
ON s.ShipmentID = si.ShipmentID
LEFT JOIN PackingSlip ps
ON si.PackageNumber = ps.PackageNumber
WHERE ShippedDate IS NULL;

/* Q9B Query Results

CUSTNAME                             CUSTOMERID ORDERDATE SHIPMENTID SHIPNAME             SHIPPEDDA
------------------------------------ ---------- --------- ---------- -------------------- ---------
Mary Jo Wales                        I-300125   30-MAR-11 L261       Mary Jo Wales
Sean Akropolis                       I-300116   27-MAR-11 L256       Sean Akropolis
Orville Gilliland                    C-300069   30-MAR-11 H381       Orville Gilliland
Chris Dunlap                         I-300100   07-OCT-10 L094       Chris Dunlap
Verna McGrew                         I-300069   27-MAR-11 L257       Verna McGrew
Shirley Osborne                      I-300013   30-MAR-11 M161       Shirley Osborne
Zack Hill                            I-300120   23-FEB-11 M129       Zack Hill
Archie Doremski                      C-300032   29-MAR-11 H380       Archie Doremski
Louise Cool                          I-300044   13-MAR-11 M147       Louise Cool
Daniel Rodkey                        I-300141   31-MAR-11 L262       Daniel Rodkey
Larry Osmanova                       C-300026   30-MAR-11 H382       Larry Osmanova

CUSTNAME                             CUSTOMERID ORDERDATE SHIPMENTID SHIPNAME             SHIPPEDDA
------------------------------------ ---------- --------- ---------- -------------------- ---------
Rachel Davis                         I-300107
Bob Weldy                            I-300136
Don Kaleta                           I-300028
Tonya Owens                          I-300057
Christina Wilson                     I-300079
Randolph Darling                     I-300113
Andy Huegel                          I-300151   31-MAR-11 M162       Andy Huegel
Marjorie Vandermay                   C-300045   31-MAR-11 H383       Marjorie Vandermay
Steven Yaun                          I-300147   27-MAR-11 L258       Michelle Oakley
Cecil Scheetz                        C-300003   31-MAR-11 H384       Cecil Scheetz
Joan Hedden                          I-300024   01-MAR-11 M137       Joan Hedden

CUSTNAME                             CUSTOMERID ORDERDATE SHIPMENTID SHIPNAME             SHIPPEDDA
------------------------------------ ---------- --------- ---------- -------------------- ---------
Phil Reece                           I-300154   29-MAR-11 M159       Phil Reece
Karen Mangus                         I-300015   29-MAR-11 M160       Karen Mangus
Tom Baker                            I-300134   29-MAR-11 L259       Tom Baker
Charles Jones                        I-300087   30-MAR-11 L260       Charles Jones

26 rows selected.

*/

-- Question #10A

SELECT CustomerID
FROM Customer
WHERE State = 'PA'
INTERSECT
SELECT CustomerID
FROM CustOrder;

/* Q10A Query Results

CUSTOMERID
----------
C-300006
C-300040
C-300062
I-300149

*/

-- Question #10B

SELECT CustomerID
FROM Customer
WHERE State = 'PA'
MINUS
SELECT CustomerID
FROM CustOrder;

/* Q10B Query Results

CUSTOMERID
----------
I-300028

*/

-- Question #10C

SELECT CustomerID
FROM Customer
WHERE State = 'PA'
INTERSECT
SELECT CustomerID
FROM CustOrder
WHERE TO_CHAR(OrderDate, 'YY') = '11';

/* Q10C Query Results

CUSTOMERID
----------
C-300006
C-300040
I-300149

*/

-- Question #10D

SELECT CustomerID
FROM Customer
WHERE State = 'PA'
MINUS
SELECT CustomerID
FROM CustOrder
WHERE TO_CHAR(OrderDate, 'YY') = '11';

/* Q10D Query Results

CUSTOMERID
----------
C-300062
I-300028

*/

-- Question #11A

SELECT DISTINCT PartNumber
FROM InventoryPart
WHERE CategoryID = 'CAB'
INTERSECT
SELECT DISTINCT PartNumber
FROM CustOrderLine
WHERE OrderQuantity >= '1';

/* Q11A Query Results

PARTNUMBER
----------
ADT-003
ADT-004
ADT-005
ADT-006
ADT-007
BRK-001
BRK-002
BRK-003
BRK-004
BRK-005
BRK-007

PARTNUMBER
----------
BRK-008
BRK-009
BRK-010
BRK-011
CAB-001
CAB-003
CAB-005
CAB-006
CAB-007
CAB-008
ICAB-001

PARTNUMBER
----------
ICAB-002
ICAB-003
ICAB-004
ICAB-005
ICAB-006
ICAB-007
ICAB-008
POW-002
POW-003

31 rows selected.

*/

-- Question #11B

SELECT DISTINCT PartNumber
FROM InventoryPart
WHERE CategoryID = 'CAB'
MINUS
SELECT DISTINCT PartNumber
FROM CustOrderLine
WHERE OrderQuantity >= '1';

/* Q11B Query Results

PARTNUMBER
----------
ADT-002
BRK-006
CAB-002
CAB-004
POW-001

*/

-- Question #11C

SELECT DISTINCT PartNumber
FROM InventoryPart
WHERE CategoryID = 'CAB'
INTERSECT
SELECT DISTINCT PartNumber
FROM CustOrderLine col INNER JOIN CustOrder co
ON col.OrderID = co.OrderID
WHERE OrderQuantity >= '1' AND TO_CHAR(OrderDate, 'YY') >= '10';


/* Q11C Query Results

PARTNUMBER
----------
ADT-003
ADT-004
ADT-005
ADT-006
ADT-007
BRK-001
BRK-002
BRK-003
BRK-004
BRK-005
BRK-007

PARTNUMBER
----------
BRK-008
BRK-009
BRK-010
BRK-011
CAB-001
CAB-003
CAB-005
CAB-006
CAB-007
CAB-008
ICAB-001

PARTNUMBER
----------
ICAB-002
ICAB-003
ICAB-004
ICAB-005
ICAB-006
ICAB-007
ICAB-008
POW-002
POW-003

31 rows selected.

*/

-- Question #11D

SELECT DISTINCT PartNumber
FROM InventoryPart
WHERE CategoryID = 'CAB'
MINUS
SELECT DISTINCT PartNumber
FROM CustOrderLine col INNER JOIN CustOrder co
ON col.OrderID = co.OrderID
WHERE OrderQuantity >= '1' AND TO_CHAR(OrderDate, 'YY') >= '10';


/* Q11D Query Results

PARTNUMBER
----------
ADT-002
BRK-006
CAB-002
CAB-004
POW-001

*/

-- Question #12A

SELECT CustFirstName, CustLastName
FROM Customer
WHERE State = 'FL'
UNION
SELECT FirstName, LastName
FROM Employee
ORDER BY CustFirstName, CustLastName;

/* Q12A Query Results

CUSTFIRSTNAME   CUSTLASTNAME
--------------- --------------------
Allison         Roland
Austin          Ortman
Beth            Zobitz
Calie           Zollman
Charles         Jones
David           Deppe
David           Keck
Edna            Lilley
Gabrielle       Stevenson
Gary            German
Gregory         Hettinger

CUSTFIRSTNAME   CUSTLASTNAME
--------------- --------------------
Jack            Barrick
Jack            Brose
Jamie           Osman
Jason           Krasner
Jason           Wendling
Jim             Manaugh
Joanne          Rosner
Joseph          Platt
Karen           Mangus
Kathleen        Xolo
Kathryn         Deagen

CUSTFIRSTNAME   CUSTLASTNAME
--------------- --------------------
Kathy           Gunderson
Kelly           Jordan
Kristen         Gustavel
Kristey         Moore
Kristy          Moore
Laura           Rodgers
Marla           Reeder
Meghan          Tyrie
Melissa         Alvarez
Michael         Abbott
Michael         Emore

CUSTFIRSTNAME   CUSTLASTNAME
--------------- --------------------
Michelle        Nairn
Nicholas        Albregts
Patricha        Underwood
Paul            Eckelman
Phil            Reece
Rita            Bush
Ronald          Day
Ryan            Stahley
Sherman         Cheswick
Steve           Cochran
Steve           Hess

CUSTFIRSTNAME   CUSTLASTNAME
--------------- --------------------
Steven          Hickman
Tina            Yates
Todd            Vigus

47 rows selected.

*/

-- Question #12B

SELECT CustFirstName, CustLastName
FROM Customer
WHERE State = 'FL'
UNION ALL
SELECT FirstName, LastName
FROM Employee
ORDER BY CustFirstName, CustLastName;

/* Q12B Query Results

CUSTFIRSTNAME   CUSTLASTNAME
--------------- --------------------
Allison         Roland
Allison         Roland
Austin          Ortman
Beth            Zobitz
Calie           Zollman
Charles         Jones
Charles         Jones
David           Deppe
David           Keck
Edna            Lilley
Gabrielle       Stevenson

CUSTFIRSTNAME   CUSTLASTNAME
--------------- --------------------
Gary            German
Gregory         Hettinger
Jack            Barrick
Jack            Brose
Jamie           Osman
Jason           Krasner
Jason           Wendling
Jim             Manaugh
Jim             Manaugh
Joanne          Rosner
Joseph          Platt

CUSTFIRSTNAME   CUSTLASTNAME
--------------- --------------------
Karen           Mangus
Kathleen        Xolo
Kathryn         Deagen
Kathy           Gunderson
Kelly           Jordan
Kristen         Gustavel
Kristey         Moore
Kristy          Moore
Laura           Rodgers
Marla           Reeder
Meghan          Tyrie

CUSTFIRSTNAME   CUSTLASTNAME
--------------- --------------------
Melissa         Alvarez
Michael         Abbott
Michael         Emore
Michelle        Nairn
Nicholas        Albregts
Patricha        Underwood
Paul            Eckelman
Phil            Reece
Phil            Reece
Rita            Bush
Ronald          Day

CUSTFIRSTNAME   CUSTLASTNAME
--------------- --------------------
Ryan            Stahley
Ryan            Stahley
Sherman         Cheswick
Steve           Cochran
Steve           Hess
Steven          Hickman
Tina            Yates
Todd            Vigus

52 rows selected.

*/

-- Question #13A

SELECT CustFirstName ||' '|| CustLastName || ', Residential' AS CustName, c.CustomerID, OrderID, OrderDate
FROM Customer c LEFT JOIN CustOrder co
ON c.CustomerID = co.CustomerID
WHERE State = 'PA' AND CompanyName IS NULL
UNION
SELECT CustFirstName ||' '|| CustLastName ||', '|| CompanyName AS CustName, c.CustomerID, OrderID, OrderDate
FROM Customer c LEFT JOIN CustOrder co
ON c.CustomerID = co.CustomerID
WHERE State = 'PA' AND CompanyName IS NOT NULL
ORDER BY CustomerID, OrderID;

/* Q13A Query Results

CUSTNAME                                                                       CUSTOMERID ORDERID    ORDERDATE
------------------------------------------------------------------------------ ---------- ---------- ---------
George Purcell, BMA Advertising Design                                         C-300006   2000000050 26-JUL-10
George Purcell, BMA Advertising Design                                         C-300006   2000000083 10-AUG-10
George Purcell, BMA Advertising Design                                         C-300006   2000000110 20-AUG-10
George Purcell, BMA Advertising Design                                         C-300006   2000000130 27-AUG-10
George Purcell, BMA Advertising Design                                         C-300006   2000000355 01-DEC-10
George Purcell, BMA Advertising Design                                         C-300006   2001000643 17-FEB-11
George Purcell, BMA Advertising Design                                         C-300006   2001000729 07-MAR-11
Mildred Jones, Computer Consultants                                            C-300040   2000000012 06-JUL-10
Mildred Jones, Computer Consultants                                            C-300040   2000000284 02-NOV-10
Mildred Jones, Computer Consultants                                            C-300040   2001000721 03-MAR-11
Mildred Jones, Computer Consultants                                            C-300040   2001000782 23-MAR-11

CUSTNAME                                                                       CUSTOMERID ORDERID    ORDERDATE
------------------------------------------------------------------------------ ---------- ---------- ---------
Scott Gray, Security Installation                                              C-300062   2000000361 01-DEC-10
Scott Gray, Security Installation                                              C-300062   2000000421 10-DEC-10
Scott Gray, Security Installation                                              C-300062   2000000440 14-DEC-10
Scott Gray, Security Installation                                              C-300062   2000000496 17-DEC-10
Don Kaleta, Residential                                                        I-300028
Thomas Wolfe, Residential                                                      I-300149   2000000497 17-DEC-10
Thomas Wolfe, Residential                                                      I-300149   2001000670 23-FEB-11
Thomas Wolfe, Residential                                                      I-300149   2001000736 08-MAR-11
Thomas Wolfe, Residential                                                      I-300149   2001000751 13-MAR-11
Thomas Wolfe, Residential                                                      I-300149   2001000768 20-MAR-11

21 rows selected.

*/

-- Question #13B

SELECT CustFirstName ||' '|| CustLastName ||', '|| NVL(CompanyName, 'Residential') AS CustName, c.CustomerID, OrderID, OrderDate
FROM Customer c LEFT JOIN CustOrder co
ON c.CustomerID = co.CustomerID
WHERE State = 'PA'
ORDER BY CustomerID, OrderID;

/* Q13B Query Results

CUSTNAME                                                                       CUSTOMERID ORDERID    ORDERDATE
------------------------------------------------------------------------------ ---------- ---------- ---------
George Purcell, BMA Advertising Design                                         C-300006   2000000050 26-JUL-10
George Purcell, BMA Advertising Design                                         C-300006   2000000083 10-AUG-10
George Purcell, BMA Advertising Design                                         C-300006   2000000110 20-AUG-10
George Purcell, BMA Advertising Design                                         C-300006   2000000130 27-AUG-10
George Purcell, BMA Advertising Design                                         C-300006   2000000355 01-DEC-10
George Purcell, BMA Advertising Design                                         C-300006   2001000643 17-FEB-11
George Purcell, BMA Advertising Design                                         C-300006   2001000729 07-MAR-11
Mildred Jones, Computer Consultants                                            C-300040   2000000012 06-JUL-10
Mildred Jones, Computer Consultants                                            C-300040   2000000284 02-NOV-10
Mildred Jones, Computer Consultants                                            C-300040   2001000721 03-MAR-11
Mildred Jones, Computer Consultants                                            C-300040   2001000782 23-MAR-11

CUSTNAME                                                                       CUSTOMERID ORDERID    ORDERDATE
------------------------------------------------------------------------------ ---------- ---------- ---------
Scott Gray, Security Installation                                              C-300062   2000000361 01-DEC-10
Scott Gray, Security Installation                                              C-300062   2000000421 10-DEC-10
Scott Gray, Security Installation                                              C-300062   2000000440 14-DEC-10
Scott Gray, Security Installation                                              C-300062   2000000496 17-DEC-10
Don Kaleta, Residential                                                        I-300028
Thomas Wolfe, Residential                                                      I-300149   2000000497 17-DEC-10
Thomas Wolfe, Residential                                                      I-300149   2001000670 23-FEB-11
Thomas Wolfe, Residential                                                      I-300149   2001000736 08-MAR-11
Thomas Wolfe, Residential                                                      I-300149   2001000751 13-MAR-11
Thomas Wolfe, Residential                                                      I-300149   2001000768 20-MAR-11

21 rows selected.

*/

-- Question #14A

CREATE TABLE RandomFirstName AS
SELECT DISTINCT CustFirstName
FROM Customer
FETCH FIRST 50 ROWS ONLY;

CREATE TABLE RandomLastName AS
SELECT CustLastName
FROM Customer
FETCH FIRST 100 ROWS ONLY;

CREATE TABLE RandomCity AS
SELECT City
FROM Customer
FETCH FIRST 50 ROWS ONLY;

CREATE TABLE RandomState AS
SELECT State
FROM Customer
FETCH FIRST 50 ROWS ONLY;

CREATE TABLE RandomData AS
SELECT *
FROM RandomFirstName CROSS JOIN
RandomLastName CROSS JOIN
RandomCity CROSS JOIN
RandomState
ORDER BY DBMS_RANDOM.VALUE;

/* Q14A Query Results

Table RANDOMFIRSTNAME created.


Table RANDOMLASTNAME created.


Table RANDOMCITY created.


Table RANDOMSTATE created.


Table RANDOMDATA created.

Highlight all DDL and DML and press Run

*/

-- Question #14B

SELECT COUNT(*) FROM RandomData;

SELECT * FROM RandomData
FETCH FIRST 25 ROWS ONLY;

/* Q14B Query Results

COUNT(*)
----------
12500000

CUSTFIRSTNAME   CUSTLASTNAME         CITY                 ST
--------------- -------------------- -------------------- --
Jacob           Purcell              Nahunta              NY
Travis          Zubarev              Lamar                ME
Ginger          Moore                Modesto              NV
Daniel          Rouls                Belfast              NY
Tonya           Osmanova             New Milford          KS
Carrie          Umbarger             Nampa                MD
Scott           Abbott               Waterville           MD
Orville         Mann                 Reisterstown         VT
Dennis          Rouls                Grangeville          ID
Joshua          Stahley              Modesto              GA
Scott           Kmec                 Prescott             KS

CUSTFIRSTNAME   CUSTLASTNAME         CITY                 ST
--------------- -------------------- -------------------- --
Scott           Orze                 Lamar                IN
Patrick         Schofield            Torrington           MA
Carey           Neely                New York City        KY
Carrie          Snuffer              Lynchburg            VT
Andrew          Osmanova             Evansville           MA
Daniel          Yeinick              Salina               FL
Carl            Xiao                 Sparta               ME
Patrick         McGrew               Newark               WV
Stephanie       Williams             Grangeville          NC
Stephanie       Kaakeh               Crystal Springs      KS
Dennis          Torres               Grangeville          GA

CUSTFIRSTNAME   CUSTLASTNAME         CITY                 ST
--------------- -------------------- -------------------- --
Rachel          Smith                Tribune              NY
Mike            Heide                Lincoln              GA
Travis          Umbarger             Indianapolis         CO

25 rows selected. 

*/
