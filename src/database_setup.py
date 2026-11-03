from sqlalchemy import text

from database import engine

with open("sql/schema.sql", "r") as file:
    schema_sql = file.read()

with engine.begin() as connection:

    for statement in schema_sql.split(";"):

        statement = statement.strip()

        if statement:
            connection.execute(text(statement))

print("Database schema deployed successfully.")