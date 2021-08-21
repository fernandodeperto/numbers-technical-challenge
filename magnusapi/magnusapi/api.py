from fastapi import FastAPI

from magnusapi.version import __version__

app = FastAPI()


@app.get("/")
def root():
    return {
        "message": "Hello World",
        "version": __version__,
    }
