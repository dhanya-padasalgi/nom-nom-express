from sqlalchemy import Boolean, Integer, String, Column, Float, ForeignKey
from database import Base

class User(Base):
    __tablename__ = 'users'

    username = Column(String(50), primary_key= True, index= True)
    email = Column(String(50), unique= True)
    password = Column(String(50))

class menu(Base):
    __tablename__ = 'menu'
    item_ID = Column(Integer, primary_key= True, index= True)
    item_name = Column(String(50), unique= True)
    item_price = Column(Float)

class Orders(Base):
    __tablename__ = 'orders'
    order_id = Column(Integer, primary_key= True, index= True)
    item_id = Column(Integer, ForeignKey(menu.item_ID, ondelete= 'CASCADE'), nullable= False)
    user_name = Column(String(50), ForeignKey(User.username, ondelete= 'CASCADE'), nullable= False)
    quantity = Column(Integer)

