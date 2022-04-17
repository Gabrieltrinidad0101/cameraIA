from flask import Blueprint
from server.src.components.alarms.router import alarm
router = Blueprint("api",__name__,url_prefix='/api')

router.register_blueprint(alarm)
