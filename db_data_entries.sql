-- DATA INSERTS

USE video_game_db;

-- USERS (15)
INSERT INTO users (user_name, email, first_name, last_name, phone_number, date_of_birth)
VALUES
('luna_gamer', 'luna@example.com', 'Luna', 'Morales', '2105551123', '1998-06-14'), -- pk = 1 than auto increments
('ryan_playz', 'ryan@example.com', 'Ryan', 'Johnson', '5125552222', '2002-01-08'),
('shadowwolf', 'wolf@example.com', 'Alex', 'Carter', '8325553344', '1996-09-19'),
('pixie_dust', 'pixie@example.com', 'Chloe', 'Nguyen', '2145558899', '2005-04-22'),
('dragonlord', 'dragon@example.com', 'Mark', 'Bennett', '7375555522', '1990-11-30'),
('techiejay', 'jay@example.com', 'Jay', 'Patel', '4695559001', '2001-02-05'),
('marieplays', 'marie@example.com', 'Marie', 'Lopez', '2815556677', '1997-10-25'),
('xenofox', 'fox@example.com', 'Theo', 'Reed', '9155558888', '2003-08-15'),
('katcoder', 'kat@example.com', 'Katherine', 'Li', '2105559900', '2004-05-09'),
('icebear', 'bear@example.com', 'Jacob', 'Miller', '6825553333', '1999-03-14'),
('neo_77', 'neo@example.com', 'Neal', 'Peters', '3255550001', '1995-12-05'),
('skygazer', 'sky@example.com', 'Amelia', 'Woods', '4325554444', '2002-06-19'),
('mecha_mike', 'mike@example.com', 'Michael', 'Kim', '7135552233', '1989-09-09'),
('arcadia', 'arcadia@example.com', 'Aria', 'Singh', '2105555566', '2000-11-03'),
('bladequeen', 'blade@example.com', 'Elena', 'Gonzalez', '7375557788', '1993-07-28');

-- GENRES (10)
INSERT INTO genre (genre_name) VALUES
('Action'),
('Adventure'),
('RPG'),
('Shooter'),
('Simulation'),
('Sports'),
('Strategy'),
('Puzzle'),
('Horror'),
('Fighting');

-- DEVELOPERS (10)
INSERT INTO developer (developer_name) VALUES
('Naughty Dog'),
('CD Projekt Red'),
('FromSoftware'),
('Ubisoft'),
('Nintendo'),
('Rockstar Games'),
('Insomniac Games'),
('Square Enix'),
('Bethesda'),
('Valve');

-- PUBLISHERS (10)
INSERT INTO publisher (publisher_name, date_established) VALUES
('Sony Interactive Entertainment', '1993-11-16'),
('Bandai Namco', '1955-06-01'),
('Nintendo Co., Ltd.', '1889-09-23'),
('Ubisoft Entertainment', '1986-03-28'),
('Bethesda Softworks', '1986-06-28'),
('Square Enix Holdings', '2003-04-01'),
('Take-Two Interactive', '1993-09-30'),
('Microsoft Studios', '2002-03-01'),
('Electronic Arts', '1982-05-28'),
('Valve Corporation', '1996-08-24');

-- FRANCHISES (8)
INSERT INTO franchise (franchise_name, establish_date, latest_release) VALUES
('The Legend of Zelda', '1986-02-21', 'Tears of the Kingdom'),
('Grand Theft Auto', '1997-10-21', 'GTA V'),
('Call of Duty', '2003-10-29', 'Modern Warfare III'),
('Elder Scrolls', '1994-03-25', 'Skyrim'),
('Final Fantasy', '1987-12-18', 'Final Fantasy XVI'),
('Dark Souls', '2011-09-22', 'Elden Ring'),
('Super Mario', '1985-09-13', 'Super Mario Odyssey'),
('Half-Life', '1998-11-19', 'Half-Life Alyx');

-- PLATFORMS (8)
INSERT INTO platform (platform_name, game_release_date) VALUES
('PlayStation 5', NULL),
('Xbox Series X', NULL),
('Nintendo Switch', NULL),
('PC', NULL),
('Steam Deck', NULL),
('PlayStation 4', NULL),
('Xbox One', NULL),
('Mobile', NULL);

