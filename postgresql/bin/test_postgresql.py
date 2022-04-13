# References:
# https://www.compose.com/articles/using-postgresql-through-sqlalchemy/
# https://auth0.com/blog/sqlalchemy-orm-tutorial-for-python-developers/
# https://docs.sqlalchemy.org/en/13/core/tutorial.html
# https://stackoverflow.com/questions/35918605/how-to-delete-a-table-in-sqlalchemy
# https://docs.postgresql.tw/reference/sql-commands/drop-table


from sqlalchemy import create_engine
from sqlalchemy import Table, Column, String, MetaData
from sqlalchemy.engine.url import URL
from sqlalchemy.ext.declarative import declarative_base  
from sqlalchemy.orm import sessionmaker


## setting
#dialect = 'postgresql'
#driver = 'psycopg2'
#username = 'user1'
#password = 'user1Pass'
#host = 'kai-postgresql'
#port = 5432
#database = 'mydb'
#DATABASE_URL = f'{dialect}+{driver}://{username}:{password}@{host}:{port}/{database}'

DATABASE_INFO = {
    'drivername': 'postgresql+psycopg2',
    'username': 'user1',
    'password': 'user1Pass',
    'host': 'kai-postgresql',
    'port': '5432',
    'database': 'mydb',
    'query': None,
}
DATABASE_URL = URL(**DATABASE_INFO)


## Create, Read, Update, and Delete using Raw SQL
engine = create_engine(DATABASE_URL)  # Connecting

# Create 
engine.execute("CREATE TABLE IF NOT EXISTS films (title text, director text, year text)")  
engine.execute("INSERT INTO films (title, director, year) VALUES ('Doctor Strange', 'Scott Derrickson', '2016')")

# Read
result_set = engine.execute("SELECT * FROM films")  
for r in result_set:  
    print(r)

# Update
engine.execute("UPDATE films SET title='Some2016Film' WHERE year='2016'")
result_set = engine.execute("SELECT * FROM films")  
for r in result_set:  
    print(r)

# Delete
engine.execute("DELETE FROM films WHERE year='2016'")


## DROP TABLE
engine.execute("DROP TABLE films;")


## Create, Read, Update, and Delete using the SQL Expression Language
engine = create_engine(DATABASE_URL)  # Connecting

meta = MetaData(engine)
film_table = Table('films', meta,  
                   Column('title', String),
                   Column('director', String),
                   Column('year', String))


with engine.connect() as conn:

    # Create
    film_table.create()
    insert_statement = film_table.insert().values(title="Doctor Strange", director="Scott Derrickson", year="2016")
    conn.execute(insert_statement)

    # Read
    select_statement = film_table.select()
    result_set = conn.execute(select_statement)
    for r in result_set:
        print(r)

    # Update
    update_statement = film_table.update().where(film_table.c.year=="2016").values(title = "Some2016Film")
    conn.execute(update_statement)
    select_statement = film_table.select()
    result_set = conn.execute(select_statement)
    for r in result_set:
        print(r)

    # Delete
    delete_statement = film_table.delete().where(film_table.c.year == "2016")
    conn.execute(delete_statement)


## DROP TABLE
# engine.execute("DROP TABLE films;")
film_table.drop(engine) # drops the films table


## Create, Read, Update, and Delete using the SQL ORM
engine = create_engine(DATABASE_URL)  # Connecting
base = declarative_base()


class Film(base):  
    __tablename__ = 'films'

    title = Column(String, primary_key=True)
    director = Column(String)
    year = Column(String)


Session = sessionmaker(engine)  
session = Session()

base.metadata.create_all(engine)

# Create 
doctor_strange = Film(title="Doctor Strange", director="Scott Derrickson", year="2016")  
session.add(doctor_strange)  
session.commit()

# Read
films = session.query(Film)  
for film in films:  
    print(film.title)

# Update
doctor_strange.title = "Some2016Film"  
session.commit()
films = session.query(Film)  
for film in films:  
    print(film.title)

# Delete
session.delete(doctor_strange)  
session.commit()















