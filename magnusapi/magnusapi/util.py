import functools
import logging

from flask import request


def log(func):
    @functools.wraps(func)
    def newFunc(*args, **kwargs):
        logging.info(f"{request.url}: {request.remote_addr}")
        return func(*args, **kwargs)

    return newFunc