-- GAMES (30)
INSERT INTO games (game_name, game_description, multiplayer, price, age_rating, created_date, genre_id, developer_id, franchise_id, publisher_id)
VALUES
('The Last of Us Part II', 'A gripping narrative-driven action game.', FALSE, 59.99, 'Mature', '2020-06-19', 1, 1, NULL, 1),
('Cyberpunk 2077', 'Open-world RPG set in a futuristic city.', TRUE, 49.99, 'Mature', '2020-12-10', 3, 2, NULL, 2),
('Elden Ring', 'Fantasy open world RPG by FromSoftware.', TRUE, 69.99, 'Mature', '2022-02-25', 3, 3, 6, 2),
('Assassin''s Creed Valhalla', 'Viking-era adventure and exploration.', TRUE, 59.99, 'Mature', '2020-11-10', 2, 4, NULL, 4),
('Super Mario Odyssey', 'Mario explores worlds to rescue Princess Peach.', FALSE, 49.99, 'Everyone', '2017-10-27', 2, 5, 7, 3),
('Grand Theft Auto V', 'Crime and chaos in Los Santos.', TRUE, 29.99, 'Mature', '2013-09-17', 1, 6, 2, 7),
('Spider-Man', 'Peter Parker battles villains across NYC.', TRUE, 39.99, 'Teen', '2018-09-07', 1, 7, NULL, 1),
('Final Fantasy XVI', 'Epic fantasy RPG with rich storylines.', FALSE, 69.99, 'Teen', '2023-06-22', 3, 8, 5, 6),
('Skyrim', 'Fantasy RPG with dragons and open world exploration.', TRUE, 39.99, 'Mature', '2011-11-11', 3, 9, 4, 5),
('Half-Life 2', 'Sci-fi shooter featuring Gordon Freeman.', FALSE, 9.99, 'Mature', '2004-11-16', 4, 10, 8, 10),
('Call of Duty: Modern Warfare', 'Military FPS with cinematic storytelling.', TRUE, 59.99, 'Mature', '2019-10-25', 4, 4, 3, 4),
('Portal 2', 'Puzzle platformer with physics challenges.', TRUE, 19.99, 'Everyone', '2011-04-19', 8, 10, NULL, 10),
('Minecraft', 'Blocky sandbox building game.', TRUE, 26.95, 'Everyone', '2011-11-18', 5, 4, NULL, 8),
('Animal Crossing: New Horizons', 'Life-sim where players build island communities.', FALSE, 59.99, 'Everyone', '2020-03-20', 5, 5, NULL, 3),
('Resident Evil Village', 'Survival horror adventure with intense combat.', FALSE, 59.99, 'Mature', '2021-05-07', 9, 4, NULL, 2),
('Hades', 'Greek mythology rogue-like action game.', FALSE, 24.99, 'Teen', '2020-09-17', 1, 10, NULL, 10),
('Stardew Valley', 'Farm life simulation RPG.', FALSE, 14.99, 'Everyone', '2016-02-26', 5, 10, NULL, 10),
('Rocket League', 'Soccer with cars multiplayer game.', TRUE, 0.00, 'Everyone', '2015-07-07', 6, 4, NULL, 9),
('The Legend of Zelda: Tears of the Kingdom', 'Open-world adventure set in Hyrule.', FALSE, 69.99, 'Everyone', '2023-05-12', 2, 5, 1, 3),
('Metroid Dread', 'Sci-fi action platformer from Nintendo.', FALSE, 59.99, 'Teen', '2021-10-08', 1, 5, NULL, 3),
('Halo Infinite', 'Sci-fi shooter with multiplayer modes.', TRUE, 59.99, 'Teen', '2021-12-08', 4, 4, NULL, 8),
('God of War Ragnarök', 'Epic Norse adventure with Kratos.', FALSE, 69.99, 'Mature', '2022-11-09', 2, 1, NULL, 1),
('Final Fantasy VII Remake', 'Modern retelling of classic JRPG.', FALSE, 69.99, 'Teen', '2020-04-10', 3, 8, 5, 6),
('The Sims 4', 'Life simulation with creativity and control.', TRUE, 39.99, 'Everyone', '2014-09-02', 5, 9, NULL, 9),
('Overwatch 2', 'Team-based hero shooter.', TRUE, 0.00, 'Teen', '2022-10-04', 4, 4, NULL, 9),
('Celeste', 'Challenging platformer with emotional story.', FALSE, 19.99, 'Everyone', '2018-01-25', 8, 10, NULL, 10),
('FIFA 23', 'Soccer simulation with real teams.', TRUE, 59.99, 'Everyone', '2022-09-30', 6, 4, NULL, 9),
('Dark Souls III', 'Challenging RPG from FromSoftware.', TRUE, 59.99, 'Mature', '2016-04-12', 3, 3, 6, 2),
('GTA IV', 'Open-world crime drama in Liberty City.', TRUE, 29.99, 'Mature', '2008-04-29', 1, 6, 2, 7),
('Super Smash Bros Ultimate', 'All-star fighting game crossover.', TRUE, 59.99, 'Everyone', '2018-12-07', 10, 5, 7, 3);

