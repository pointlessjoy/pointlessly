from datetime import datetime
from pathlib import Path

from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, Field
from sqlalchemy import create_engine, Integer, String, DateTime, func
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column, sessionmaker

BASE_DIR = Path(__file__).resolve().parent
DB_PATH = BASE_DIR / "muyonghan_gippeum.db"
engine = create_engine(f"sqlite:///{DB_PATH}", connect_args={"check_same_thread": False})
SessionLocal = sessionmaker(bind=engine)


class Base(DeclarativeBase):
    pass


class JoyPost(Base):
    __tablename__ = "joy_posts"

    id: Mapped[int] = mapped_column(Integer, primary_key=True, index=True)
    text: Mapped[str] = mapped_column(String(80), nullable=False)
    likes: Mapped[int] = mapped_column(Integer, default=0, nullable=False)
    created_at: Mapped[datetime] = mapped_column(DateTime, server_default=func.now())


Base.metadata.create_all(bind=engine)


class PostCreate(BaseModel):
    text: str = Field(min_length=1, max_length=80)


class PostOut(BaseModel):
    id: int
    text: str
    likes: int
    created_at: datetime


app = FastAPI(title="무용한기쁨 API", version="0.1.0")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get("/api/health")
def health():
    return {"status": "ok"}


@app.get("/api/posts", response_model=list[PostOut])
def list_posts():
    with SessionLocal() as db:
        posts = db.query(JoyPost).order_by(JoyPost.id.desc()).limit(200).all()
        return posts


@app.post("/api/posts", response_model=PostOut)
def create_post(payload: PostCreate):
    text = payload.text.strip()
    if not text:
        raise HTTPException(status_code=400, detail="빈 문장은 등록할 수 없어요.")

    with SessionLocal() as db:
        post = JoyPost(text=text)
        db.add(post)
        db.commit()
        db.refresh(post)
        return post


@app.post("/api/posts/{post_id}/like", response_model=PostOut)
def like_post(post_id: int):
    with SessionLocal() as db:
        post = db.query(JoyPost).filter(JoyPost.id == post_id).first()
        if not post:
            raise HTTPException(status_code=404, detail="게시글을 찾을 수 없어요.")
        post.likes += 1
        db.commit()
        db.refresh(post)
        return post


if __name__ == "__main__":
    import uvicorn

    uvicorn.run("main:app", host="127.0.0.1", port=8791, reload=True)
