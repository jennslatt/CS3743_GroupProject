import streamlit as st
import duckdb
import pandas as pd
import os

# --- Configuration ---
TABLES_DIR = "normalized_tables"

# --- 1. DuckDB Connection with Normalized Tables ---
con = None
if os.path.exists(TABLES_DIR):
    try:
        con = duckdb.connect(database=':memory:', read_only=False)
        
        # Register each normalized table from parquet files
        tables = ['users', 'games', 'user_reviews', 'developer', 'publisher', 
                 'genre', 'platform', 'franchise', 'awards', 'user_following',
                 'user_games', 'game_platform', 'game_genre']
        
        for table in tables:
            parquet_file = f"{TABLES_DIR}/{table}.parquet"
            if os.path.exists(parquet_file):
                con.sql(f"CREATE OR REPLACE VIEW {table} AS SELECT * FROM read_parquet('{parquet_file}');")
        
        #st.success("✅ Normalized database loaded successfully!")
        
    except Exception as e:
        st.error(f"Error loading database: {e}")
        con = None
else:
    st.warning(f"Directory '{TABLES_DIR}' not found. Please run 'create_parquet_data.py' first.")

# --- 2. Mixed Queries - Showing Normalized Schema + Useful Analytics ---
NORMALIZED_QUERIES = {
    # --- Schema Demonstration Queries ---
    "Many-to-Many: Games & Platforms": """
        SELECT 
            g.game_name,
            GROUP_CONCAT(p.platform_name) as available_platforms,
            COUNT(gp.platform_id) as platform_count
        FROM games g
        JOIN game_platform gp ON g.game_id = gp.game_id
        JOIN platform p ON gp.platform_id = p.platform_id
        GROUP BY g.game_name
        ORDER BY platform_count DESC;
    """,
    "Complex Join: Games with Reviews & Developers": """
        SELECT 
            g.game_name,
            d.developer_name,
            p.publisher_name,
            COUNT(ur.user_reviews_id) as review_count,
            ROUND(AVG(ur.rating), 2) as avg_rating
        FROM games g
        JOIN developer d ON g.developer_id = d.developer_id
        JOIN publisher p ON g.publisher_id = p.publisher_id
        LEFT JOIN user_reviews ur ON g.game_id = ur.game_id
        GROUP BY g.game_name, d.developer_name, p.publisher_name
        ORDER BY avg_rating DESC NULLS LAST;
    """,
    "User Social Network Analysis": """
        SELECT 
            u1.user_name as follower,
            u2.user_name as following,
            COUNT(DISTINCT ug1.game_id) as games_owned
        FROM user_following uf
        JOIN users u1 ON uf.user_id1 = u1.user_id
        JOIN users u2 ON uf.user_id2 = u2.user_id
        LEFT JOIN user_games ug1 ON u1.user_id = ug1.user_id
        GROUP BY u1.user_name, u2.user_name
        ORDER BY games_owned DESC;
    """,
    
    # --- Useful Analytics Queries (from previous version) ---
    "Most Active Reviewers": """
        SELECT
            u.user_name as reviewer_username,
            COUNT(ur.user_reviews_id) AS reviews_written,
            ROUND(AVG(ur.rating), 2) AS average_rating,
            MIN(ur.review_date) as first_review,
            MAX(ur.review_date) as latest_review
        FROM users u
        JOIN user_reviews ur ON u.user_id = ur.user_id
        GROUP BY u.user_name
        ORDER BY reviews_written DESC
        LIMIT 10;
    """,
    "Top Rated Games": """
        SELECT 
            g.game_name, 
            ROUND(AVG(ur.rating), 2) AS average_score,
            COUNT(ur.user_reviews_id) as review_count
        FROM games g
        JOIN user_reviews ur ON g.game_id = ur.game_id
        GROUP BY g.game_name
        HAVING COUNT(ur.user_reviews_id) >= 1
        ORDER BY average_score DESC
        LIMIT 10;
    """,
    "Developer Performance by Average Rating": """
        SELECT 
            d.developer_name, 
            COUNT(DISTINCT g.game_id) AS total_games,
            ROUND(AVG(ur.rating), 2) AS average_developer_rating,
            COUNT(ur.user_reviews_id) as total_reviews
        FROM developer d
        JOIN games g ON d.developer_id = g.developer_id
        LEFT JOIN user_reviews ur ON g.game_id = ur.game_id
        GROUP BY d.developer_name
        HAVING COUNT(ur.user_reviews_id) > 0
        ORDER BY average_developer_rating DESC;
    """,
    "Recent Reviews with User Details": """
        SELECT
            u.user_name as reviewer,
            g.game_name,
            ur.rating,
            ur.review_comment,
            ur.review_date,
            d.developer_name
        FROM user_reviews ur
        JOIN users u ON ur.user_id = u.user_id
        JOIN games g ON ur.game_id = g.game_id
        JOIN developer d ON g.developer_id = d.developer_id
        ORDER BY ur.review_date DESC
        LIMIT 10;
    """,
    "Franchise Popularity Analysis": """
        SELECT 
            f.franchise_name,
            COUNT(DISTINCT g.game_id) as games_in_franchise,
            COUNT(ur.user_reviews_id) as total_reviews,
            ROUND(AVG(ur.rating), 2) AS avg_rating
        FROM franchise f
        LEFT JOIN games g ON f.franchise_id = g.franchise_id
        LEFT JOIN user_reviews ur ON g.game_id = ur.game_id
        WHERE f.franchise_name IS NOT NULL
        GROUP BY f.franchise_name
        HAVING COUNT(ur.user_reviews_id) > 0
        ORDER BY total_reviews DESC;
    """,
    "Genre Analysis": """
        SELECT 
            gen.genre_name,
            COUNT(DISTINCT g.game_id) as game_count,
            ROUND(AVG(ur.rating), 2) as avg_rating,
            COUNT(ur.user_reviews_id) as total_reviews
        FROM genre gen
        JOIN game_genre gg ON gen.genre_id = gg.genre_id
        JOIN games g ON gg.game_id = g.game_id
        LEFT JOIN user_reviews ur ON g.game_id = ur.game_id
        GROUP BY gen.genre_name
        HAVING COUNT(ur.user_reviews_id) > 0
        ORDER BY game_count DESC;
    """
}

