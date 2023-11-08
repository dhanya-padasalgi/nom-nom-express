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
