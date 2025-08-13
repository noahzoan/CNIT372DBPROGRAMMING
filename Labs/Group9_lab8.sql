/*
Noah Zhou, Frigui Camara
CNIT372 Lab Section 006
Estimated Time Spent: 1 hour
Late hours used: [0]
*/

-- Question #B1 (Partner 1 Noah Zhou)

CREATE VIEW Supervisor AS
SELECT Supervisor, COUNT(EmployeeID) AS NumOfEmployees
FROM Employee
GROUP BY Supervisor;

SELECT * FROM Supervisor;

/* QB1 Query Results

View SUPERVISOR created.

SUPERVISOR NUMOFEMPLOYEES
---------- --------------
100200              	2
100559              	5
100104              	3
100944              	5
100365              	3
100127              	2
100125              	3
100206              	1
100650              	2
                    	1
100330              	2

SUPERVISOR NUMOFEMPLOYEES
---------- --------------
100209              	4
100001              	2
100103              	2
100880              	3

15 rows selected.

*/

-- Question #B2 (Partner 1 Noah Zhou)

GRANT SELECT ON Supervisor TO CAMARA1;

/* QB2 Query Results

Grant succeeded

*/

-- Question #B3 (Partner 2 Frigui Camara)

SELECT * FROM zhou1170.SUPERVISOR

/* QB3 Query Results

SUPERVISOR NUMOFEMPLOYEES
---------- --------------
100200                  2
100559                  5
100104                  3
100944                  5
100365                  3
100127                  2
100125                  3
100206                  1
100650                  2
                        1
100330                  2

SUPERVISOR NUMOFEMPLOYEES
---------- --------------
100209                  4
100001                  2
100103                  2
100880                  3

15 rows selected.


*/

-- Question #B4 (Partner 1 Noah Zhou)

INSERT INTO EMPLOYEE(EmployeeID, LastName, FirstName, JobTitle, StreetAddress, City, State, PostalCode, HomePhone, SetupAllowed, HireDate, ReleaseDate, Type, TempService, LockerNumber, BirthDate, StampNumber, Supervisor, EmailAddr, SalaryWage)
VALUES ('101177', 'White', 'Walter', 'Engineer', '121 N. 2nd Ave', 'Miami', 'FL', '33101', '123-456-7890', 'Y', '23-Mar-09', '', 'Permanent', '', '', '23-Mar-79', '002', '100209', 'wwhite@eagle.com', '45000');


/* QB4 Query Results

1 row inserted.

*/

-- Question #B5 (Partner 1 Noah Zhou)

SELECT * FROM Supervisor;

/* QB5 Query Results

SUPERVISOR NUMOFEMPLOYEES
---------- --------------
100200              	2
100559              	5
100104              	3
100944              	5
100365              	3
100127              	2
100125              	3
100206              	1
100650              	2
101177              	1
                    	1

SUPERVISOR NUMOFEMPLOYEES
---------- --------------
100330              	2
100209              	4
100001              	2
100103              	2
100880              	3

16 rows selected.

I do see the new employee because the view reflects the latest data in the table and that I am the schema owner.

*/

-- Question #B6 (Partner 2 Frigui Camara)

SELECT * FROM zhou1170.SUPERVISOR;

/* QB6 Query Results

SUPERVISOR NUMOFEMPLOYEES
---------- --------------
100200                  2
100559                  5
100104                  3
100944                  5
100365                  3
100127                  2
100125                  3
100206                  1
100650                  2
                        1
100330                  2

SUPERVISOR NUMOFEMPLOYEES
---------- --------------
100209                  4
100001                  2
100103                  2
100880                  3

15 rows selected.

I do not see the new employee because of transaction is still open and the new employee is still considered temporay until the change is committed.

*/

-- Question #B7 (Partner 1 Noah Zhou)

COMMIT;

/* QB7 Query Results

Commit complete.

*/

-- Question #B8 (Partner 2 Frigui Camara)

SELECT * FROM zhou1170.SUPERVISOR;

