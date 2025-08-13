/*
Noah Zhou
CNIT372 Lab Section 006
Estimated Time Spent: 3 hour
Late hours used: [0]
*/


-- Question #1A

CREATE TABLE LAB9_EMPLOYEE AS SELECT * FROM EMPLOYEE;

/* Q1A Query Results

Table LAB9_EMPLOYEE created.

*/

-- Question #1B

CREATE OR REPLACE TRIGGER TBDS_LAB9_EMPLOYEE
    BEFORE DELETE ON LAB9_EMPLOYEE
BEGIN
    DBMS_OUTPUT.PUT_LINE('Trigger fired before deleting anything from LAB9_EMPLOYEE');
END;

/* Q1B Query Results

Trigger TBDR_LAB9_EMPLOYEE compiled

The trigger is defined on the database object LAB9_EMPLOYEE which is a table. The timing is that it will fire before
any delete operation is performed on the LAB9_EMPLOYEE table.

*/

-- Question #1C

CREATE OR REPLACE TRIGGER TBDR_LAB9_EMPLOYEE
    BEFORE DELETE ON LAB9_EMPLOYEE
    FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('Trigger fired before deleting a row from LAB9_EMPLOYEE');
END;

/* Q1C Query Results

Trigger TBDR_LAB9_EMPLOYEE compiled

The trigger is defined on the database object LAB9_EMPLOYEE which is a table. The timing is that it will fire before
any delete operation is performed on each row in the LAB9_EMPLOYEE table.

*/

-- Question #1D

CREATE OR REPLACE TRIGGER TADS_LAB9_EMPLOYEE
    AFTER DELETE ON LAB9_EMPLOYEE
BEGIN
    DBMS_OUTPUT.PUT_LINE('Trigger fired after deleting anything from LAB9_EMPLOYEE');
END;

/* Q1D Query Results

Trigger TADS_LAB9_EMPLOYEE compiled

The trigger is defined on the database object LAB9_EMPLOYEE which is a table. The timing is that it will fire after
any delete operation is performed on the LAB9_EMPLOYEE table.

*/

-- Question #1E

CREATE OR REPLACE TRIGGER TADR_LAB9_EMPLOYEE
    AFTER DELETE ON LAB9_EMPLOYEE
    FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('Trigger fired after deleting a row from LAB9_EMPLOYEE');
END;

/* Q1E Query Results

Trigger TADR_LAB9_EMPLOYEE compiled

The trigger is defined on the database object LAB9_EMPLOYEE which is a table. The timing is that it will fire after
any delete operation is performed on each row in the LAB9_EMPLOYEE table.

*/

-- Question #1F

DELETE FROM LAB9_EMPLOYEE WHERE EMPLOYEEID = '101135';

/* Q1f Query Results

1 row deleted.

All the triggers (TBDS, TBDR, TADS, TADR) fired once.
Trigger fired before deleting anything from LAB9_EMPLOYEE (TBDS_LAB9_EMPLOYEE)
Trigger fired before deleting a row from LAB9_EMPLOYEE (TBDR_LAB9_EMPLOYEE)
Trigger fired after deleting a row from LAB9_EMPLOYEE (TADR_LAB9_EMPLOYEE)
Trigger fired after deleting anything from LAB9_EMPLOYEE (TADS_LAB9_EMPLOYEE)

*/

-- Question #1G

ROLLBACK;

/* Q1G Query Results

Rollback complete.

After the rollback, the data was restored. Trigger execution does not implicitly perform a commit.

*/

-- Question #1H

DELETE FROM LAB9_EMPLOYEE WHERE JOBTITLE = 'Sales';