-- GAME_PLATFORM
INSERT INTO game_platform (game_id, platform_id) VALUES
(1, 1), (1, 4), -- The Last of Us Part II is available on PlayStation 5 and PC
(2, 4),
(3, 1), (3, 2), (3, 4),
(4, 1), (4, 2),
(5, 3),
(6, 1), (6, 2), (6, 4),
(7, 1), (7, 2),
(8, 1),
(9, 4),
(10, 4),
(11, 1), (11, 2), (11, 4),
(12, 4),
(13, 4),
(14, 3),
(15, 1), (15, 4),
(16, 4),
(17, 4),
(18, 4),
(19, 3),
(20, 3),
(21, 1), (21, 4),
(22, 1),
(23, 1), (23, 4),
(24, 4),
(25, 4),
(26, 4),
(27, 4),
(28, 4),
(29, 1), (29, 2),
(30, 3);

-- GAME_GENRE
INSERT INTO game_genre (game_id, genre_id) VALUES
(1, 1), (2, 3), (3, 3), (4, 2), (5, 2), (6, 1),
(7, 1), (8, 3), (9, 3), (10, 4), (11, 4), (12, 8),
(13, 5), (14, 5), (15, 9), (16, 1), (17, 5),
(18, 6), (19, 2), (20, 1), (21, 4), (22, 2),
(23, 3), (24, 5), (25, 4), (26, 8), (27, 6),
(28, 3), (29, 1), (30, 10);

-- USER_FOLLOWING (25)
INSERT INTO user_following (user_id1, user_id2) VALUES
(1, 2), (1, 3), (1, 5), -- luna follows Alex and Mark
(2, 1), (2, 6),
(3, 1), (3, 4), (3, 7),
(4, 2), (4, 8),
(5, 1), (5, 9), (5, 10),
(6, 2), (6, 3), (6, 11),
(7, 1), (7, 8),
(8, 9), (8, 10),
(9, 5), (9, 6),
(10, 3), (10, 4),
(11, 12), (12, 13),
(13, 1), (14, 2),
(15, 1);


-- USER_GAMES (40)
INSERT INTO user_games (user_id, game_id, following_date)
VALUES
(1, 3, '2023-07-12'),   -- Luna follows Elden Ring, pk = 1
(1, 8, '2024-01-03'),
(1, 19, '2023-05-20'),
(2, 6, '2024-03-05'),
(2, 11, '2024-03-10'),
(2, 18, '2023-11-11'),
(3, 1, '2022-06-10'),
(3, 3, '2023-04-02'),
(3, 9, '2023-10-08'),
(4, 5, '2023-05-15'),
(4, 13, '2023-07-04'),
(5, 6, '2022-11-30'),
(5, 29, '2024-02-22'),
(5, 30, '2024-03-10'),
(6, 2, '2023-12-15'),
(6, 3, '2023-12-18'),
(6, 11, '2024-01-05'),
(7, 7, '2023-04-20'),
(7, 8, '2023-06-14'),
(7, 22, '2024-02-10'),
(8, 9, '2023-03-19'),
(8, 10, '2023-04-01'),
(8, 25, '2024-03-15'),
(9, 4, '2024-02-18'),
(9, 5, '2023-12-05'),
(10, 6, '2023-08-22'),
(10, 15, '2023-09-30'),
(11, 10, '2023-06-20'),
(11, 24, '2023-11-08'),
(12, 12, '2023-10-10'),
(12, 17, '2024-02-19'),
(13, 18, '2023-07-14'),
(13, 21, '2023-11-25'),
(14, 2, '2023-08-08'),
(14, 8, '2023-09-18'),
(15, 23, '2023-12-01'),
(15, 26, '2023-12-09'),
(15, 9, '2024-02-20'),
(10, 3, '2024-03-11'),
(12, 6, '2023-09-14');

