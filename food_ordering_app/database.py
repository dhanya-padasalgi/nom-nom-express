from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

URL_DATABASE = 'mysql+pymysql://dan:Dhanya2305@localHost:3306/nomnomexpress'

engine = create_engine(URL_DATABASE)

SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

Base = declarative_base()

# restaurants_db = {}
# menu_items_db = {}
# orders_db = {}
# users_db = {}
