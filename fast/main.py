from fastapi import FastAPI, status, HTTPException, Depends
from typing import Annotated
from pydantic import BaseModel
import models
from database import engine, SessionLocal
from sqlalchemy.orm import Session


app = FastAPI()
models.Base.metadata.create_all(bind= engine)

class PostBase(BaseModel):
    title : str
    content : str
    user_id : int

class Sign_in(BaseModel):
    username: str
    password: str

class UserBase(BaseModel):
    username: str
    email : str
    password: str

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close

db_dependency = Annotated[Session, Depends(get_db)]

@app.post('/users/sign-up/{credentials}', status_code= status.HTTP_201_CREATED)
async def create_user(user: UserBase, db: db_dependency):
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


    