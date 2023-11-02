from sqlalchemy import Boolean, Integer, String, Column
from database import Base

class User(Base):
    __tablename__ = 'users'

    username = Column(String(50), primary_key= True, index= True)
    email = Column(String(50), unique= True)
    password = Column(String(50))



