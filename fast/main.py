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

class UserBase(BaseModel):
    username: str

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close

db_dependency = Annotated[Session, Depends(get_db)]

@app.post('/users/', status_code= status.HTTP_201_CREATED)
async def create_user(user: UserBase, db: db_dependency):
    db_user = models.User(**user.dict())
    db.add(db_user)
    db.commit()
    