/* Q1H Query Results

3 rows deleted.

ALl the triggers fired during the delete operation.
Trigger fired before deleting anything from LAB9_EMPLOYEE (TBDS_LAB9_EMPLOYEE)
Trigger fired before deleting a row from LAB9_EMPLOYEE (TBDR_LAB9_EMPLOYEE)
Trigger fired after deleting a row from LAB9_EMPLOYEE (TADR_LAB9_EMPLOYEE)
Trigger fired before deleting a row from LAB9_EMPLOYEE (TBDR_LAB9_EMPLOYEE)
Trigger fired after deleting a row from LAB9_EMPLOYEE (TADR_LAB9_EMPLOYEE)
Trigger fired before deleting a row from LAB9_EMPLOYEE (TBDR_LAB9_EMPLOYEE)
Trigger fired after deleting a row from LAB9_EMPLOYEE (TADR_LAB9_EMPLOYEE)
Trigger fired after deleting anything from LAB9_EMPLOYEE (TADS_LAB9_EMPLOYEE)

*/

-- Question #1I

ROLLBACK;

/* Q1I Query Results

Rollback complete.

After the rollback, the data was restored. This is what I expected.

*/

-- Question #1J

TRUNCATE TABLE LAB9_EMPLOYEE;


/* Q1J Query Results

Table LAB9_EMPLOYEE truncated.

No triggers fired because there was not delete operation being performed.

*/

-- Question #2A

CREATE OR REPLACE TRIGGER TBIS_LAB9_EMPLOYEE
BEFORE INSERT ON LAB9_EMPLOYEE
BEGIN
    DBMS_OUTPUT.PUT_LINE('Trigger TBIS_LAB9_EMPLOYEE fired before inserting data into LAB9_EMPLOYEE');
END;

CREATE OR REPLACE TRIGGER TBIR_LAB9_EMPLOYEE
BEFORE INSERT ON LAB9_EMPLOYEE
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('Trigger TBIR_LAB9_EMPLOYEE fired before inserting a row into LAB9_EMPLOYEE');
END;

CREATE OR REPLACE TRIGGER TAIR_LAB9_EMPLOYEE
AFTER INSERT ON LAB9_EMPLOYEE
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('Trigger TAIR_LAB9_EMPLOYEE fired after inserting a row into LAB9_EMPLOYEE');
END;

CREATE OR REPLACE TRIGGER TAIS_LAB9_EMPLOYEE
AFTER INSERT ON LAB9_EMPLOYEE
BEGIN
    DBMS_OUTPUT.PUT_LINE('Trigger TAIS_LAB9_EMPLOYEE fired after inserting data into LAB9_EMPLOYEE');
END;

/* Q2A Query Results

Trigger TBIS_LAB9_EMPLOYEE compiled

Trigger TBIR_LAB9_EMPLOYEE compiled

Trigger TAIR_LAB9_EMPLOYEE compiled

Trigger TAIS_LAB9_EMPLOYEE compiled

*/

-- Question #2B
/* Q2B Non-Query Answer

My hypothesis is that if I inserted a single row into the LAB9_EMPLOYEE table, I expect each trigger to fire once and only once.
I expect the sequence to be:
1. TBIS_LAB9_EMPLOYEE
2. TBIR_LAB9_EMPLOYEE
3. TAIR_LAB9_EMPLOYEE
4. TAIS_LAB9_EMPLOYEE

*/

-- Question #2C

INSERT INTO LAB9_EMPLOYEE (EMPLOYEEID, LASTNAME, FIRSTNAME, JOBTITLE, STREETADDRESS, CITY, STATE, POSTALCODE, HOMEPHONE, SETUPALLOWED, HIREDATE, RELEASEDATE, TYPE, TEMPSERVICE, LOCKERNUMBER, BIRTHDATE, STAMPNUMBER, SUPERVISOR, EMAILADDR, SALARYWAGE)
VALUES ('100000', 'Pete', 'Purdue', 'Mascot', '101 Purdue Mall', 'West Lafayette', 'IN', '47906', '765-111-1111', '', '', '', '', '', '', '', '', '', 'purduepete@purdue.edu','');

