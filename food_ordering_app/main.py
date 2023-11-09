from fastapi import FastAPI, HTTPException, Depends, status
from pydantic import BaseModel
from typing import Annotated
import models
from database import SessionLocal, engine
from sqlalchemy.orm import Session
import smtplib

app = FastAPI()
models.Base.metadata.create_all(bind=engine)

class Post(BaseModel):
    title: str
    content: str
    user_id: int

class UserBase(BaseModel):
    username: str

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

db_dependency = Annotated[Session, Depends(get_db)]

# Create an in-memory database for demonstration purposes.
# In a production application, you would use a real database.
menu_items_db = {}
orders_db = {}
users_db = {}

class MenuItem(BaseModel):
    name: str
    price: float

class CartItem(BaseModel):
    item_id: int
    quantity: int

class Order(BaseModel):
    user_id: int
    cart: list[CartItem]

# Function for sending email notifications
def send_notification(order_id, order_details):
    # Replace these with your email server and credentials
    smtp_server = "smtp.example.com"
    smtp_port = 587
    sender_email = "your_email@example.com"
    sender_password = "your_password"

    recipient_email = "restaurant_owner@example.com"

    subject = f"New Food Order - Order ID: {order_id}"
    message = f"New food order with the following details:\n\n{order_details}"

    with smtplib.SMTP(smtp_server, smtp_port) as server:
        server.starttls()
        server.login(sender_email, sender_password)
        server.sendmail(sender_email, recipient_email, f"Subject: {subject}\n\n{message}")

@app.post("/menu/")
async def create_menu_item(item: MenuItem):
    item_id = len(menu_items_db) + 1
    menu_items_db[item_id] = item
    return {"item_id": item_id, "item": item}

@app.post("/add-to-cart/")
async def add_to_cart(item: CartItem):
    item_id = item.item_id
    quantity = item.quantity

    if item_id not in menu_items_db:
        raise HTTPException(status_code=400, detail="Item not found")

    if "cart" not in users_db:
        users_db["cart"] = []

    cart = users_db["cart"]
    cart.append({"item_id": item_id, "quantity": quantity})

    return {"message": "Item added to the cart", "cart": cart}

@app.post("/place-order/")
async def place_order(order: Order):
    user_id = order.user_id
    cart_content = order.cart

    if "cart" not in users_db:
        raise HTTPException(status_code=400, detail="Cart is empty")

    cart = users_db["cart"]

    if cart != cart_content:
        raise HTTPException(status_code=400, detail="Cart content mismatch")

    total price = sum(menu_items_db[item["item_id"]].price * item["quantity"] for item in cart)

    # Save the order to the database
    order_id = len(orders_db) + 1
    orders_db[order_id] = {"user_id": user_id, "cart": cart, "total_price": total_price}
    
    # Send a notification to the restaurant owner
    send_notification(order_id, f"User ID: {user_id}, Cart: {cart}, Total Price: ${total_price}")

    # Clear the user's cart
    users_db["cart"] = []

    return {"message": "Order placed successfully", "order_id": order_id}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
