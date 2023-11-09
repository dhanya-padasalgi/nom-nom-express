from sqlalchemy import Column, Integer, String, Float, ForeignKey
from database import Base

class User(Base):
    __tablename__ = 'users'

    id = Column(Integer, primary_key=True, index=True)
    username = Column(String(50), unique=True)

class Post(Base):
    __tablename__ = 'posts'

    id = Column(Integer, primary_key=True, index=True)
    title = Column(String(50))
    content = Column(String(100))
    user_id = Column(Integer)

from pydantic import BaseModel
from typing import List

class Restaurant(BaseModel):
    name: str

class MenuItem(BaseModel):
    name: str
    price: float
    restaurant_id: int

class Order(BaseModel):
    user_id: int
    menu_item_id: int
    quantity: int
