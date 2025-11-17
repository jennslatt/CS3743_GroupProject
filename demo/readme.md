# Game Review Database Project

A database systems class project demonstrating normalized schema design with a Streamlit UI for visualization.

## Quick Start

### 1. Setup Environment

```bash
# Install required packages
pip install streamlit duckdb pandas
```

### 2. Create the Database

```bash
# Run this first to generate the normalized parquet files
python create_parquet_data.py
```

### 3. Launch the Web Interface

```bash
# Run this to start the Streamlit app
streamlit run app.py
```

## Files Overview

* **`create_parquet_data.py`** - Creates normalized database schema and exports to parquet files

* **`app.py`** - Streamlit web interface to query and visualize the database

* **`normalized_tables/`** - Directory containing individual table files (auto-generated)

## Database Schema

**Core Tables:**

* `users` - User profiles and information

* `games` - Game details and metadata  

* `user_reviews` - Review relationships between users and games

* `developer` / `publisher` - Game company information

**Relationship Tables:**

* `user_following` - Social connections between users

* `game_platform` - Many-to-many games to platforms

* `game_genre` - Many-to-many games to genres

**Lookup Tables:**

* `genre`, `platform`, `franchise`, `awards`

## Features in the UI

* **Schema Demonstration Queries** - Show complex joins and relationships

* **Analytics Queries** - Useful business intelligence queries

* **Normalized Design** - Demonstrates 3rd normal form principles

* **Interactive Results** - View query results in real-time

## For Team Members

### If You Need to Modify Data:

Edit `create_parquet_data.py` and re-run it to regenerate the parquet files.

### If You Want to Add New Queries:

Add them to the `NORMALIZED_QUERIES` dictionary in `app.py`.

### Accessing the App:

After running `streamlit run app.py`, open your browser to the URL shown in terminal (usually `http://localhost:8501`)

## Requirements

* Python 3.7+

* Streamlit, DuckDB, Pandas

This project demonstrates proper database normalization while providing an interactive way to explore the schema and data relationships.
