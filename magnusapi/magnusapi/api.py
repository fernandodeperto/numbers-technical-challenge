import logging
import os

from flask import Flask, request

from magnusapi import db

from magnusapi.view import health
from magnusapi.view import item


def create_app(config=None):
    app = Flask(__name__, instance_relative_config=True)

    app.config.from_mapping(
        SECRET_KEY="dev",
        SQLALCHEMY_DATABASE_URI="postgresql://postgres:postgres@localhost/postgres",
        SQLALCHEMY_TRACK_MODIFICATIONS=False,
        SQLALCHEMY_ECHO=False,
    )

    secret_key = os.environ.get("SECRET_KEY")
    if secret_key:
        app.config["SECRET_KEY"] = secret_key

    database_uri = os.environ.get("SQLALCHEMY_DATABASE_URI")
    if database_uri:
        app.config["SQLALCHEMY_DATABASE_URI"] = database_uri

    if config:
        app.config.from_mapping(config)

    db.init_app(app)

    app.register_blueprint(health.bp)
    app.register_blueprint(item.bp)

    @app.after_request
    def after(response):
        logging.info(
            f"{request.remote_addr} {request.method} {request.path} {response.status}"
        )
        return response

    return app


app = create_app()
