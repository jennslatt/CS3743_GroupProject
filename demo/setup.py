import duckdb
import os

# --- 1. Cleaned SQL Schema and Data ---
SQL_SETUP = """
-- Core Tables
CREATE TABLE users (
    user_id INTEGER PRIMARY KEY,
    user_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone_number VARCHAR(15),
    date_of_birth DATE NOT NULL
);

CREATE TABLE genre (
    genre_id INTEGER PRIMARY KEY,
    genre_name VARCHAR(100) NOT NULL
);

CREATE TABLE publisher (
    publisher_id INTEGER PRIMARY KEY,
    publisher_name VARCHAR(100) NOT NULL,
    date_established DATE
);

CREATE TABLE developer (
    developer_id INTEGER PRIMARY KEY,
    developer_name VARCHAR(100) NOT NULL
);

CREATE TABLE franchise (
    franchise_id INTEGER PRIMARY KEY,
    franchise_name VARCHAR(50) NOT NULL,
    establish_date DATE,
    latest_release VARCHAR(100)
);

CREATE TABLE platform (
    platform_id INTEGER PRIMARY KEY,
    platform_name VARCHAR(50) NOT NULL,
    game_release_date DATE
);

-- Games Table with Foreign Keys
CREATE TABLE games (
    game_id INTEGER PRIMARY KEY,
    game_name VARCHAR(100) NOT NULL,
    game_description TEXT,
    multiplayer BOOLEAN DEFAULT FALSE,
    price DECIMAL(10,2) NOT NULL,
    age_rating VARCHAR(100) NOT NULL,
    created_date DATE,
    genre_id INTEGER NOT NULL,
    developer_id INTEGER NOT NULL,
    franchise_id INTEGER,
    publisher_id INTEGER NOT NULL
);

-- Relationship Tables
CREATE TABLE user_following (
    user_id1 INTEGER NOT NULL,
    user_id2 INTEGER NOT NULL
);

CREATE TABLE user_games (
    user_games_id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    game_id INTEGER NOT NULL,
    following_date DATE
);

CREATE TABLE user_reviews (
    user_reviews_id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    game_id INTEGER NOT NULL,
    rating INTEGER NOT NULL,
    review_comment TEXT,
    review_date DATE NOT NULL
);

CREATE TABLE awards (
    award_id INTEGER PRIMARY KEY,
    award_name VARCHAR(100) NOT NULL,
    date_awarded DATE,
    awarded_by VARCHAR(100),
    game_id INTEGER
);

CREATE TABLE game_platform (
    game_id INTEGER NOT NULL,
    platform_id INTEGER NOT NULL
);

CREATE TABLE game_genre (
    game_id INTEGER NOT NULL,
    genre_id INTEGER NOT NULL
);

-- DATA INSERTS
INSERT INTO users (user_id, user_name, email, first_name, last_name, phone_number, date_of_birth)
VALUES
(1, 'luna_gamer', 'luna@example.com', 'Luna', 'Morales', '2105551123', '1998-06-14'), 
(2, 'ryan_playz', 'ryan@example.com', 'Ryan', 'Johnson', '5125552222', '2002-01-08'),
(3, 'shadowwolf', 'wolf@example.com', 'Alex', 'Carter', '8325553344', '1996-09-19'),
(4, 'pixie_dust', 'pixie@example.com', 'Chloe', 'Nguyen', '2145558899', '2005-04-22'),
(5, 'dragonlord', 'dragon@example.com', 'Mark', 'Bennett', '7375555522', '1990-11-30');

INSERT INTO genre (genre_id, genre_name) VALUES
(1, 'Action'), (2, 'Adventure'), (3, 'RPG'), (4, 'Shooter'), (5, 'Simulation'),
(6, 'Sports'), (7, 'Strategy'), (8, 'Puzzle'), (9, 'Horror'), (10, 'Fighting');

INSERT INTO developer (developer_id, developer_name) VALUES
(1, 'Naughty Dog'), (2, 'CD Projekt Red'), (3, 'FromSoftware'), (4, 'Ubisoft'),
(5, 'Nintendo'), (6, 'Rockstar Games'), (7, 'Insomniac Games'), (8, 'Square Enix'),
(9, 'Bethesda'), (10, 'Valve');

INSERT INTO publisher (publisher_id, publisher_name, date_established) VALUES
(1, 'Sony Interactive Entertainment', '1993-11-16'), (2, 'Bandai Namco', '1955-06-01'),
(3, 'Nintendo Co., Ltd.', '1889-09-23'), (4, 'Ubisoft Entertainment', '1986-03-28'),
(5, 'Bethesda Softworks', '1986-06-28'), (6, 'Square Enix Holdings', '2003-04-01'),
(7, 'Take-Two Interactive', '1993-09-30'), (8, 'Microsoft Studios', '2002-03-01'),
(9, 'Electronic Arts', '1982-05-28'), (10, 'Valve Corporation', '1996-08-24');

INSERT INTO franchise (franchise_id, franchise_name, establish_date, latest_release) VALUES
(1, 'The Legend of Zelda', '1986-02-21', 'Tears of the Kingdom'), (2, 'Grand Theft Auto', '1997-10-21', 'GTA V'),
(3, 'Call of Duty', '2003-10-29', 'Modern Warfare III'), (4, 'Elder Scrolls', '1994-03-25', 'Skyrim'),
(5, 'Final Fantasy', '1987-12-18', 'Final Fantasy XVI'), (6, 'Dark Souls', '2011-09-22', 'Elden Ring'),
(7, 'Super Mario', '1985-09-13', 'Super Mario Odyssey'), (8, 'Half-Life', '1998-11-19', 'Half-Life Alyx');

INSERT INTO platform (platform_id, platform_name, game_release_date) VALUES
(1, 'PlayStation 5', NULL), (2, 'Xbox Series X', NULL), (3, 'Nintendo Switch', NULL),
(4, 'PC', NULL), (5, 'Steam Deck', NULL), (6, 'PlayStation 4', NULL),
(7, 'Xbox One', NULL), (8, 'Mobile', NULL);

INSERT INTO games (game_id, game_name, game_description, multiplayer, price, age_rating, created_date, genre_id, developer_id, franchise_id, publisher_id)
VALUES
(1, 'The Last of Us Part II', 'A gripping narrative-driven action game.', FALSE, 59.99, 'Mature', '2020-06-19', 1, 1, NULL, 1),
(2, 'Cyberpunk 2077', 'Open-world RPG set in a futuristic city.', TRUE, 49.99, 'Mature', '2020-12-10', 3, 2, NULL, 2),
(3, 'Elden Ring', 'Fantasy open world RPG by FromSoftware.', TRUE, 69.99, 'Mature', '2022-02-25', 3, 3, 6, 2),
(4, 'Assassin''s Creed Valhalla', 'Viking-era adventure and exploration.', TRUE, 59.99, 'Mature', '2020-11-10', 2, 4, NULL, 4),
(5, 'Super Mario Odyssey', 'Mario explores worlds to rescue Princess Peach.', FALSE, 49.99, 'Everyone', '2017-10-27', 2, 5, 7, 3);

INSERT INTO user_reviews (user_reviews_id, user_id, game_id, rating, review_comment, review_date)
VALUES
(1, 1, 3, 5, 'Elden Ring is breathtaking and brutally challenging. The world feels alive.', '2023-08-01'), 
(2, 1, 2, 4, 'Cyberpunk has improved dramatically since launch.', '2024-02-20'), 
(3, 2, 1, 5, 'The Last of Us II is emotional and powerful. Stunning storytelling.', '2022-08-20'), 
(4, 3, 3, 5, 'Elden Ring is a masterpiece in design.', '2023-10-15'), 
(5, 4, 5, 4, 'Super Mario Odyssey is joyful, polished, and nostalgic.', '2023-06-20');

INSERT INTO awards (award_id, award_name, date_awarded, awarded_by, game_id) VALUES
(1, 'Game of the Year', '2020-12-15', 'Game Awards', 1),   
(2, 'Best Narrative', '2020-12-15', 'Game Awards', 1),
(3, 'Best Art Direction', '2020-12-15', 'Game Awards', 2), 
(4, 'RPG of the Year', '2022-03-20', 'IGN Awards', 3),     
(5, 'Best Open World', '2011-12-10', 'Game Critics Awards', 4);

INSERT INTO user_following (user_id1, user_id2) VALUES
(1, 2), (1, 3), (2, 1), (3, 1), (3, 4), (4, 2);

INSERT INTO user_games (user_games_id, user_id, game_id, following_date)
VALUES
(1, 1, 3, '2023-07-12'), (2, 1, 2, '2024-01-03'), (3, 2, 1, '2022-06-10'), 
(4, 3, 3, '2023-04-02'), (5, 4, 5, '2023-05-15');

INSERT INTO game_platform (game_id, platform_id) VALUES
(1, 1), (1, 4), (2, 4), (3, 1), (3, 2), (3, 4), (4, 1), (4, 2), (5, 3);

INSERT INTO game_genre (game_id, genre_id) VALUES
(1, 1), (2, 3), (3, 3), (4, 2), (5, 2);
"""

