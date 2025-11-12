-- Group 9: Fantastic Four
-- CS3743 Database Systems
-- Database: video_game_db

CREATE DATABASE IF NOT EXISTS video_game_db;
USE video_game_db;

-- users
CREATE TABLE IF NOT EXISTS users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    user_name VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone_number VARCHAR(15),
    date_of_birth DATE NOT NULL
);

-- initialize table not dependent on other tables
-- genre
CREATE TABLE IF NOT EXISTS genre (
    genre_id INT PRIMARY KEY AUTO_INCREMENT,
    genre_name VARCHAR(100) UNIQUE NOT NULL
);

-- publisher
CREATE TABLE IF NOT EXISTS publisher (
    publisher_id INT PRIMARY KEY AUTO_INCREMENT,
    publisher_name VARCHAR(100) NOT NULL,
    date_established DATE
);

-- developer
CREATE TABLE IF NOT EXISTS developer (
    developer_id INT PRIMARY KEY AUTO_INCREMENT,
    developer_name VARCHAR(100) NOT NULL
);

-- franchise
CREATE TABLE IF NOT EXISTS franchise (
    franchise_id INT PRIMARY KEY AUTO_INCREMENT,
    franchise_name VARCHAR(50) NOT NULL,
    establish_date DATE,
    latest_release VARCHAR(100) UNIQUE
);

-- platform
CREATE TABLE IF NOT EXISTS platform (
    platform_id INT PRIMARY KEY AUTO_INCREMENT,
    platform_name VARCHAR(50) NOT NULL,
    game_release_date DATE
);

-- initialize tables w/ FK
-- games
CREATE TABLE IF NOT EXISTS games (
    game_id INT PRIMARY KEY AUTO_INCREMENT,
    game_name VARCHAR(100) NOT NULL,
    game_description TEXT,
    multiplayer BOOLEAN DEFAULT FALSE,
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0.00),
    age_rating VARCHAR(100) NOT NULL,
    created_date DATE,
    genre_id INT NOT NULL,
    developer_id INT NOT NULL,
    franchise_id INT,
    publisher_id INT NOT NULL,
    FOREIGN KEY (genre_id) REFERENCES genre(genre_id),
    FOREIGN KEY (developer_id) REFERENCES developer(developer_id),
    FOREIGN KEY (franchise_id) REFERENCES franchise(franchise_id),
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id)
);

-- user_following (self referencing)
CREATE TABLE IF NOT EXISTS user_following (
    user_id1 INT NOT NULL,  -- follower
    user_id2 INT NOT NULL,  -- being followed
    PRIMARY KEY (user_id1, user_id2),
    FOREIGN KEY (user_id1) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id2) REFERENCES users(user_id) ON DELETE CASCADE,
    CHECK (user_id1 <> user_id2)
);

-- user_games
CREATE TABLE IF NOT EXISTS user_games (
    user_games_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    game_id INT NOT NULL,
    following_date DATE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (game_id) REFERENCES games(game_id)
);

-- user_reviews
CREATE TABLE user_reviews (
    user_reviews_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    game_id INT NOT NULL,
    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    review_comment TEXT CHECK (CHAR_LENGTH(review_comment) BETWEEN 20 AND 2000),
    review_date DATE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (game_id) REFERENCES games(game_id) ON DELETE CASCADE,
    UNIQUE (user_id, game_id)  -- prevent duplicate reviews per user/game
);


-- awards
CREATE TABLE IF NOT EXISTS awards (
    award_id INT PRIMARY KEY AUTO_INCREMENT,
    award_name VARCHAR(100) NOT NULL,
    date_awarded DATE,
    awarded_by VARCHAR(100),
    game_id INT,
    FOREIGN KEY (game_id) REFERENCES games(game_id)
);

-- game_genre 
CREATE TABLE IF NOT EXISTS game_genre (
    game_id INT NOT NULL,
    genre_id INT NOT NULL,
    PRIMARY KEY (game_id, genre_id),
    FOREIGN KEY (game_id) REFERENCES games(game_id),
    FOREIGN KEY (genre_id) REFERENCES genre(genre_id)
);

-- game_platform
CREATE TABLE IF NOT EXISTS game_platform (
    game_id INT NOT NULL,
    platform_id INT NOT NULL,
    PRIMARY KEY (game_id, platform_id),
    FOREIGN KEY (game_id) REFERENCES games(game_id),
    FOREIGN KEY (platform_id) REFERENCES platform(platform_id)
);

-- game_franchise
CREATE TABLE IF NOT EXISTS game_franchise (
    game_id INT NOT NULL,
    franchise_id INT NOT NULL,
    PRIMARY KEY (game_id, franchise_id),
    FOREIGN KEY (game_id) REFERENCES games(game_id),
    FOREIGN KEY (franchise_id) REFERENCES franchise(franchise_id)
);

-- all tables initialized 

-- DROP DATABASE video_game_db;

/*
TRIGGER EXAMPLES:
	BEFORE INSERT: validate users date of birth is valid, not over 100 or under 13?
	BEFORE INSERT: validate user age meets age requirements for game user is wanting to add to their account
    BEFORE INSERT: validate user doesnt already follow other user
    BEFORE INSERT: validate user hasn't already reviewed game if wanting to review again
    AFTER UPDATE: update users review date to CURRDATE if they update their review
    BEFORE INSERT: validate developer != user so they can't review their own game (idk if we really need this)
    BEFORE INSERT: validate user has base game befofre they are able to add expansion pack to account
*/

-- TRIGGERS 

DELIMITER //

CREATE TRIGGER validate_user_age
BEFORE INSERT ON users
FOR EACH ROW
BEGIN
	DECLARE age INT;
    SET age = TIMESTAMPDIFF(YEAR, NEW.date_of_birth, CURDATE());
    
    IF age < 13 THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'User must atleast be 13 years old.';
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
		SET MESSAGE_TEXT = 'User must atleast be 13 years old.';
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