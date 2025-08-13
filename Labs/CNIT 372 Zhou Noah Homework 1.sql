-- Homework 1: PL/SQL Basics
-- Noah Zhou
-- Estimated Completion Time: 3 Hours

-- Task 1: Basic Control Structures (5 points)
DECLARE
   num NUMBER := 2; -- An integer is initialized and stored in the variable num
BEGIN -- Use of If, ElsIf, and Else to determine if the integer is positive, negative, or zero
   IF num < 0 THEN
      DBMS_OUTPUT.PUT_LINE('Negative'); -- If integer is less than zero, use DBMS_OUTPUT.PUT_LINE to print Negative
   ELSIF num = 0 THEN
      DBMS_OUTPUT.PUT_LINE('Zero'); -- If integer is zero, use DBMS_OUTPUT.PUT_LINE to print Zero
   ELSE
      DBMS_OUTPUT.PUT_LINE('Positive'); -- If integer is greater than zero, use DBMS_OUTPUT.PUT_LINE to print Positive
   END IF;
END;
/
-- End of Task 1

-- Task 2: Using CASE Statements (5 points)
DECLARE
   day_num NUMBER := 1; -- day_num variable initialized with number
   day_name VARCHAR2(10);  -- day_name variable initialized
BEGIN
   day_name := CASE day_num -- Case statement that maps numbers to days of the week
                  WHEN 1 THEN 'Monday'
                  WHEN 2 THEN 'Tuesday'
                  WHEN 3 THEN 'Wednesday'
                  WHEN 4 THEN 'Thursday'
                  WHEN 5 THEN 'Friday'
                  WHEN 6 THEN 'Saturday'
                  WHEN 7 THEN 'Sunday'
                  ELSE 'Invalid Day'
               END;

   DBMS_OUTPUT.PUT_LINE('The day is: ' || day_name); -- prints corresponsing day
END;
/
-- End of Task 2

-- Task 3: Implementing Loops (5 points)
BEGIN
   FOR i IN 1..20 LOOP -- for loop initialized between 1 and 20
      IF MOD(i, 2) = 0 THEN -- Even number checker
         DBMS_OUTPUT.PUT_LINE(i); -- if even number checker is true, print out resulting number in loop
      END IF;
   END LOOP;
END;
/
-- End of Task 3

-- Task 4: Data Types Practice (5 points)
DECLARE
   amount NUMBER := 100.5; -- declare and initialize number variable called amount
   price VARCHAR2(10) := '200.75'; -- declare and initialize varchar2 variable called price
   order_date DATE := SYSDATE; -- declare and initialize date variable called orderDate
   numeric_price NUMBER; -- declare and initialize number variable for converted price
   totalAmount NUMBER; -- declare and initialize number variable for total amount added together
   formattedOrderDate VARCHAR2(30); -- declare and initiaze varchar2 variable for formatted date
BEGIN
   numeric_price := TO_NUMBER(price); -- converting price from varchar2 to number
   totalAmount := amount + numeric_price; -- adding amount to converted price
   formattedOrderDate := TO_CHAR(order_date, 'DD-MON-YYYY'); -- convert order date to string format

   DBMS_OUTPUT.PUT_LINE('Total Amount: ' || totalAmount); -- printing total amount
   DBMS_OUTPUT.PUT_LINE('Order Date: ' || formattedOrderDate); -- printing string format date
END;
-- End of Task 4

-- Task 5: Explain Worked-out Examples (10 points)
-- Scenario: Planning to Try Desserts in Hong Kong
-- You are planning a trip to Hong Kong and want to keep track of the different desserts you intend to try, their locations, and their popularity ratings. You decide to create a PL/SQL block that stores this information and allows you to update and categorize the desserts based on your preferences.

-- This PL/SQL block manages a collection of popular desserts and displays a message based on their popularity scores. It loops through the list of desserts, evaluates their popularity, and updates the popularity score of one dessert. The output provides recommendations on whether a dessert is a must-try, worth trying, or optional.

