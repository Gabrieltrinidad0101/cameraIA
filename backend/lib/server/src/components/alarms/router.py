from flask import Blueprint,request,Response
from flask_expects_json import expects_json
from .utils.add_new_alarm_scheme_json import alarm_schema_json
alarm = Blueprint("alarm",__name__,url_prefix='/alarm')


@alarm.route("/add",methods=["POST"])
@expects_json(alarm_schema_json)
def add_new_alarm():
    try:
        values = request.get_json()
        print(values)
        return "ok"
    except:
        return Response("Internal server error try again later",status=500)