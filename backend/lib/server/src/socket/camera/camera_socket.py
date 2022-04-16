from flask_socketio import Namespace,emit
from flask import request,copy_current_request_context
from readers.src.camera.camera import Camera
from ia.src.ia_detection_objects.ia_detection_objects import DetectionObjects
import server.src.services.db as db
from threading import Thread
from .utils.process_time import ProcessTime


camera = Camera("video")
detectionObjects = DetectionObjects()
class CameraSocket(Namespace):
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

    def on_cameras_video(self, message):
        while True:
            list_frames = []
            frames = camera.reads()
            for ret,frame in frames: 
                data,error = detectionObjects.detection(ret,frame)
                frame_str = camera.frame_to_str(frame)
                list_frames.append(frame_str)
            emit("get_cameras_video",list_frames)

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




