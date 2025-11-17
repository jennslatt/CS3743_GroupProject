-- MySQL dump 10.13  Distrib 8.0.42, for macos15 (arm64)
--
-- Host: localhost    Database: video_game_db
-- ------------------------------------------------------
-- Server version	9.4.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `awards`
--

DROP TABLE IF EXISTS `awards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `awards` (
  `award_id` int NOT NULL AUTO_INCREMENT,
  `award_name` varchar(100) NOT NULL,
  `date_awarded` date DEFAULT NULL,
  `awarded_by` varchar(100) DEFAULT NULL,
  `game_id` int DEFAULT NULL,
  PRIMARY KEY (`award_id`),
  KEY `game_id` (`game_id`),
  CONSTRAINT `awards_ibfk_1` FOREIGN KEY (`game_id`) REFERENCES `games` (`game_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `awards`
--

LOCK TABLES `awards` WRITE;
/*!40000 ALTER TABLE `awards` DISABLE KEYS */;
INSERT INTO `awards` VALUES (1,'Game of the Year','2020-12-15','Game Awards',1),(2,'Best Narrative','2020-12-15','Game Awards',1),(3,'Best Art Direction','2020-12-15','Game Awards',2),(4,'RPG of the Year','2022-03-20','IGN Awards',3),(5,'Best Multiplayer','2013-12-01','Spike Video Game Awards',6),(6,'Best RPG','2023-07-10','Game Awards',8),(7,'Best Open World','2011-12-10','Game Critics Awards',9),(8,'Best Puzzle Game','2011-06-20','IGN Awards',12),(9,'Best Simulation','2011-12-15','Game Awards',13),(10,'Best Family Game','2017-11-05','Game Awards',5),(11,'Best Shooter','2019-11-20','Game Awards',11),(12,'Best Indie Game','2018-01-30','Game Awards',26),(13,'Best Fighting Game','2018-12-20','Game Awards',30),(14,'Best Design','2022-11-25','IGN Awards',21),(15,'Game of the Year','2016-12-10','Game Awards',28),(16,'Best Platformer','2015-12-15','Game Awards',18);
/*!40000 ALTER TABLE `awards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `developer`
--

DROP TABLE IF EXISTS `developer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `developer` (
  `developer_id` int NOT NULL AUTO_INCREMENT,
  `developer_name` varchar(100) NOT NULL,
  PRIMARY KEY (`developer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `developer`
--

LOCK TABLES `developer` WRITE;
/*!40000 ALTER TABLE `developer` DISABLE KEYS */;
INSERT INTO `developer` VALUES (1,'Naughty Dog'),(2,'CD Projekt Red'),(3,'FromSoftware'),(4,'Ubisoft'),(5,'Nintendo'),(6,'Rockstar Games'),(7,'Insomniac Games'),(8,'Square Enix'),(9,'Bethesda'),(10,'Valve');
/*!40000 ALTER TABLE `developer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `franchise`
--

DROP TABLE IF EXISTS `franchise`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `franchise` (
  `franchise_id` int NOT NULL AUTO_INCREMENT,
  `franchise_name` varchar(50) NOT NULL,
  `establish_date` date DEFAULT NULL,
  `latest_release` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`franchise_id`),
  UNIQUE KEY `latest_release` (`latest_release`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `franchise`
--

LOCK TABLES `franchise` WRITE;
/*!40000 ALTER TABLE `franchise` DISABLE KEYS */;
INSERT INTO `franchise` VALUES (1,'The Legend of Zelda','1986-02-21','Tears of the Kingdom'),(2,'Grand Theft Auto','1997-10-21','GTA V'),(3,'Call of Duty','2003-10-29','Modern Warfare III'),(4,'Elder Scrolls','1994-03-25','Skyrim'),(5,'Final Fantasy','1987-12-18','Final Fantasy XVI'),(6,'Dark Souls','2011-09-22','Elden Ring'),(7,'Super Mario','1985-09-13','Super Mario Odyssey'),(8,'Half-Life','1998-11-19','Half-Life Alyx');
/*!40000 ALTER TABLE `franchise` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_franchise`
--

DROP TABLE IF EXISTS `game_franchise`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `game_franchise` (
  `game_id` int NOT NULL,
  `franchise_id` int NOT NULL,
  PRIMARY KEY (`game_id`,`franchise_id`),
  KEY `franchise_id` (`franchise_id`),
  CONSTRAINT `game_franchise_ibfk_1` FOREIGN KEY (`game_id`) REFERENCES `games` (`game_id`),
  CONSTRAINT `game_franchise_ibfk_2` FOREIGN KEY (`franchise_id`) REFERENCES `franchise` (`franchise_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_franchise`
--

LOCK TABLES `game_franchise` WRITE;
/*!40000 ALTER TABLE `game_franchise` DISABLE KEYS */;
/*!40000 ALTER TABLE `game_franchise` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_genre`
--

DROP TABLE IF EXISTS `game_genre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `game_genre` (
  `game_id` int NOT NULL,
  `genre_id` int NOT NULL,
  PRIMARY KEY (`game_id`,`genre_id`),
  KEY `genre_id` (`genre_id`),
  CONSTRAINT `game_genre_ibfk_1` FOREIGN KEY (`game_id`) REFERENCES `games` (`game_id`),
  CONSTRAINT `game_genre_ibfk_2` FOREIGN KEY (`genre_id`) REFERENCES `genre` (`genre_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_genre`
--

LOCK TABLES `game_genre` WRITE;
/*!40000 ALTER TABLE `game_genre` DISABLE KEYS */;
INSERT INTO `game_genre` VALUES (1,1),(6,1),(7,1),(16,1),(20,1),(29,1),(4,2),(5,2),(19,2),(22,2),(2,3),(3,3),(8,3),(9,3),(23,3),(28,3),(10,4),(11,4),(21,4),(25,4),(13,5),(14,5),(17,5),(24,5),(18,6),(27,6),(12,8),(26,8),(15,9),(30,10);
/*!40000 ALTER TABLE `game_genre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_platform`
--

DROP TABLE IF EXISTS `game_platform`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `game_platform` (
  `game_id` int NOT NULL,
  `platform_id` int NOT NULL,
  PRIMARY KEY (`game_id`,`platform_id`),
  KEY `platform_id` (`platform_id`),
  CONSTRAINT `game_platform_ibfk_1` FOREIGN KEY (`game_id`) REFERENCES `games` (`game_id`),
  CONSTRAINT `game_platform_ibfk_2` FOREIGN KEY (`platform_id`) REFERENCES `platform` (`platform_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_platform`
--

LOCK TABLES `game_platform` WRITE;
/*!40000 ALTER TABLE `game_platform` DISABLE KEYS */;
INSERT INTO `game_platform` VALUES (1,1),(3,1),(4,1),(6,1),(7,1),(8,1),(11,1),(15,1),(21,1),(22,1),(23,1),(29,1),(3,2),(4,2),(6,2),(7,2),(11,2),(29,2),(5,3),(14,3),(19,3),(20,3),(30,3),(1,4),(2,4),(3,4),(6,4),(9,4),(10,4),(11,4),(12,4),(13,4),(15,4),(16,4),(17,4),(18,4),(21,4),(23,4),(24,4),(25,4),(26,4),(27,4),(28,4);
/*!40000 ALTER TABLE `game_platform` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `games`
--

DROP TABLE IF EXISTS `games`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `games` (
  `game_id` int NOT NULL AUTO_INCREMENT,
  `game_name` varchar(100) NOT NULL,
  `game_description` text,
  `multiplayer` tinyint(1) DEFAULT '0',
  `price` decimal(10,2) NOT NULL,
  `age_rating` varchar(100) NOT NULL,
  `created_date` date DEFAULT NULL,
  `genre_id` int NOT NULL,
  `developer_id` int NOT NULL,
  `franchise_id` int DEFAULT NULL,
  `publisher_id` int NOT NULL,
  PRIMARY KEY (`game_id`),
  KEY `genre_id` (`genre_id`),
  KEY `developer_id` (`developer_id`),
  KEY `franchise_id` (`franchise_id`),
  KEY `publisher_id` (`publisher_id`),
  CONSTRAINT `games_ibfk_1` FOREIGN KEY (`genre_id`) REFERENCES `genre` (`genre_id`),
  CONSTRAINT `games_ibfk_2` FOREIGN KEY (`developer_id`) REFERENCES `developer` (`developer_id`),
  CONSTRAINT `games_ibfk_3` FOREIGN KEY (`franchise_id`) REFERENCES `franchise` (`franchise_id`),
  CONSTRAINT `games_ibfk_4` FOREIGN KEY (`publisher_id`) REFERENCES `publisher` (`publisher_id`),
  CONSTRAINT `games_chk_1` CHECK ((`price` >= 0.00))
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `games`
--

LOCK TABLES `games` WRITE;
/*!40000 ALTER TABLE `games` DISABLE KEYS */;
INSERT INTO `games` VALUES (1,'The Last of Us Part II','A gripping narrative-driven action game.',0,59.99,'Mature','2020-06-19',1,1,NULL,1),(2,'Cyberpunk 2077','Open-world RPG set in a futuristic city.',1,49.99,'Mature','2020-12-10',3,2,NULL,2),(3,'Elden Ring','Fantasy open world RPG by FromSoftware.',1,69.99,'Mature','2022-02-25',3,3,6,2),(4,'Assassin\'s Creed Valhalla','Viking-era adventure and exploration.',1,59.99,'Mature','2020-11-10',2,4,NULL,4),(5,'Super Mario Odyssey','Mario explores worlds to rescue Princess Peach.',0,49.99,'Everyone','2017-10-27',2,5,7,3),(6,'Grand Theft Auto V','Crime and chaos in Los Santos.',1,29.99,'Mature','2013-09-17',1,6,2,7),(7,'Spider-Man','Peter Parker battles villains across NYC.',1,39.99,'Teen','2018-09-07',1,7,NULL,1),(8,'Final Fantasy XVI','Epic fantasy RPG with rich storylines.',0,69.99,'Teen','2023-06-22',3,8,5,6),(9,'Skyrim','Fantasy RPG with dragons and open world exploration.',1,39.99,'Mature','2011-11-11',3,9,4,5),(10,'Half-Life 2','Sci-fi shooter featuring Gordon Freeman.',0,9.99,'Mature','2004-11-16',4,10,8,10),(11,'Call of Duty: Modern Warfare','Military FPS with cinematic storytelling.',1,59.99,'Mature','2019-10-25',4,4,3,4),(12,'Portal 2','Puzzle platformer with physics challenges.',1,19.99,'Everyone','2011-04-19',8,10,NULL,10),(13,'Minecraft','Blocky sandbox building game.',1,26.95,'Everyone','2011-11-18',5,4,NULL,8),(14,'Animal Crossing: New Horizons','Life-sim where players build island communities.',0,59.99,'Everyone','2020-03-20',5,5,NULL,3),(15,'Resident Evil Village','Survival horror adventure with intense combat.',0,59.99,'Mature','2021-05-07',9,4,NULL,2),(16,'Hades','Greek mythology rogue-like action game.',0,24.99,'Teen','2020-09-17',1,10,NULL,10),(17,'Stardew Valley','Farm life simulation RPG.',0,14.99,'Everyone','2016-02-26',5,10,NULL,10),(18,'Rocket League','Soccer with cars multiplayer game.',1,0.00,'Everyone','2015-07-07',6,4,NULL,9),(19,'The Legend of Zelda: Tears of the Kingdom','Open-world adventure set in Hyrule.',0,69.99,'Everyone','2023-05-12',2,5,1,3),(20,'Metroid Dread','Sci-fi action platformer from Nintendo.',0,59.99,'Teen','2021-10-08',1,5,NULL,3),(21,'Halo Infinite','Sci-fi shooter with multiplayer modes.',1,59.99,'Teen','2021-12-08',4,4,NULL,8),(22,'God of War Ragnarök','Epic Norse adventure with Kratos.',0,69.99,'Mature','2022-11-09',2,1,NULL,1),(23,'Final Fantasy VII Remake','Modern retelling of classic JRPG.',0,69.99,'Teen','2020-04-10',3,8,5,6),(24,'The Sims 4','Life simulation with creativity and control.',1,39.99,'Everyone','2014-09-02',5,9,NULL,9),(25,'Overwatch 2','Team-based hero shooter.',1,0.00,'Teen','2022-10-04',4,4,NULL,9),(26,'Celeste','Challenging platformer with emotional story.',0,19.99,'Everyone','2018-01-25',8,10,NULL,10),(27,'FIFA 23','Soccer simulation with real teams.',1,59.99,'Everyone','2022-09-30',6,4,NULL,9),(28,'Dark Souls III','Challenging RPG from FromSoftware.',1,59.99,'Mature','2016-04-12',3,3,6,2),(29,'GTA IV','Open-world crime drama in Liberty City.',1,29.99,'Mature','2008-04-29',1,6,2,7),(30,'Super Smash Bros Ultimate','All-star fighting game crossover.',1,59.99,'Everyone','2018-12-07',10,5,7,3);
/*!40000 ALTER TABLE `games` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genre`
--

DROP TABLE IF EXISTS `genre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `genre` (
  `genre_id` int NOT NULL AUTO_INCREMENT,
  `genre_name` varchar(100) NOT NULL,
  PRIMARY KEY (`genre_id`),
  UNIQUE KEY `genre_name` (`genre_name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genre`
--

LOCK TABLES `genre` WRITE;
/*!40000 ALTER TABLE `genre` DISABLE KEYS */;
INSERT INTO `genre` VALUES (1,'Action'),(2,'Adventure'),(10,'Fighting'),(9,'Horror'),(8,'Puzzle'),(3,'RPG'),(4,'Shooter'),(5,'Simulation'),(6,'Sports'),(7,'Strategy');
/*!40000 ALTER TABLE `genre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `platform`
--

DROP TABLE IF EXISTS `platform`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `platform` (
  `platform_id` int NOT NULL AUTO_INCREMENT,
  `platform_name` varchar(50) NOT NULL,
  `game_release_date` date DEFAULT NULL,
  PRIMARY KEY (`platform_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `platform`
--

LOCK TABLES `platform` WRITE;
/*!40000 ALTER TABLE `platform` DISABLE KEYS */;
INSERT INTO `platform` VALUES (1,'PlayStation 5',NULL),(2,'Xbox Series X',NULL),(3,'Nintendo Switch',NULL),(4,'PC',NULL),(5,'Steam Deck',NULL),(6,'PlayStation 4',NULL),(7,'Xbox One',NULL),(8,'Mobile',NULL);
/*!40000 ALTER TABLE `platform` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publisher`
--

DROP TABLE IF EXISTS `publisher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `publisher` (
  `publisher_id` int NOT NULL AUTO_INCREMENT,
  `publisher_name` varchar(100) NOT NULL,
  `date_established` date DEFAULT NULL,
  PRIMARY KEY (`publisher_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publisher`
--

LOCK TABLES `publisher` WRITE;
/*!40000 ALTER TABLE `publisher` DISABLE KEYS */;
INSERT INTO `publisher` VALUES (1,'Sony Interactive Entertainment','1993-11-16'),(2,'Bandai Namco','1955-06-01'),(3,'Nintendo Co., Ltd.','1889-09-23'),(4,'Ubisoft Entertainment','1986-03-28'),(5,'Bethesda Softworks','1986-06-28'),(6,'Square Enix Holdings','2003-04-01'),(7,'Take-Two Interactive','1993-09-30'),(8,'Microsoft Studios','2002-03-01'),(9,'Electronic Arts','1982-05-28'),(10,'Valve Corporation','1996-08-24');
/*!40000 ALTER TABLE `publisher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_following`
--

DROP TABLE IF EXISTS `user_following`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_following` (
  `user_id1` int NOT NULL,
  `user_id2` int NOT NULL,
  PRIMARY KEY (`user_id1`,`user_id2`),
  KEY `user_id2` (`user_id2`),
  CONSTRAINT `user_following_ibfk_1` FOREIGN KEY (`user_id1`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `user_following_ibfk_2` FOREIGN KEY (`user_id2`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `user_following_chk_1` CHECK ((`user_id1` <> `user_id2`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_following`
--

LOCK TABLES `user_following` WRITE;
/*!40000 ALTER TABLE `user_following` DISABLE KEYS */;
INSERT INTO `user_following` VALUES (2,1),(3,1),(5,1),(7,1),(13,1),(15,1),(1,2),(4,2),(6,2),(14,2),(1,3),(6,3),(10,3),(3,4),(10,4),(1,5),(9,5),(2,6),(9,6),(3,7),(4,8),(7,8),(5,9),(8,9),(5,10),(8,10),(6,11),(11,12),(12,13);
/*!40000 ALTER TABLE `user_following` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_games`
--

DROP TABLE IF EXISTS `user_games`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_games` (
  `user_games_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `game_id` int NOT NULL,
  `following_date` date DEFAULT NULL,
  PRIMARY KEY (`user_games_id`),
  KEY `user_id` (`user_id`),
  KEY `game_id` (`game_id`),
  CONSTRAINT `user_games_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `user_games_ibfk_2` FOREIGN KEY (`game_id`) REFERENCES `games` (`game_id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_games`
--

LOCK TABLES `user_games` WRITE;
/*!40000 ALTER TABLE `user_games` DISABLE KEYS */;
INSERT INTO `user_games` VALUES (1,1,3,'2023-07-12'),(2,1,8,'2024-01-03'),(3,1,19,'2023-05-20'),(4,2,6,'2024-03-05'),(5,2,11,'2024-03-10'),(6,2,18,'2023-11-11'),(7,3,1,'2022-06-10'),(8,3,3,'2023-04-02'),(9,3,9,'2023-10-08'),(10,4,5,'2023-05-15'),(11,4,13,'2023-07-04'),(12,5,6,'2022-11-30'),(13,5,29,'2024-02-22'),(14,5,30,'2024-03-10'),(15,6,2,'2023-12-15'),(16,6,3,'2023-12-18'),(17,6,11,'2024-01-05'),(18,7,7,'2023-04-20'),(19,7,8,'2023-06-14'),(20,7,22,'2024-02-10'),(21,8,9,'2023-03-19'),(22,8,10,'2023-04-01'),(23,8,25,'2024-03-15'),(24,9,4,'2024-02-18'),(25,9,5,'2023-12-05'),(26,10,6,'2023-08-22'),(27,10,15,'2023-09-30'),(28,11,10,'2023-06-20'),(29,11,24,'2023-11-08'),(30,12,12,'2023-10-10'),(31,12,17,'2024-02-19'),(32,13,18,'2023-07-14'),(33,13,21,'2023-11-25'),(34,14,2,'2023-08-08'),(35,14,8,'2023-09-18'),(36,15,23,'2023-12-01'),(37,15,26,'2023-12-09'),(38,15,9,'2024-02-20'),(39,10,3,'2024-03-11'),(40,12,6,'2023-09-14');
/*!40000 ALTER TABLE `user_games` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_reviews`
--

DROP TABLE IF EXISTS `user_reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_reviews` (
  `user_reviews_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `game_id` int NOT NULL,
  `rating` int NOT NULL,
  `review_comment` text,
  `review_date` date NOT NULL,
  PRIMARY KEY (`user_reviews_id`),
  UNIQUE KEY `user_id` (`user_id`,`game_id`),
  KEY `game_id` (`game_id`),
  CONSTRAINT `user_reviews_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `user_reviews_ibfk_2` FOREIGN KEY (`game_id`) REFERENCES `games` (`game_id`) ON DELETE CASCADE,
  CONSTRAINT `user_reviews_chk_1` CHECK ((`rating` between 1 and 5)),
  CONSTRAINT `user_reviews_chk_2` CHECK ((char_length(`review_comment`) between 20 and 2000))
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_reviews`
--

LOCK TABLES `user_reviews` WRITE;
/*!40000 ALTER TABLE `user_reviews` DISABLE KEYS */;
INSERT INTO `user_reviews` VALUES (1,1,3,5,'Elden Ring is breathtaking and brutally challenging. The world feels alive.','2023-08-01'),(2,1,8,4,'Final Fantasy XVI has beautiful storytelling and visuals.','2024-02-20'),(3,1,19,5,'Tears of the Kingdom blew my mind. The creativity is endless.','2023-06-01'),(4,2,6,5,'GTA V never gets old, love the open-world chaos.','2024-04-01'),(5,2,18,4,'Rocket League is addictive fun, though matchmaking can be uneven.','2023-11-20'),(6,3,1,5,'The Last of Us II is emotional and powerful. Stunning storytelling.','2022-08-20'),(7,3,9,4,'Skyrim remains the best fantasy RPG even after all these years.','2023-10-15'),(8,4,5,4,'Super Mario Odyssey is joyful, polished, and nostalgic.','2023-06-20'),(9,4,13,5,'Minecraft gives endless freedom. A masterpiece in creativity.','2023-08-15'),(10,5,30,5,'Super Smash Bros Ultimate is chaotic fun with friends.','2024-03-12'),(11,5,29,4,'Dark Souls III tests patience but rewards persistence.','2024-03-20'),(12,6,2,4,'Cyberpunk 2077 has improved dramatically since launch.','2024-01-10'),(13,6,11,5,'Modern Warfare still delivers the best shooter action.','2024-01-19'),(14,7,7,3,'Spider-Man\'s combat is fluid, but missions can feel repetitive.','2023-05-02'),(15,7,14,5,'Animal Crossing is pure relaxation. Adorable and chill.','2023-12-25'),(16,8,10,4,'Half-Life 2 redefines storytelling in shooters.','2023-04-10'),(17,9,22,5,'God of War Ragnarök is a masterpiece in design and emotion.','2023-12-05'),(18,10,15,3,'Resident Evil Village is spooky and cinematic, though linear.','2023-11-11'),(19,11,23,5,'Final Fantasy VII Remake captures nostalgia perfectly.','2023-05-01'),(20,12,24,4,'The Sims 4 is endlessly creative and fun.','2024-03-15');
/*!40000 ALTER TABLE `user_reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `user_name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `phone_number` varchar(15) DEFAULT NULL,
  `date_of_birth` date NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_name` (`user_name`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'luna_gamer','luna@example.com','Luna','Morales','2105551123','1998-06-14'),(2,'ryan_playz','ryan@example.com','Ryan','Johnson','5125552222','2002-01-08'),(3,'shadowwolf','wolf@example.com','Alex','Carter','8325553344','1996-09-19'),(4,'pixie_dust','pixie@example.com','Chloe','Nguyen','2145558899','2005-04-22'),(5,'dragonlord','dragon@example.com','Mark','Bennett','7375555522','1990-11-30'),(6,'techiejay','jay@example.com','Jay','Patel','4695559001','2001-02-05'),(7,'marieplays','marie@example.com','Marie','Lopez','2815556677','1997-10-25'),(8,'xenofox','fox@example.com','Theo','Reed','9155558888','2003-08-15'),(9,'katcoder','kat@example.com','Katherine','Li','2105559900','2004-05-09'),(10,'icebear','bear@example.com','Jacob','Miller','6825553333','1999-03-14'),(11,'neo_77','neo@example.com','Neal','Peters','3255550001','1995-12-05'),(12,'skygazer','sky@example.com','Amelia','Woods','4325554444','2002-06-19'),(13,'mecha_mike','mike@example.com','Michael','Kim','7135552233','1989-09-09'),(14,'arcadia','arcadia@example.com','Aria','Singh','2105555566','2000-11-03'),(15,'bladequeen','blade@example.com','Elena','Gonzalez','7375557788','1993-07-28'),(16,'abc123','randomemail@gmail.com','John','Doe','210-987-6543','2000-01-01');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `validate_user_age` BEFORE INSERT ON `users` FOR EACH ROW BEGIN
    DECLARE age INT;
    SET age = TIMESTAMPDIFF(YEAR, NEW.date_of_birth, CURDATE());

    IF age < 13 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'User must atleast be 13 years old.';
    ELSEIF age > 100 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'User cannot be older than 100 and touch a video game no shot';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `validate_user_age_update` BEFORE UPDATE ON `users` FOR EACH ROW BEGIN
    DECLARE age INT;
    SET age = TIMESTAMPDIFF(YEAR, NEW.date_of_birth, CURDATE());

    IF age < 13 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'User must atleast be 13 years old.';
    ELSEIF age > 100 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'User cannot be older than 100 and touch a video game no shot';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping routines for database 'video_game_db'
--
/*!50003 DROP FUNCTION IF EXISTS `f_calculate_age` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `f_calculate_age`(date_of_birth DATE) RETURNS int
    DETERMINISTIC
BEGIN
	RETURN TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE());
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `p_add_new_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `p_add_new_user`(
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
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-12 22:46:12
