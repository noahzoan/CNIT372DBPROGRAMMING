/*
Noah Zhou
CNIT372 Lab Section 006
Estimated Time Spent: 3 hour
Late hours used: [0]
*/

/* Table 1: Control Structures */

-- Question #1A
/* Q1A Query Results

JOBTITLE                            COUNT(EMPLOYEEID)
----------------------------------- -----------------
VP Finance                                          1
Sales                                               3
VP Information                                      1
Chief Information Officer                           1
Chief Sales Officer                                 1
VP Operations                                       1
Accountant                                          2
President                                           1
DBA                                                 1
Chief Financial Officer                             1
Engineer                                            5

JOBTITLE                            COUNT(EMPLOYEEID)
----------------------------------- -----------------
Programmer Analyst                                  2
Operations Officer                                  2
Assembly                                           18

14 rows selected.

*/

-- Question #1B
/* Q1B Query Results

There are no employees with the Job Title : CIO

*/

-- Question #1C
/* Q1C Query Results

There are between 1 and 3 employees with the Job Title : Accountant

*/

-- Question #1D
/* Q1D Query Results

There are between 4 and 6 employees with the Job Title : Engineer

*/

-- Question #1E
/* Q1E Query Results

There are 7 or more employees with the Job Title : Assembly

*/

-- Question #2A
/* Q2A Query Results

There are no employees with the Job Title : CIO

*/

-- Question #2B
/* Q2B Query Results

There are between 1 and 3 employees with the Job Title : Accountant

*/

-- Question #2C
/* Q2C Query Results

There are between 4 and 6 employees with the Job Title : Engineer

*/

-- Question #2D
/* Q2D Query Results

There are 7 or more employees with the Job Title : Assembly

*/

-- Question 3
/* Q3 Query Results

There are between 4 and 6 employees with the Job Title: Engineer

*/

-- Question #4A
/* Q4A Query Results

5, 1, 3, 3

*/

-- Question #4B
/* Q4B Non-Query Answer

The loop generates a number between 1 and MY_COUNT and prints them on a single
line, separated by commas

*/

-- Question #4A
/* Q4A Non-Query Answer

DECLARE
    MY_COUNT INTEGER := '&MY_COUNT';
    MY_COUNTER INTEGER := 1;
    MY_NUMBER INTEGER;
BEGIN
    WHILE MY_COUNTER < MY_COUNT
    LOOP
        MY_NUMBER := dbms_random.value(1,MY_COUNT);
        DBMS_OUTPUT.PUT (MY_NUMBER || ', ');
        MY_COUNTER := MY_COUNTER + 1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('');
END;

*/

-- Question #4B
/* Q4B Query Results

3, 4, 4, 3,

*/

-- Question #5A
/* Q5A Non-Query Answer

DECLARE
    MY_COUNT INTEGER := '&MY_COUNT';
    MY_COUNTER INTEGER := 1;
    MY_NUMBER INTEGER;
BEGIN
    FOR MY_COUNTER IN 1 .. MY_COUNT LOOP
        MY_NUMBER := dbms_random.value(1,MY_COUNT);
        DBMS_OUTPUT.PUT (MY_NUMBER || ', ');
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('');
END;

*/

-- Question #5B
/* Q5B Query Results

2, 3, 2, 1, 2,

*/


/* Table 2: Procedures and Functions */


-- Question #1A
/* Q1A Query Results

Procedure HELLO_WORLD compiled

The output was printed to the Script Output pane.

*/

-- Question #1B
/* Q1B Non-Query Answer

EXECUTE Hello_World;

*/

-- Question #1C
/* Q1C Query Results

Hello World

*/

-- Question #1D
/* Q1D Non-Query Answer

Anonymous blocks are not named which makes it difficult to build a large and
complex application. They are not stored which means that any piece of repeated
logic that is changed needs to be changed throughout the entire program. Named
blocks are as the name infers, named. They allow for programs to be saved and
ran without implementing major changes.

*/

-- Question #2
/* Q2 Non-Query Answer

CREATE OR REPLACE PROCEDURE hello_world AS
    v_output VARCHAR2(35) := 'Hello World';
BEGIN
    dbms_output.put_line(v_output);
END hello_world;

*/