# --- 3. Streamlit UI ---
st.set_page_config(layout="wide", page_title="🎮 Game Review DB")

st.title("🎮 Game Review Database")
st.subheader("Database Systems Project - Fantastic Four")

if con:
    # --- Schema Overview ---
    st.markdown("---")
    st.header("📊 Database Schema Overview")
    
    col1, col2, col3 = st.columns(3)
    
    with col1:
        st.markdown("**Core Entities:**")
        st.write("• users")
        st.write("• games") 
        st.write("• developer")
        st.write("• publisher")
    
    with col2:
        st.markdown("**Relationship Tables:**")
        st.write("• user_reviews")
        st.write("• user_following")
        st.write("• game_platform")
        st.write("• game_genre")
    
    with col3:
        st.markdown("**Lookup Tables:**")
        st.write("• genre")
        st.write("• platform")
        st.write("• franchise")
        st.write("• awards")
    
    # --- Query Demonstrations ---
    st.markdown("---")
    st.header("🔗 Query Demonstrations")
    st.markdown("These queries show both **schema relationships** and **useful analytics** using normalized tables:")
    
    selected_query = st.selectbox(
        "Choose a query to run:",
        list(NORMALIZED_QUERIES.keys())
    )
    
    query_sql = NORMALIZED_QUERIES[selected_query]
    
    # Show the SQL
    st.subheader("SQL Query")
    st.code(query_sql, language='sql')
    
    # Show query type
    schema_queries = ["Many-to-Many: Games & Platforms", "Complex Join: Games with Reviews & Developers", "User Social Network Analysis"]
    if selected_query in schema_queries:
        st.info("🔗 **Schema Demonstration Query** - Shows complex relationships between normalized tables")
    else:
        st.info("📈 **Analytics Query** - Useful business intelligence using normalized data")
    
    # Execute and show results
    if st.button("Execute Query"):
        try:
            df_result = con.execute(query_sql).fetchdf()
            
            st.subheader("Query Results")
            st.dataframe(df_result, use_container_width=True)
            
            st.success(f"✅ Query returned **{len(df_result)}** records")
            
            # Show which tables were involved
            involved_tables = set()
            for table in ['users', 'games', 'user_reviews', 'developer', 'publisher', 
                         'genre', 'platform', 'user_following', 'user_games', 
                         'game_platform', 'game_genre', 'awards', 'franchise']:
                if table in query_sql.lower():
                    involved_tables.add(table)
            
            st.caption(f"**Tables involved:** {', '.join(sorted(involved_tables))}")
            
        except Exception as e:
            st.error(f"❌ Query execution failed: {e}")

else:
    st.error("❌ Database not loaded. Please run 'create_parquet_data.py' first.")

# --- Footer ---
st.markdown("---")
st.markdown("**Database Systems Class Project** - Demonstrating normalized schema design with proper relationships and foreign keys.")