/* QB8 Query Results

SUPERVISOR NUMOFEMPLOYEES
---------- --------------
100200                  2
100559                  5
100104                  3
100944                  5
100365                  3
100127                  2
100125                  3
100206                  1
100650                  2
101177                  1
                        1

SUPERVISOR NUMOFEMPLOYEES
---------- --------------
100330                  2
100209                  4
100001                  2
100103                  2
100880                  3

16 rows selected.

I now do see the new employee because the change has been committed and the transaction is considered closed and permanent.

*/

-- Question #B9 (Partner 1 Noah Zhou)

DELETE FROM Employee WHERE EmployeeID = '101177';

/* QB9 Query Results

1 row deleted.

*/

-- Question #B10 (Partner 1 Noah Zhou)

SELECT * FROM Supervisor;

/* QB10 Query Results

SUPERVISOR NUMOFEMPLOYEES
---------- --------------
100200              	2
100559              	5
100104              	3
100944              	5
100365              	3
100127              	2
100125              	3
100206              	1
100650              	2
                    	1
100330              	2

SUPERVISOR NUMOFEMPLOYEES
---------- --------------
100209              	4
100001              	2
100103              	2
100880              	3

15 rows selected.

I do not see the new employee anymore because I am the schema owner and that the view reflects the latest data in the table.

*/

-- Question #B11 (Partner 2 Frigui Camara)

SELECT * FROM zhou1170.SUPERVISOR;

/* QB11 Query Results

SUPERVISOR NUMOFEMPLOYEES
---------- --------------
100200                  2
100559                  5
100104                  3
100944                  5
100365                  3
100127                  2
100125                  3
100206                  1
100650                  2
101177                  1
                        1

SUPERVISOR NUMOFEMPLOYEES
---------- --------------
100330                  2
100209                  4
100001                  2
100103                  2
100880                  3

16 rows selected.

I still do see the new employee because again, the transaction is still open and the change is still considered temporay until the change is committed.

*/

-- Question #B12 (Partner 1 Noah Zhou)

REVOKE SELECT ON Supervisor FROM CAMARA1;

/* QB12 Query Results

Revoke succeeded.

*/

-- Question #B13 (Partner 2 Frigui Camara)

SELECT * FROM zhou1170.SUPERVISOR

/* QB13 Query Results

Error starting at line : 1 in command -
SELECT * FROM zhou1170.SUPERVISOR
Error at Command Line : 1 Column : 24
Error report -
SQL Error: ORA-00942: table or view does not exist

https://docs.oracle.com/error-help/db/ora-00942/00942. 00000 -  "table or view%s does not exist"
*Cause:    The specified table or view did not exist, or a synonym
           pointed to a table or view that did not exist.
           To find existing user tables and views, query the
           ALL_TABLES and ALL_VIEWS data dictionary views. Certain
           privileges may be required to access the table. If an
           application returned this message, then the table that the
           application tried to access did not exist in the database, or
           the application did not have access to it.
*Action:   Check each of the following
           - The spelling of the table or view name is correct.
           - The referenced table or view name does exist.
           - The synonym points to an existing table or view.

More Details :
https://docs.oracle.com/error-help/db/ora-00942/

I am receiving this error because I do not have the correct privileges to access the view. Therefore it is unavailable to me.
The error message is slightly misleading because it states that the table or view does not exist but since it has not been dropped,
it still technically exists. However the *Cause states that certain privileges may be required to access the table and now I do
not have the correct privileges to access the view.

*/

-- Question #B14 (Partner 1 Noah Zhou)

DROP VIEW Supervisor;

/* QB14 Query Results

View SUPERVISOR dropped.

*/

-- Question #B15 (Partner 1 Noah Zhou, Partner 2 Frigui Camara)
/* QB15 Non-Query Answer

We do not have the CREATE MATERIALIZED VIEW privilege. The reasoning behind this is because of security.
Granting these privileges could lead to the creation of objects with excessive resource consumption and could lead to database instability.

*/

-- Question #B16 (Partner 1 Noah Zhou, Partner 2 Frigui Camara)
/* QB16 Non-Query Answer

We do not have the CREATE ROLES privilege. This allows users to create and manage database roles, which are used to group together and manage privileges more easily.
The reason for not being granted this privilege goes as the following, security concerns, access control, and resource management.

*/
