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
