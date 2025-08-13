-- Homework 2: PL/SQL Stored Modules, Control Structures, and Cursors
-- Noah Zhou
-- Estimated Completion Time: 3 Hours

-- Task 1: Task 1: Ensuring Valid Bonus Percent Values
CREATE OR REPLACE FUNCTION normalizeBonusPerc (bonus_percent NUMBER)
RETURN NUMBER
IS
    normalized_bonus NUMBER;
BEGIN
    IF bonus_percent < 0
    THEN normalized_bonus := 0;
    ELSIF bonus_percent > 1
    THEN normalized_bonus :=1;
    ELSE
    normalized_bonus := bonus_percent;
    END IF;

    RETURN normalized_bonus;
END normalizeBonusPerc;
/
-- End of Task 1

-- Task 2: Calculate Department Bonus
CREATE OR REPLACE FUNCTION getDeptBonus(p_department_id NUMBER, p_base_salary NUMBER)
RETURN NUMBER
IS
    v_bonus_percent NUMBER;
    v_bonus_amount NUMBER := 0;

    e_department_not_found EXCEPTION;
BEGIN
    SELECT bonus_percent
    INTO v_bonus_percent
    FROM hw2_departments
    WHERE department_id = p_department_id;

    v_bonus_percent := normalizeBonusPerc(v_bonus_percent);
    v_bonus_amount := p_base_salary * v_bonus_percent;
    RETURN v_bonus_amount;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        RETURN 0;
END getDeptBonus;
/
-- End of Task 2

-- Task 3: Calculate Performance Bonus
CREATE OR REPLACE FUNCTION getPerfBonus(p_performance_score NUMBER, p_base_salary NUMBER)
RETURN NUMBER
IS
    v_bonus_percent NUMBER;
    v_bonus_amount NUMBER;
CURSOR bonus_cursor IS
        SELECT v_bonus_percent
        FROM performance_bonus
        WHERE p_performance_score <= p_performance_score
        ORDER BY p_performance_score DESC;
BEGIN
    OPEN bonus_cursor;
    FETCH bonus_cursor INTO v_bonus_percent;
    CLOSE bonus_cursor;

        IF bonus_cursor%NOTFOUND THEN
        v_bonus_percent := 0;
    END IF;

    v_bonus_percent := normalizeBonusPerc(v_bonus_percent);
    v_bonus_amount := p_base_salary * v_bonus_percent;

    RETURN v_bonus_amount;
EXCEPTION
    -- Handle any errors by returning a default bonus amount of 0
    WHEN OTHERS THEN
        RETURN 0;
END getPerfBonus;
/
-- End of Task 3

-- Task 4: Task 4: Calculate Loyalty Bonus
CREATE OR REPLACE FUNCTION getLoyaltyBonus(p_years_of_service NUMBER, p_base_salary NUMBER, p_loyalty_bonus_percent NUMBER)
RETURN NUMBER
IS
    v_bonus_amount NUMBER := 0;
BEGIN
    IF p_years_of_service > 5 THEN
    v_bonus_amount := p_base_salary * p_loyalty_bonus_percent;
    ELSE
    v_bonus_amount := 0;
    END IF;

    RETURN v_bonus_amount;
EXCEPTION
    WHEN OTHERS THEN
        RETURN 0;
END getLoyaltyBonus;
/
-- End of Task 4
