-- Queries
USE video_game_db;

-- 1. Number of user
SELECT COUNT(user_id) AS 'Number of Users'
FROM users;

-- 2. Number of games
SELECT COUNT(game_id) AS 'Number of Games'
FROM games;

-- 3. Number of Games per genre
SELECT a.genre_name AS 'Genre', COUNT(b.game_id) AS 'Number of Games in Genre'
FROM genre a
JOIN games b ON a.genre_id = b.genre_id
GROUP BY a.genre_name
ORDER BY a.genre_name;

-- 4. Reviews/Ratings for each game
SELECT u.user_name, g.game_name, r.rating, r.review_comment
FROM user_reviews r
JOIN users u ON r.user_id = u.user_id
JOIN games g ON r.game_id = g.game_id
ORDER BY g.game_name;

-- 5. Average rating for each game in descending order
SELECT g.game_name, ROUND(AVG(u.rating), 0) AS 'Average Game Ratings'
FROM user_reviews u
JOIN games g ON u.game_id = g.game_id
GROUP BY g.game_name
ORDER BY AVG(u.rating) DESC;

-- 6. Users average rating given
SELECT u.user_name, ROUND(AVG(r.rating), 0) AS 'Average Rating Given'
FROM users u
JOIN user_reviews r ON u.user_id = r.user_id
GROUP BY u.user_name
ORDER BY AVG(r.rating) DESC;

-- 7. Awards given to developers
SELECT d.developer_name, COUNT(a.award_id) AS 'Number of Awards'
FROM developer d
LEFT JOIN games g ON d.developer_id = g.developer_id
LEFT JOIN awards a ON a.game_id = g.game_id
GROUP BY d.developer_name
ORDER BY COUNT(a.award_id) DESC;

-- 8. Highest rated game franchises
SELECT f.franchise_id, f.franchise_name,  COUNT(DISTINCT g.game_id) AS "Number of games", COALESCE(ROUND(AVG(u.rating), 2), 0) AS "Average Rating"
FROM franchise f
LEFT JOIN games AS g ON g.franchise_id = f.franchise_id
LEFT JOIN user_reviews AS u ON u.game_id = g.game_id
GROUP BY f.franchise_id, f.franchise_name
ORDER BY "Average Rating" DESC;

-- 9. Oldest to newest video games and their average ratings
SELECT g.game_id, g.game_name, g.created_date, COALESCE(ROUND(AVG(ur.rating), 2), 0) AS "Average Rating"
FROM games g
LEFT JOIN user_reviews AS ur ON ur.game_id = g.game_id
GROUP BY g.game_id
ORDER BY g.created_date ASC;

-- 10. Find the newest and highest rating for each game
SELECT g.game_id, g.game_name, ur.user_id, ur.rating, ur.review_comment, ur.review_date
FROM user_reviews ur
JOIN games g ON g.game_id = ur.game_id
WHERE (ur.game_id, ur.rating, ur.review_date) IN (
    SELECT game_id, MAX(rating) AS rating, MAX(review_date) AS review_date
    FROM user_reviews
    GROUP BY game_id
    )
ORDER BY g.game_name;

-- 11. Function to get age

DELIMITER // 
CREATE FUNCTION f_calculate_age (date_of_birth DATE)
RETURNS INT
DETERMINISTIC
BEGIN
	RETURN TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE());
END //
DELIMITER ;

-- 12. Show all user data for every user, HELPS WITH TRIGGER TESTS
SELECT *
FROM users
-- TRIGGERS 

DELIMITER //

CREATE TRIGGER validate_user_age
BEFORE INSERT 
ON users
FOR EACH ROW
BEGIN
    DECLARE age INT;
    SET age = TIMESTAMPDIFF(YEAR, NEW.date_of_birth, CURDATE());

    IF age < 13 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'User must be at least 13 years old.';
    ELSEIF age > 100 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'User cannot be older than 100 and touch a video game no shot';
    END IF;
END;
//

DELIMITER ;

DELIMITER //

CREATE TRIGGER validate_user_age_update
BEFORE UPDATE ON users
FOR EACH ROW
BEGIN
    DECLARE age INT;
    SET age = TIMESTAMPDIFF(YEAR, NEW.date_of_birth, CURDATE());

    IF age < 13 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'User must be at least 13 years old.';
    ELSEIF age > 100 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'User cannot be older than 100 and touch a video game no shot';
    END IF;
END;
//

DELIMITER ;


-- INSERT TRIGGER AND UPDATE TRIGGER TESTS
SHOW TRIGGERS; 

INSERT INTO users (user_name, email, first_name, last_name, date_of_birth)
VALUES ('Too young test', 'young@class.com', 'Too', 'Young', '2020-02-03');

INSERT INTO users (user_name, email, first_name, last_name, date_of_birth)
VALUES ('Too old test', 'old@class.com', 'Too', 'Old', '1920-02-03');

UPDATE users
SET date_of_birth = '2020-01-01'
WHERE user_id = 1;

UPDATE users
SET date_of_birth = '1900-01-01'
WHERE user_id = 2;

-- Procedure for creating a new user; Gracefully handles any errors that might occur while adding new users. 

-- Drop the procedure if it already exists to allow for edits
DROP PROCEDURE IF EXISTS sp_add_new_user;

DELIMITER //

CREATE PROCEDURE p_add_new_user(
    -- IN parameters
    IN p_username VARCHAR(50),
    IN p_email VARCHAR(100),
    IN p_first_name VARCHAR(50),
    IN p_last_name VARCHAR(50),
    IN p_phone_number VARCHAR(15),
    IN p_date_of_birth DATE,
    
    -- OUT parameters
    OUT p_new_user_id INT,
    OUT p_status_message VARCHAR(255)
)
BEGIN
    -- This handler will "catch" any integrity constraint violation (e.g., duplicate key)
    -- SQLSTATE '23000' is the general class for integrity errors, including UNIQUE violations like for username and email in our case
    DECLARE EXIT HANDLER FOR SQLSTATE '23000'
    BEGIN
        -- Set the output parameters to reflect the error
        SET p_new_user_id = NULL;
        SET p_status_message = 'Error: A user with that username or email already exists.';
    END;
    
    -- This is a generic handler for any other unexpected SQL error
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SET p_new_user_id = NULL;
        SET p_status_message = 'Error: An unexpected database error occurred.';
    END;

    -- --- This is like a "TRY" block ---
    
    -- 1. Attempt the insertion
    INSERT INTO users (user_name, email, first_name, last_name, phone_number, date_of_birth)
    VALUES (p_username, p_email, p_first_name, p_last_name, p_phone_number, p_date_of_birth);
    
    -- 2. If the INSERT succeeds, the handlers are skipped.
    --    We set the success message and get the new ID.
    SET p_new_user_id = LAST_INSERT_ID();
    SET p_status_message = 'Success: User created.';
    
END //

DELIMITER ;
    
-- Call the procedure, passing in session variables (prefixed with @) for the OUT parameters
CALL p_add_new_user(
    'abc123', 
    'randomemail@gmail.com', 
    'John', 
    'Doe', 
    '210-987-6543', 
    '2000-01-01',
    @new_id,       -- This variable receives the new user_id (auto-incremented)
    @message      -- This variable receives the status message
);

-- Check the results
SELECT @new_id, @message;
