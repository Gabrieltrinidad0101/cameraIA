from flask_socketio import Namespace,emit
from flask import request,current_app,copy_current_request_context
import server.src.services.db as db
from .utils.process_time import ProcessTime
from threading import Thread

class AlarmSocket(Namespace):
    def __init__(self, namespace=None):
        super().__init__(namespace)
        self.alarms = {}
        self.processTime = ProcessTime()
        
    def on_connect(self):
        token = request.args["token"]
        user_id = request.sid
        token_is_not_correct = db.verify_token(token)
        if token_is_not_correct: self.disconnect(user_id)
    
    def on_disconnect(self):
        pass

    def on_add_new_alarm(self, alarm):
        id = alarm["id"]
        self.alarms[id] = {
            "second": alarm["second"],
            "delete": False
        }
        thread = Thread(target= copy_current_request_context(lambda: self.run_alarm(id)))
        thread.start()
    
    def on_delete_alarm(self,id):
        del self.alarms[id]

    def run_alarm(self,id):
        while True:
            alarm = self.alarms.get(id,False)
            if not alarm: break
            if alarm["delete"]: break 
            second = alarm.get("second")
            alarm_is_over = self.processTime.make_alarm(second=second)
            if alarm_is_over:
                emit("alarm_is_over",f"alarm time = {id}")
                break