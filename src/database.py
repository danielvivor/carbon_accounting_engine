# =========================================================
# Database Configuration
#
# Centralised PostgreSQL connection management.
#
# This module loads database credentials from the
# .env file and exposes a reusable SQLAlchemy engine
# that can be imported throughout the application.
#
# Used by:
# - database_setup.py
# - seed_master_data.py
# - process_activities.py
# - reporting.py
# =========================================================

import os

from dotenv import load_dotenv
from sqlalchemy import create_engine

# Load environment variables from .env
load_dotenv()

# Database connection settings
DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")
DB_HOST = os.getenv("DB_HOST")
DB_PORT = os.getenv("DB_PORT")
DB_NAME = os.getenv("DB_NAME")

# Create reusable SQLAlchemy engine
engine = create_engine(
    f"postgresql+psycopg://"
    f"{DB_USER}:{DB_PASSWORD}@"
    f"{DB_HOST}:{DB_PORT}/"
    f"{DB_NAME}"
)