-- Question #3
/* Q3 Query Results

Procedure HELLO_WORLD compiled

*/

-- Question #3A

EXECUTE hello_world('World');

/* Q3A Query Results

Hello World

*/

-- Question #3B
/* Q3B Query Results

Hello Nark.

*/

-- Question #3C
/* Q3C Query Results

Error starting at line : 1 in command -
BEGIN hello_world('World procedure. I have so much fun coding in SQL and PLSQL.'); END;
Error report -
ORA-06502: PL/SQL: numeric or value error: character string buffer too small
ORA-06512: at "ZHOU1170.HELLO_WORLD", line 4
ORA-06512: at line 1
06502. 00000 -  "PL/SQL: numeric or value error%s"
*Cause:    An arithmetic, numeric, string, conversion, or constraint error
           occurred. For example, this error occurs if an attempt is made to
           assign the value NULL to a variable declared NOT NULL, or if an
           attempt is made to assign an integer larger than 99 to a variable
           declared NUMBER(2).
*Action:   Change the data, how it is manipulated, or how it is declared so
           that values do not violate constraints.

*/

-- Question #3D
/* Q3D Non-Query Answer

CREATE OR REPLACE PROCEDURE hello_world
(p_name IN varchar2)
AS
    v_output VARCHAR2(100) := 'Hello '|| p_name;
BEGIN
    dbms_output.put_line(v_output);
END hello_world;

*/

-- Question #3E
/* Q3E Query Results

Hello World procedure. I have so much fun coding in SQL and PLSQL.

*/

-- Question #4
/* Q4 Query Results

Procedure HELLO_WORLD compiled

*/

-- Question #4A

EXECUTE hello_world('Hello', 'World');

/* Q4A Query Results

Hello World

*/

-- Question #4B
/* Q4B Non-Query Answer

Error starting at line : 1 in command -
BEGIN hello_world('World'); END;
Error report -
ORA-06550: line 1, column 7:
PLS-00306: wrong number or types of arguments in call to 'HELLO_WORLD'
ORA-06550: line 1, column 7:
PL/SQL: Statement ignored
06550. 00000 -  "line %s, column %s:\n%s"
*Cause:    Usually a PL/SQL compilation error.
*Action:

*/

-- Question #4C

EXECUTE hello_world('Goodbye', 'Hal');

/* Q4C Query Results

Goodbye Hal

*/

-- Question #4D
/* Q4D Query Results

Hello

*/

-- Question #5

SELECT NUMBER_OF_EMPLOYEES() AS num_employees FROM dual;

/* Q5 Query Results

NUM_EMPLOYEES
-------------
           40

*/

-- Question #6
/* Q6 Non-Query Answer

Function NUMBER_OF_EMPLOYEES compiled

*/

-- Question #6A

SELECT NUMBER_OF_EMPLOYEES('Engineer') AS num_employees FROM dual;

/* Q6A Non-Query Answer

NUM_ENGINEERS
-------------
            5

*/


-- Question #6B
/* Q6B Non-Query Answer

create or replace function NUMBER_OF_EMPLOYEES
(p_jobtitle IN varchar2)
return NUMBER
AS
    v_number_of_employees NUMBER := 0;
BEGIN
    select count(*)
    into v_number_of_employees
    from employee
    WHERE TRIM(UPPER(jobtitle)) = TRIM(UPPER(p_jobtitle));

    return v_number_of_employees;
END NUMBER_OF_EMPLOYEES;

*/


-- Question #6C

SELECT NUMBER_OF_EMPLOYEES('engineer') AS num_employees FROM dual;

/* Q6C Query Results

NUM_ENGINEERS
-------------
            5

*/

-- Question #6D

SELECT NUMBER_OF_EMPLOYEES('dba') AS num_employees FROM dual;

/* Q6D Query Results

NUM_EMPLOYEES
-------------
            1

*/

-- Question #6E

SELECT NUMBER_OF_EMPLOYEES('DBA') AS num_employees FROM dual;