-- USER_REVIEWS (20) Simplified version: uses user_id + game_id)
INSERT INTO user_reviews (user_id, game_id, rating, review_comment, review_date)
VALUES
(1, 3, 5, 'Elden Ring is breathtaking and brutally challenging. The world feels alive.', '2023-08-01'), -- Luna - Elden Ring
(1, 8, 4, 'Final Fantasy XVI has beautiful storytelling and visuals.', '2024-02-20'), -- Luna - Final Fantasy XVI
(1, 19, 5, 'Tears of the Kingdom blew my mind. The creativity is endless.', '2023-06-01'), -- Luna - Tears of the Kingdom
(2, 6, 5, 'GTA V never gets old, love the open-world chaos.', '2024-04-01'), -- Ryan - GTA V
(2, 18, 4, 'Rocket League is addictive fun, though matchmaking can be uneven.', '2023-11-20'), -- Ryan - Rocket League
(3, 1, 5, 'The Last of Us II is emotional and powerful. Stunning storytelling.', '2022-08-20'), -- Alex - Last of Us II
(3, 9, 4, 'Skyrim remains the best fantasy RPG even after all these years.', '2023-10-15'), -- Alex - Skyrim
(4, 5, 4, 'Super Mario Odyssey is joyful, polished, and nostalgic.', '2023-06-20'), -- Chloe - Super Mario Odyssey
(4, 13, 5, 'Minecraft gives endless freedom. A masterpiece in creativity.', '2023-08-15'), -- Chloe - Minecraft
(5, 30, 5, 'Super Smash Bros Ultimate is chaotic fun with friends.', '2024-03-12'), -- Mark - Smash Bros
(5, 29, 4, 'Dark Souls III tests patience but rewards persistence.', '2024-03-20'), -- Mark - Dark Souls III
(6, 2, 4, 'Cyberpunk 2077 has improved dramatically since launch.', '2024-01-10'), -- Jay - Cyberpunk 2077
(6, 11, 5, 'Modern Warfare still delivers the best shooter action.', '2024-01-19'), -- Jay - Call of Duty: Modern Warfare
(7, 7, 3, 'Spider-Man''s combat is fluid, but missions can feel repetitive.', '2023-05-02'), -- Marie - Spider-Man
(7, 14, 5, 'Animal Crossing is pure relaxation. Adorable and chill.', '2023-12-25'), -- Marie - Animal Crossing: New Horizons
(8, 10, 4, 'Half-Life 2 redefines storytelling in shooters.', '2023-04-10'), -- Theo - Half-Life 2
(9, 22, 5, 'God of War Ragnarök is a masterpiece in design and emotion.', '2023-12-05'), -- Katherine - God of War Ragnarök
(10, 15, 3, 'Resident Evil Village is spooky and cinematic, though linear.', '2023-11-11'), -- Jacob - Resident Evil Village
(11, 23, 5, 'Final Fantasy VII Remake captures nostalgia perfectly.', '2023-05-01'), -- Neal - FFVII Remake
(12, 24, 4, 'The Sims 4 is endlessly creative and fun.', '2024-03-15'); -- Amelia - The Sims 4

-- AWARDS
INSERT INTO awards (award_name, date_awarded, awarded_by, game_id) VALUES
('Game of the Year', '2020-12-15', 'Game Awards', 1),   -- The Last of Us Part II
('Best Narrative', '2020-12-15', 'Game Awards', 1),
('Best Art Direction', '2020-12-15', 'Game Awards', 2), -- Cyberpunk 2077
('RPG of the Year', '2022-03-20', 'IGN Awards', 3),     -- Elden Ring
('Best Multiplayer', '2013-12-01', 'Spike Video Game Awards', 6), -- GTA V
('Best RPG', '2023-07-10', 'Game Awards', 8),           -- Final Fantasy XVI
('Best Open World', '2011-12-10', 'Game Critics Awards', 9), -- Skyrim
('Best Puzzle Game', '2011-06-20', 'IGN Awards', 12),   -- Portal 2
('Best Simulation', '2011-12-15', 'Game Awards', 13),   -- Minecraft
('Best Family Game', '2017-11-05', 'Game Awards', 5),   -- Super Mario Odyssey
('Best Shooter', '2019-11-20', 'Game Awards', 11),     -- Call of Duty: Modern Warfare
('Best Indie Game', '2018-01-30', 'Game Awards', 26),   -- Celeste
('Best Fighting Game', '2018-12-20', 'Game Awards', 30), -- Super Smash Bros Ultimate
('Best Design', '2022-11-25', 'IGN Awards', 21),       -- God of War Ragnarök
('Game of the Year', '2016-12-10', 'Game Awards', 28),  -- Dark Souls III
('Best Platformer', '2015-12-15', 'Game Awards', 18);   -- Rocket League