/* Q2C Query Results

Trigger TBIS_LAB9_EMPLOYEE fired before inserting data into LAB9_EMPLOYEE
Trigger TBIR_LAB9_EMPLOYEE fired before inserting a row into LAB9_EMPLOYEE
Trigger TAIR_LAB9_EMPLOYEE fired after inserting a row into LAB9_EMPLOYEE
Trigger TAIS_LAB9_EMPLOYEE fired after inserting data into LAB9_EMPLOYEE

1 row inserted.

The test supports my hypothesis.

*/

-- Question #2D
/* Q2D Non-Query Answer

My hypothesis is that if I inserted 40 rows into the LAB9_EMPLOYEE table,
I except the TBIS trigger to fire once before insertion of 40 rows and the TAIS trigger to fire once after the inswertion of 40 rows

I expect the sequence to be:
1. TBIS_LAB9_EMPLOYEE
2. TBIR_LAB9_EMPLOYEE
3. TAIR_LAB9_EMPLOYEE
4. TAIS_LAB9_EMPLOYEE

The TBIR and TAIR trigger will alternately fire for each of the 40 rows as seen here:
Trigger TBIR_LAB9_EMPLOYEE fired before inserting a row into LAB9_EMPLOYEE
Trigger TAIR_LAB9_EMPLOYEE fired after inserting a row into LAB9_EMPLOYEE
Trigger TBIR_LAB9_EMPLOYEE fired before inserting a row into LAB9_EMPLOYEE
Trigger TAIR_LAB9_EMPLOYEE fired after inserting a row into LAB9_EMPLOYEE
Trigger TBIR_LAB9_EMPLOYEE fired before inserting a row into LAB9_EMPLOYEE
Trigger TAIR_LAB9_EMPLOYEE fired after inserting a row into LAB9_EMPLOYEE
Trigger TBIR_LAB9_EMPLOYEE fired before inserting a row into LAB9_EMPLOYEE
Trigger TAIR_LAB9_EMPLOYEE fired after inserting a row into LAB9_EMPLOYEE
*/

-- Question #2E

INSERT INTO LAB9_EMPLOYEE (EMPLOYEEID, LASTNAME, FIRSTNAME, JOBTITLE, STREETADDRESS, CITY, STATE, POSTALCODE, HOMEPHONE, SETUPALLOWED, HIREDATE, RELEASEDATE, TYPE, TEMPSERVICE, LOCKERNUMBER, BIRTHDATE, STAMPNUMBER, SUPERVISOR, EMAILADDR, SALARYWAGE)
SELECT EMPLOYEEID, LASTNAME, FIRSTNAME, JOBTITLE, STREETADDRESS, CITY, STATE, POSTALCODE, HOMEPHONE, SETUPALLOWED, HIREDATE, RELEASEDATE, TYPE, TEMPSERVICE, LOCKERNUMBER, BIRTHDATE, STAMPNUMBER, SUPERVISOR, EMAILADDR, SALARYWAGE
FROM EMPLOYEE;

