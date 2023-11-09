from fastapi import FastAPI, status, HTTPException, Depends
from typing import Annotated
from pydantic import BaseModel
import models
from database import engine, SessionLocal
from sqlalchemy.orm import Session
from sqlalchemy import Select


app = FastAPI()
models.Base.metadata.create_all(bind= engine)


class Sign_in(BaseModel):
    username: str
    password: str

class Sign_up(BaseModel):
    username: str
    email : str
    password: str

class Order(BaseModel):
    order_id : int
    item_id : int
    user_name : str
    quantity : int

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close

db_dependency = Annotated[Session, Depends(get_db)]

@app.post('/users/sign-up/{credentials}', status_code= status.HTTP_201_CREATED)
async def create_user(user: Sign_up, db: db_dependency):
    db_user = models.User(**user.dict())
    db.add(db_user)
    db.commit()
    return {'Success': 'User Succesfully Registered'}
    
@app.put('/users/sign-in/{creds}', status_code= status.HTTP_200_OK)
async def sign_into_account(credentials: Sign_in, db: db_dependency):
    user = db.query(models.User).filter(models.User.username == credentials.username).first()
    if user is None:
        raise HTTPException(status_code= 404, detail= 'User Not Found')
    else:
        if user.password == credentials.password:
            return user
        else:
            raise HTTPException(status_code= 401, detail= 'Password is incorrect')

@app.post('/users/order/{order_details}', status_code= status.HTTP_201_CREATED)
async def make_order(details: Order, db: db_dependency):
    itemName = db.query(models.menu.item_name).filter(models.menu.item_ID == details.item_id).first()
    db_order = models.Orders(**details.dict())
    db.add(db_order)
    db.commit()
    
    return {'Order Confirmed': f'{itemName[0]}'}

    