from flask import Blueprint
from logging import getLogger

from magnusapi.version import __version__

bp = Blueprint("health", __name__, url_prefix="/health")

logger = getLogger(__name__)


@bp.route("")
def index():
    return {"status": "ok", "version": __version__}