/* Q2E Query Results

Trigger TBIS_LAB9_EMPLOYEE fired before inserting data into LAB9_EMPLOYEE
Trigger TBIR_LAB9_EMPLOYEE fired before inserting a row into LAB9_EMPLOYEE
Trigger TBIR_LAB9_EMPLOYEE fired before inserting a row into LAB9_EMPLOYEE
Trigger TBIR_LAB9_EMPLOYEE fired before inserting a row into LAB9_EMPLOYEE
Trigger TBIR_LAB9_EMPLOYEE fired before inserting a row into LAB9_EMPLOYEE
Trigger TBIR_LAB9_EMPLOYEE fired before inserting a row into LAB9_EMPLOYEE
Trigger TBIR_LAB9_EMPLOYEE fired before inserting a row into LAB9_EMPLOYEE
Trigger TBIR_LAB9_EMPLOYEE fired before inserting a row into LAB9_EMPLOYEE
Trigger TBIR_LAB9_EMPLOYEE fired before inserting a row into LAB9_EMPLOYEE
Trigger TBIR_LAB9_EMPLOYEE fired before inserting a row into LAB9_EMPLOYEE
Trigger TBIR_LAB9_EMPLOYEE fired before inserting a row into LAB9_EMPLOYEE
Trigger TBIR_LAB9_EMPLOYEE fired before inserting a row into LAB9_EMPLOYEE
Trigger TBIR_LAB9_EMPLOYEE fired before inserting a row into LAB9_EMPLOYEE
Trigger TBIR_LAB9_EMPLOYEE fired before inserting a row into LAB9_EMPLOYEE
Trigger TBIR_LAB9_EMPLOYEE fired before inserting a row into LAB9_EMPLOYEE
Trigger TBIR_LAB9_EMPLOYEE fired before inserting a row into LAB9_EMPLOYEE
Trigger TBIR_LAB9_EMPLOYEE fired before inserting a row into LAB9_EMPLOYEE
Trigger TBIR_LAB9_EMPLOYEE fired before inserting a row into LAB9_EMPLOYEE
Trigger TBIR_LAB9_EMPLOYEE fired before inserting a row into LAB9_EMPLOYEE
Trigger TBIR_LAB9_EMPLOYEE fired before inserting a row into LAB9_EMPLOYEE
Trigger TBIR_LAB9_EMPLOYEE fired before inserting a row into LAB9_EMPLOYEE
Trigger TBIR_LAB9_EMPLOYEE fired before inserting a row into LAB9_EMPLOYEE
Trigger TBIR_LAB9_EMPLOYEE fired before inserting a row into LAB9_EMPLOYEE
Trigger TBIR_LAB9_EMPLOYEE fired before inserting a row into LAB9_EMPLOYEE
Trigger TBIR_LAB9_EMPLOYEE fired before inserting a row into LAB9_EMPLOYEE
Trigger TBIR_LAB9_EMPLOYEE fired before inserting a row into LAB9_EMPLOYEE
Trigger TBIR_LAB9_EMPLOYEE fired before inserting a row into LAB9_EMPLOYEE
Trigger TBIR_LAB9_EMPLOYEE fired before inserting a row into LAB9_EMPLOYEE
Trigger TBIR_LAB9_EMPLOYEE fired before inserting a row into LAB9_EMPLOYEE
Trigger TBIR_LAB9_EMPLOYEE fired before inserting a row into LAB9_EMPLOYEE
Trigger TBIR_LAB9_EMPLOYEE fired before inserting a row into LAB9_EMPLOYEE
Trigger TBIR_LAB9_EMPLOYEE fired before inserting a row into LAB9_EMPLOYEE
Trigger TBIR_LAB9_EMPLOYEE fired before inserting a row into LAB9_EMPLOYEE
Trigger TBIR_LAB9_EMPLOYEE fired before inserting a row into LAB9_EMPLOYEE
Trigger TBIR_LAB9_EMPLOYEE fired before inserting a row into LAB9_EMPLOYEE
Trigger TBIR_LAB9_EMPLOYEE fired before inserting a row into LAB9_EMPLOYEE
Trigger TBIR_LAB9_EMPLOYEE fired before inserting a row into LAB9_EMPLOYEE
Trigger TBIR_LAB9_EMPLOYEE fired before inserting a row into LAB9_EMPLOYEE
Trigger TBIR_LAB9_EMPLOYEE fired before inserting a row into LAB9_EMPLOYEE
Trigger TBIR_LAB9_EMPLOYEE fired before inserting a row into LAB9_EMPLOYEE
Trigger TBIR_LAB9_EMPLOYEE fired before inserting a row into LAB9_EMPLOYEE
Trigger TAIR_LAB9_EMPLOYEE fired after inserting a row into LAB9_EMPLOYEE
Trigger TAIR_LAB9_EMPLOYEE fired after inserting a row into LAB9_EMPLOYEE
Trigger TAIR_LAB9_EMPLOYEE fired after inserting a row into LAB9_EMPLOYEE
Trigger TAIR_LAB9_EMPLOYEE fired after inserting a row into LAB9_EMPLOYEE
Trigger TAIR_LAB9_EMPLOYEE fired after inserting a row into LAB9_EMPLOYEE
Trigger TAIR_LAB9_EMPLOYEE fired after inserting a row into LAB9_EMPLOYEE
Trigger TAIR_LAB9_EMPLOYEE fired after inserting a row into LAB9_EMPLOYEE
Trigger TAIR_LAB9_EMPLOYEE fired after inserting a row into LAB9_EMPLOYEE
Trigger TAIR_LAB9_EMPLOYEE fired after inserting a row into LAB9_EMPLOYEE
Trigger TAIR_LAB9_EMPLOYEE fired after inserting a row into LAB9_EMPLOYEE
Trigger TAIR_LAB9_EMPLOYEE fired after inserting a row into LAB9_EMPLOYEE
Trigger TAIR_LAB9_EMPLOYEE fired after inserting a row into LAB9_EMPLOYEE
Trigger TAIR_LAB9_EMPLOYEE fired after inserting a row into LAB9_EMPLOYEE
Trigger TAIR_LAB9_EMPLOYEE fired after inserting a row into LAB9_EMPLOYEE
Trigger TAIR_LAB9_EMPLOYEE fired after inserting a row into LAB9_EMPLOYEE
Trigger TAIR_LAB9_EMPLOYEE fired after inserting a row into LAB9_EMPLOYEE
Trigger TAIR_LAB9_EMPLOYEE fired after inserting a row into LAB9_EMPLOYEE
Trigger TAIR_LAB9_EMPLOYEE fired after inserting a row into LAB9_EMPLOYEE
Trigger TAIR_LAB9_EMPLOYEE fired after inserting a row into LAB9_EMPLOYEE
Trigger TAIR_LAB9_EMPLOYEE fired after inserting a row into LAB9_EMPLOYEE
Trigger TAIR_LAB9_EMPLOYEE fired after inserting a row into LAB9_EMPLOYEE
Trigger TAIR_LAB9_EMPLOYEE fired after inserting a row into LAB9_EMPLOYEE
Trigger TAIR_LAB9_EMPLOYEE fired after inserting a row into LAB9_EMPLOYEE
Trigger TAIR_LAB9_EMPLOYEE fired after inserting a row into LAB9_EMPLOYEE
Trigger TAIR_LAB9_EMPLOYEE fired after inserting a row into LAB9_EMPLOYEE
Trigger TAIR_LAB9_EMPLOYEE fired after inserting a row into LAB9_EMPLOYEE
Trigger TAIR_LAB9_EMPLOYEE fired after inserting a row into LAB9_EMPLOYEE
Trigger TAIR_LAB9_EMPLOYEE fired after inserting a row into LAB9_EMPLOYEE
Trigger TAIR_LAB9_EMPLOYEE fired after inserting a row into LAB9_EMPLOYEE
Trigger TAIR_LAB9_EMPLOYEE fired after inserting a row into LAB9_EMPLOYEE
Trigger TAIR_LAB9_EMPLOYEE fired after inserting a row into LAB9_EMPLOYEE
Trigger TAIR_LAB9_EMPLOYEE fired after inserting a row into LAB9_EMPLOYEE
Trigger TAIR_LAB9_EMPLOYEE fired after inserting a row into LAB9_EMPLOYEE
Trigger TAIR_LAB9_EMPLOYEE fired after inserting a row into LAB9_EMPLOYEE
Trigger TAIR_LAB9_EMPLOYEE fired after inserting a row into LAB9_EMPLOYEE
Trigger TAIR_LAB9_EMPLOYEE fired after inserting a row into LAB9_EMPLOYEE
Trigger TAIR_LAB9_EMPLOYEE fired after inserting a row into LAB9_EMPLOYEE
Trigger TAIR_LAB9_EMPLOYEE fired after inserting a row into LAB9_EMPLOYEE
Trigger TAIR_LAB9_EMPLOYEE fired after inserting a row into LAB9_EMPLOYEE
Trigger TAIR_LAB9_EMPLOYEE fired after inserting a row into LAB9_EMPLOYEE
Trigger TAIS_LAB9_EMPLOYEE fired after inserting data into LAB9_EMPLOYEE


40 rows inserted.

In this case, the test disproved my hypothesis about the firing sequence of the row insertion triggers.

*/

