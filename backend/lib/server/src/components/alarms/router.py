from flask import Blueprint,request,Response,jsonify
from flask_expects_json import expects_json
from .utils.add_new_alarm_scheme_json import alarm_schema_json
from server.src.services.database.alarms import DatabaseAlarm
from server.src.middlewares.auth import token_requires
from .dto import dto_alarm
alarm = Blueprint("alarm",__name__,url_prefix='/alarm')
database_alarm = DatabaseAlarm()

@alarm.route("/add",methods=["POST"])
@token_requires
@expects_json(alarm_schema_json)
def add_new_alarm():
    try:
        alarm_data = request.get_json()
        objects = alarm_data.get("objects")
        for object_name in objects:
            if type(object_name) != str: return jsonify({"error": "Error type in objects"}),500
        alarm_data_filter = dto_alarm(alarm_data)
        database_alarm.save(alarm_data_filter)
        return jsonify({"message": "Alarm add succcessful"}), 200
    except:
        return jsonify({"error": "Internal server error try again later"}), 500

@alarm.route("/get",methods=["GET"])
@token_requires
def get_all_alarms():
    try:
        alarms = database_alarm.get_all()
        return jsonify(alarms),200
    except Exception as e:
        print(e)
        return jsonify({"error": "Internal server error try again later"}), 500

@alarm.route("/update/<id>",methods=["PUT"])
@token_requires
@expects_json(alarm_schema_json)
def update_alarm(id):
    try:
        data = request.get_json()
        database_alarm.edit(id,data)
        return jsonify({"message": "Alarm is update successful"}), 200
    except Exception as e:
        print(e)
        return jsonify({"error": "Internal server error try again later"}), 500


@alarm.route("/delete/<id>",methods=["DELETE"])
@token_requires
def delete_alarm(id):
    try:
        database_alarm.delete(id)
        return jsonify({"message": "Alarm is delete successful"}), 200
    except Exception as e:
        print(e)
        return jsonify({"error": "Internal server error try again later"}), 500