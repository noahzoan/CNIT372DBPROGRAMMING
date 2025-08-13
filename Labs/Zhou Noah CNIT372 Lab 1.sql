/*
Noah Zhou
CNIT372 Lab Section 006
Estimated Time Spent: 2 hour
Late hours used: [0]
*/

-- Question #1
/* Q1 Non-Query Answer

1. FROM BOOKSHELF
2. WHERE RATING>1
3. GROUP BY CATEGORY_NAME
4. HAVING CATEGORY_NAME LIKE ‘A%’
5. SELECT NAME, COUNT(*), AVG(RATING)
6. ORDER BY COUNT(*);

*/

-- Question #2

SELECT DISTINCT SUBSTR(Phone, 1, 3) AS AreaCode
FROM Customer
WHERE State IN 'CO';
/* Q2 Query Results

ARE
---
719
970
728
644
720

*/

-- Question #3

SELECT AreaCode, COUNT(*) AS NumberOfCustomers
FROM
    (SELECT SUBSTR(Phone,1,3) AS AreaCode
     FROM Customer
     WHERE State IN 'CO')
GROUP BY AreaCode
ORDER BY NumberOfCustomers DESC;

/* Q3 Query Results

ARE NUMBEROFCUSTOMERS
--- -----------------
719                 4
970                 2
644                 1
720                 1
728                 1

*/

-- Question #4

SELECT AreaCode
FROM (
    SELECT SUBSTR(Phone, 1,3) AS AreaCode, COUNT(*) AS NumberOfCustomers
    FROM Customer
    WHERE State IN 'CO'
    GROUP BY SUBSTR(Phone,1,3))
WHERE NumberOfCustomers = (
    SELECT MAX(NumberOfCustomers)
    FROM (
        SELECT COUNT(*) AS NumberOfCustomers
        FROM Customer
        WHERE State IN 'CO'
        GROUP BY SUBSTR(Phone,1,3)));

/* Q4 Query Results

ARE
---
719

*/

-- Question #5

SELECT CustLastName ||', '|| CustFirstName AS CustName, City, State, Phone
FROM Customer
WHERE State = 'CO' AND SUBSTR(Phone,1,3)=(
    SELECT AreaCode
    FROM (
        SELECT SUBSTR(Phone, 1, 3) AS AreaCode, COUNT(*) AS NumberOfCustomers
        FROM Customer
        WHERE State = 'CO'
        GROUP BY SUBSTR(Phone,1,3)
        HAVING COUNT(*) = (
            SELECT MAX(NumberOfCustomers)
            FROM (
            SELECT COUNT(*) AS NumberOfCustomers
            FROM Customer
            WHERE State = 'CO'
            GROUP BY SUBSTR(Phone,1,3)))));

/* Q5 Query Results

CUSTNAME                              CITY                 ST PHONE
------------------------------------- -------------------- -- ------------
Rodkey, Daniel                        Lamar                CO 719-748-3205
Kaakeh, Paul                          Gunnison             CO 719-750-4539
Smith, Matt                           Montrose             CO 719-822-8828
Rice, Paul                            Craig                CO 719-541-1837

*/

-- Question #6
/* Q6 Non-Query Answer

One reason why it might be needed to know the area code that contains the most
amount of people is that the business can focus on what the customers purchase
in that area. This can be done across m 

*/

-- Question #7



/* Q7 Query Results



*/

-- Question #8



/* Q8 Query Results



*/

-- Question #9


/* Q9 Query Results



*/

-- Question #10



/* Q10 Query Results



*/

-- Question #11


/* Q11 Query Results


*/

-- Question #12



/* Q12 Query Results



*/

-- Question #13



/* Q13 Query Results



*/

-- Question #14



/* Q14 Query Results



*/

-- Question #15



/* Q15 Query Results



*/

-- Question #16



/* Q16 Query Results



*/

-- Question #17



/* Q17 Query Results



*/

-- Question #18



/* Q18 Query Results



*/

-- Question #19



/* Q19 Query Results



*/

-- Question #20



/* Q20 Query Results



*/

-- Question #21



/* Q21 Query Results



*/

-- Question #22



/* Q22 Query Results



*/

-- Question #23



/* Q23 Query Results



*/

-- Question #24



/* Q24 Query Results



*/

-- Question #25



/* Q25 Query Results



*/