-- Question #3A

CREATE OR REPLACE TRIGGER RESTRICT_UPDATE
BEFORE UPDATE OF EMAILADDR ON LAB9_EMPLOYEE
FOR EACH ROW
WHEN (NEW.EMAILADDR IS NOT NULL)
BEGIN
    IF SUBSTR(:NEW.EMAILADDR, -4) != '.com' THEN
        RAISE_APPLICATION_ERROR(-20001, 'Invalid email address. Email must end with ''.com''.');
    END IF;
END;

/* Q3A Query Results

Trigger RESTRICT_UPDATE compiled

*/

-- Question #3B

UPDATE LAB9_EMPLOYEE
SET EMAILADDR = 'invalid_email@domain.org'
WHERE EMPLOYEEID = '100001';

UPDATE LAB9_EMPLOYEE
SET EMAILADDR = 'valid_email@domain.com'
WHERE EMPLOYEEID = '100001';

/* Q3B Query Results

Error starting at line : 1 in command -
UPDATE LAB9_EMPLOYEE
SET EMAILADDR = 'invalid_email@domain.org'
WHERE EMPLOYEEID = '100001'
Error at Command Line : 1 Column : 8
Error report -
SQL Error: ORA-20001: Invalid email address. Email must end with '.com'.
ORA-06512: at "ZHOU1170.RESTRICT_UPDATE", line 3
ORA-04088: error during execution of trigger 'ZHOU1170.RESTRICT_UPDATE'

1 row updated.

*/