/* Q6E Query Results

NUM_EMPLOYEES
-------------
            1

*/


-- Question #6F

SELECT NUMBER_OF_EMPLOYEES('chief sales officer') AS num_employees FROM dual;

/* Q6F Query Results

NUM_EMPLOYEES
-------------
            1

*/


-- Question #6G

SELECT NUMBER_OF_EMPLOYEES('   chief sales officer') AS num_employees FROM dual;

/* Q6G Query Results

NUM_EMPLOYEES
-------------
            1

*/


-- Question #6H

SELECT NUMBER_OF_EMPLOYEES('CEO') AS num_employees FROM dual;

/* Q6H Query Results

NUM_EMPLOYEES
-------------
            0

*/


-- Question #7A
/* Q7A Non-Query Answer

CREATE OR REPLACE FUNCTION DAYS_AWAY
(p_date IN DATE)
RETURN NUMBER
AS
    v_days_difference NUMBER;
BEGIN
    v_days_difference := p_date - SYSDATE;
    RETURN TRUNC(v_days_difference);
END DAYS_AWAY;

*/

-- Question #7B

SELECT DAYS_AWAY(TO_DATE('2024-10-05', 'YYYY-MM-DD')) AS future_days_away FROM dual;

SELECT DAYS_AWAY(TO_DATE('2024-9-05', 'YYYY-MM-DD')) AS past_days_away FROM dual;

/* Q7B Query Results

FUTURE_DAYS_AWAY
----------------
               5

PAST_DAYS_AWAY
--------------
           -24


*/


-- Question #8A
/* Q8B Non-Query Answer

CREATE OR REPLACE PROCEDURE DAY_OF_THE_WEEK
(p_date IN DATE)
AS
    v_day_of_week      VARCHAR2(20);
    v_previous_day     VARCHAR2(20);
    v_next_day         VARCHAR2(20);
BEGIN
    v_day_of_week := TO_CHAR(p_date, 'Day');
    v_previous_day := TO_CHAR(p_date - 1, 'Day');
    v_next_day := TO_CHAR(p_date + 1, 'Day');

    v_day_of_week := TRIM(v_day_of_week);
    v_previous_day := TRIM(v_previous_day);
    v_next_day := TRIM(v_next_day);

    DBMS_OUTPUT.PUT_LINE('Day of the Week: ' || v_day_of_week);
    DBMS_OUTPUT.PUT_LINE('Previous Day of the Week: ' || v_previous_day);
    DBMS_OUTPUT.PUT_LINE('Next Day of the Week: ' || v_next_day);
END DAY_OF_THE_WEEK;

*/


-- Question #8B

EXECUTE DAY_OF_THE_WEEK(TO_DATE('2024-10-29', 'YYYY-MM-DD'));

EXECUTE DAY_OF_THE_WEEK(TO_DATE(SYSDATE));

/* Q8B Query Results

Day of the Week: Tuesday
Previous Day of the Week: Monday
Next Day of the Week: Wednesday

Day of the Week: Sunday
Previous Day of the Week: Saturday
Next Day of the Week: Monday

*/


-- Question #8A
/* Q8A Non-Query Answer

CREATE OR REPLACE PROCEDURE DAYS_FROM_WEEKEND
(p_date IN DATE)
AS
    v_day_of_week      NUMBER;
    v_days_until_saturday NUMBER;
BEGIN
    v_day_of_week := TO_CHAR(p_date, 'D');
    IF v_day_of_week IN (1, 7) THEN
        DBMS_OUTPUT.PUT_LINE('Happy Weekend!');
    ELSE
        v_days_until_saturday := 7 - v_day_of_week;
        DBMS_OUTPUT.PUT_LINE('Days until next Saturday: ' || v_days_until_saturday);
    END IF;
END DAYS_FROM_WEEKEND;

*/


-- Question #8B

EXECUTE DAYS_FROM_WEEKEND(TO_DATE('2024-10-03', 'YYYY-MM-DD'));

EXECUTE DAYS_FROM_WEEKEND(TO_DATE(SYSDATE));

/* Q8B Query Results

Days until next Saturday: 2

Happy Weekend!

*/
