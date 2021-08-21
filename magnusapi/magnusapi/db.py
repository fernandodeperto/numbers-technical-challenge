from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate

db = SQLAlchemy()


class Item(db.Model):  # type: ignore
    id_ = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.Text, unique=True, nullable=False)


def init_app(app):
    db.init_app(app)
    Migrate(app, db)


def get_dict(obj):
    return {column.name: getattr(obj, column.name) for column in obj.__table__.columns}