-- Question #3C

CREATE OR REPLACE TRIGGER RESTRICT_UPDATE
BEFORE UPDATE OF EMAILADDR ON LAB9_EMPLOYEE
FOR EACH ROW
BEGIN
    IF :NEW.EMAILADDR IS NOT NULL AND SUBSTR(:NEW.EMAILADDR, -4) != '.com' THEN
        RAISE_APPLICATION_ERROR(-20001, 'Email address must end with ".com".');
    END IF;
END;

/* Q3C Query Results

Trigger RESTRICT_UPDATE compiled

*/

-- Question #3D

UPDATE LAB9_EMPLOYEE
SET EMAILADDR = 'invalid_email@domain.org'
WHERE EMPLOYEEID = '100001';

UPDATE LAB9_EMPLOYEE
SET EMAILADDR = 'valid_email@domain.com'
WHERE EMPLOYEEID = '100001';

/* Q3D Query Results

Error starting at line : 1 in command -
UPDATE LAB9_EMPLOYEE
SET EMAILADDR = 'invalid_email@domain.org'
WHERE EMPLOYEEID = '100001'
Error at Command Line : 1 Column : 8
Error report -
SQL Error: ORA-20001: Email address must end with ".com".
ORA-06512: at "ZHOU1170.RESTRICT_UPDATE", line 3
ORA-04088: error during execution of trigger 'ZHOU1170.RESTRICT_UPDATE'

1 row updated.

*/

-- Question #4
/* Q4 Non-Query Answer

DROP TABLE LAB9_EMPLOYEE CASCADE CONSTRAINTS;

*/
