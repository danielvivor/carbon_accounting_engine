import os

from dotenv import load_dotenv
from sqlalchemy import create_engine, text

load_dotenv()

DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")
DB_HOST = os.getenv("DB_HOST")
DB_PORT = os.getenv("DB_PORT")
DB_NAME = os.getenv("DB_NAME")

engine = create_engine(
    f"postgresql+psycopg://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
)

with open("sql/schema.sql", "r") as file:
    schema_sql = file.read()

with engine.begin() as connection:

    for statement in schema_sql.split(";"):

        statement = statement.strip()

        if statement:

            connection.execute(text(statement))

print("Database schema deployed successfully.")