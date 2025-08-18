/*
Noah Zhou
CNIT372 Lab Section 006
Estimated Time Spent: 1 hour
Late hours used: [0]
*/

-- Question #1

SELECT User FROM Dual;

/* Q1 Query Results

USER
--------------------------------------------------------------------------------------------------------------------------------
ZHOU1170

1 row selected.

*/

-- Question #2

SELECT Current_Timestamp FROM Dual;

/* Q2 Query Results

CURRENT_TIMESTAMP
------------------------------------------------
23-AUG-24 09.39.27.208601000 AM AMERICA/NEW_YORK

1 row selected.

*/

-- Question #3

SELECT COUNT(CustomerID) AS NumberOfCommercialCustomers
FROM Customer
WHERE CompanyName IS NOT NULL;

/* Q3 Query Results

NUMBEROFCOMMERCIALCUSTOMERS
---------------------------
                         74

1 row selected.

*/

-- Question #4

SELECT COUNT(CustomerID) AS NumberOfResidentialCustomers
FROM Customer
WHERE CompanyName IS NULL;

/* Q4 Query Results

NUMBEROFRESIDENTIALCUSTOMERS
----------------------------
                         157

1 row selected.

*/

-- Question #5

SELECT COUNT(CustomerID) AS NumberOfIndianaCustomers
FROM Customer
WHERE State IN 'IN';

/* Q5 Query Results

NUMBEROFINDIANACUSTOMERS
------------------------
                       4

1 row selected.


*/

-- Question #6

SELECT COUNT(CustomerID) AS NumberOfScrantonCustomers
FROM Customer
WHERE City IN 'Scranton' and State IN 'PA';

/* Q6 Query Results

NUMBEROFSCRANTONCUSTOMERS
-------------------------
                        2

1 row selected.

*/

-- Question #7

SELECT CustomerID, CompanyName, CustLastName, CustFirstName, Phone, LOWER(EmailAddr) as EmailAddr
FROM Customer
WHERE State IN ('MI', 'IL')
ORDER BY CustLastName ASC;

/* Q7 Query Results

CUSTOMERID COMPANYNAME                              CUSTLASTNAME         CUSTFIRSTNAME   PHONE        EMAILADDR
---------- ---------------------------------------- -------------------- --------------- ------------ --------------------------------------------------
I-300007                                            Cain                 Jessica         517-901-2610
C-300023   TAS                                      Dalury               Robert          906-278-6446 tas@zeronet.net
I-300093                                            Hanau                Jay             773-490-8254
I-300031                                            Hession              Phillip         231-711-6837 howdy@usol.com
C-300024   Bankruptcy Help                          Lichty               Jim             618-847-1904 bankrupt@usol.com
I-300025                                            Miller               Ronald          734-820-2076 picky@zeronet.net
C-300039   Gards Auto Repair                        Sammons              Dennis          616-544-1969 repairit@free.com
I-300038                                            Smith                David           309-980-4350 emerald@onlineservice.com
I-300052                                            Yelnick              Andrew          517-803-5818 family@free.com

9 rows selected.

*/

-- Question #8

SELECT CustomerID, CustLastName ||', '|| CustFirstName as CustName, Phone
FROM Customer
WHERE State IN 'OH';

/* Q8 Query Results

CUSTOMERID CUSTNAME                              PHONE
---------- ------------------------------------- ------------
C-300020   Cottingham, Brittany                  419-464-5273
C-300074   Bross, Aricka                         419-676-9758
I-300003   Hague, Carl                           419-890-3531
I-300039   Chang, David                          740-750-1272
I-300045   Kempf, Gary                           937-724-7313
I-300094   Schuman, Joseph                       330-209-1273
I-300119   Skadberg, John                        513-282-3919

7 rows selected.

*/

-- Question #9

SELECT CustomerID, SUBSTR(CustLastName,1,1) ||'. '|| CustFirstName as CustName, Phone, LOWER(EmailAddr) AS EmailAddr
FROM Customer
WHERE State IN ('IN', 'OH') AND CompanyName IS NULL
ORDER BY CustLastName DESC;

/* Q9 Query Results

CUSTOMERID CUSTNAME           PHONE        EMAILADDR
---------- ------------------ ------------ --------------------------------------------------
I-300147   Y. Steven          317-780-9804 yawn@fast.com
I-300119   S. John            513-282-3919 skad@zeronet.net
I-300094   S. Joseph          330-209-1273
I-300030   Q. Eric            812-805-1588 diamond@onlineservice.com
I-300045   K. Gary            937-724-7313 kempfg@free.com
I-300003   H. Carl            419-890-3531
I-300039   C. David           740-750-1272 lion@free.com

7 rows selected.

*/

-- Question #10

SELECT COUNT(DISTINCT(CustomerID))
FROM Customer
WHERE State IN 'OH' AND CompanyName IS NOT NULL;

/* Q10 Query Results

COUNT(DISTINCT(CUSTOMERID))
---------------------------
                          2

1 row selected.

*/

-- Question #11

SELECT CompanyName, COUNT(Address)
FROM Customer
WHERE State IN ('IN', 'IL') AND CompanyName IS NOT NULL
GROUP BY CompanyName
ORDER BY CompanyName DESC;

/* Q11 Query Results

COMPANYNAME                              COUNT(ADDRESS)
---------------------------------------- --------------
R and R Air                                           1
Bankruptcy Help                                       1
Baker and Company                                     1

3 rows selected.

*/

-- Question #12

SELECT CustomerID, CompanyName, CustFirstName ||' '|| CustLastName AS CustName, Phone
FROM Customer
WHERE State IN 'CO'
ORDER BY Phone ASC;

/* Q12 Query Results

CUSTOMERID COMPANYNAME                              CUSTNAME                             PHONE
---------- ---------------------------------------- ------------------------------------ ------------
C-300031   Copy Center                              Allen Robles                         644-730-8090
I-300049                                            Paul Rice                            719-541-1837
I-300141                                            Daniel Rodkey                        719-748-3205
C-300041   Laser Graphics Associates                Paul Kaakeh                          719-750-4539
I-300021                                            Matt Smith                           719-822-8828
I-300061                                            Brenda Jones                         720-800-2638
I-300043                                            Carey Dailey                         728-896-2767
I-300073                                            Dean Eagon                           970-581-8611
I-300078                                            Andrea Griswold                      970-746-0995

9 rows selected.

*/
