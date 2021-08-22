from flask import Blueprint, request
from sqlalchemy.exc import DatabaseError

from magnusapi.db import db, get_dict, Item


bp = Blueprint("item", __name__, url_prefix="/item")


@bp.route("", methods=["GET", "POST"])
def index():
    if request.method == "GET":
        return {"data": [get_dict(item) for item in Item.query.all()]}
    else:
        try:
            db.session.add(Item(**request.json))
            db.session.commit()
        except (DatabaseError, TypeError) as e:
            db.session.rollback()
            return {"status": type(e).__name__}

        item = Item.query.filter_by(**request.json).first()
        return {"data": [get_dict(item)]}


@bp.route("<int:id_>", methods=["GET", "PATCH", "DELETE"])
def item(id_):
    item = Item.query.filter_by(id_=id_).first()

    if request.method == "GET":
        if item:
            return {"data": [get_dict(item)]}

        return {"data": []}

    elif request.method == "PATCH":
        if item:
            for key, value in request.json.items():
                setattr(item, key, value)

            db.session.commit()
            return {"data": [get_dict(item)]}

        return {"status:": "object not found"}

    else:
        if item:
            db.session.delete(item)
            db.session.commit()
            return {"data": []}

        return {"status": "object not found"}