DECLARE
-- The RECORD type 'dessert_record' is used to define a structure for storing details about each dessert, including its name, location, and popularity score.
    TYPE dessert_record IS RECORD (
        name VARCHAR2(30), -- Stores the name of the dessert.
        location VARCHAR2(50), -- Stores the location where the dessert is popular.
        popularity_score NUMBER -- Stores the popularity score of the dessert (1-10 scale).
    );

    -- The TABLE type 'dessert_table' is defined to hold multiple dessert records, representing a list or collection of desserts.
    TYPE dessert_table IS TABLE OF dessert_record;

    -- The 'desserts' variable is an instance of 'dessert_table' that stores the initial list of desserts, each represented as a 'dessert_record' with a name, location, and popularity score.
    desserts dessert_table := dessert_table(
        dessert_record('Egg Tart', 'Central', 9), -- Egg Tart located in Central with popularity score 9.
        dessert_record('Mango Pomelo Sago', 'Mong Kok', 7), -- Mango Pomelo Sago located in Mong Kok with score 7.
        dessert_record('Pineapple Bun', 'Tsim Sha Tsui', 5) -- Pineapple Bun located in Tsim Sha Tsui with score 5.
    );

    -- The 'message' variable is used to store the recommendation message that will be generated for each dessert based on its popularity score.
    message VARCHAR2(100);
BEGIN
    -- This FOR loop iterates over each dessert in the 'desserts' table, The COUNT method returns the total number of desserts in the collection.
    FOR i IN 1..desserts.COUNT LOOP
    -- IF-THEN-ELSIF structure to evaluate the popularity score of each dessert:
    -- If the popularity score is 8 or higher, the dessert is considered a must-try, if score is between 5 and 7, it is considered worth a try, everything under a 5 is considered optional
        IF desserts(i).popularity_score >= 8 THEN
            message := desserts(i).name || ' in ' || desserts(i).location || ' is a must-try!';
        ELSIF desserts(i).popularity_score BETWEEN 5 AND 7 THEN
            message := desserts(i).name || ' in ' || desserts(i).location || ' is worth a try.';
        ELSE
            message := desserts(i).name || ' in ' || desserts(i).location || ' is optional.';
        END IF;

        -- This line outputs the generated message for each dessert using DBMS_OUTPUT.PUT_LINE. It prints the recommendation based on the dessert's popularity score.
        DBMS_OUTPUT.PUT_LINE(message);
    END LOOP;

    -- This line updates the popularity score of the second dessert in the 'desserts' table (Mango Pomelo Sago) to 8, indicating that its popularity has increased.
    desserts(2).popularity_score := 8;

END;
/


-- Task 6: Create a Personalized Worked-Out Example (10 points)
-- This example relates to Formula 1 racing, where teams accumulate points based on race results.
-- The PL/SQL block tracks scores for multiple teams and provides feedback on their standings. Teams with higher points are considered competitive, while those with lower points need improvement.
DECLARE
   -- Record type to store information about each F1 team
   TYPE f1_team_record IS RECORD (
      team_name VARCHAR2(50),
      points NUMBER
   );

   -- Table type to store a collection of F1 teams and their points
   TYPE f1_team_table IS TABLE OF f1_team_record;

   -- Initialize the teams with their current points
   teams f1_team_table := f1_team_table(
      f1_team_record('Red Bull Racing', 573),
      f1_team_record('Mercedes', 410),
      f1_team_record('Ferrari', 360),
      f1_team_record('McLaren', 190)
   );

   -- Variable to store custom messages about each team's performance
   message VARCHAR2(100);
BEGIN
   -- Loop through the F1 teams to evaluate their current points
   FOR i IN 1..teams.COUNT LOOP
      -- If the team has more than 500 points, it's considered highly competitive
      IF teams(i).points > 500 THEN
         message := teams(i).team_name || ' is leading the championship with ' || teams(i).points || ' points!';
      -- Teams with points between 300 and 500 are still competitive
      ELSIF teams(i).points BETWEEN 300 AND 500 THEN
         message := teams(i).team_name || ' is performing well with ' || teams(i).points || ' points.';
      -- Teams with less than 300 points need improvement
      ELSE
         message := teams(i).team_name || ' needs improvement with only ' || teams(i).points || ' points.';
      END IF;

      -- Display the generated message for each team
      DBMS_OUTPUT.PUT_LINE(message);
   END LOOP;

   -- Update the points for McLaren to reflect a recent race result
   teams(4).points := 220;
   DBMS_OUTPUT.PUT_LINE('McLarens updated points: ' || teams(4).points);
END;
/