# --- 2. Export Individual Normalized Tables ---
def create_and_export_normalized():
    """Initializes DuckDB and exports individual normalized tables as Parquet files."""
    
    # Connect to DuckDB
    con = duckdb.connect(database=':memory:', read_only=False)
    
    print("Executing schema creation and data insertion...")
    try:
        # Run the setup SQL
        con.sql(SQL_SETUP)
        print("SQL execution complete.")
        
        # Create directory for parquet files
        os.makedirs('normalized_tables', exist_ok=True)
        
        # Export each normalized table as separate Parquet files
        tables = [
            'users', 'genre', 'publisher', 'developer', 'franchise', 'platform',
            'games', 'user_reviews', 'awards', 'user_following', 'user_games',
            'game_platform', 'game_genre'
        ]
        
        for table in tables:
            filename = f'normalized_tables/{table}.parquet'
            if os.path.exists(filename):
                os.remove(filename)
            con.sql(f"COPY {table} TO '{filename}' (FORMAT PARQUET);")
            print(f"✅ Exported {table}.parquet")
        
        print(f"\n🎉 SUCCESS: All normalized tables exported to 'normalized_tables/' directory!")
        
        # Show table relationships
        print("\n📊 Database Schema Overview:")
        print("users ↔ user_reviews ↔ games ↔ developer/publisher")
        print("games ↔ game_platform ↔ platform")
        print("games ↔ game_genre ↔ genre")
        print("users ↔ user_following ↔ users (social network)")
        
    except Exception as e:
        print(f"\n❌ ERROR: {e}")
        
    finally:
        con.close()

if __name__ == "__main__":
    create_and_export_normalized()
