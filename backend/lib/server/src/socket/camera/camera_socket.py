from flask_socketio import Namespace,emit
from flask import request
from readers.src.camera.camera import Camera
from ia.src.ia_detection_objects.ia_detection_objects import DetectionObjects
from .utils.alarm import Alarm
from server.src.services.database.alarms import DatabaseAlarm
import server.src.services.database.token as DatabaseToken
import json,time
camera = Camera("video")
detectionObjects = DetectionObjects()
databaseAlarm = DatabaseAlarm()

class CameraSocket(Namespace):
    def __init__(self, namespace=None):
        super().__init__(namespace)
        self.alarm = Alarm()

    def on_connect(self):
        token = request.args["token"]
        user_id = request.sid
        token_is_not_correct = DatabaseToken.verify_token(token)
        if token_is_not_correct: self.disconnect(user_id)
    
    def on_disconnect(self):
        pass

    def on_cameras_video(self, message):
        while True:
            list_frames = []
            frames = camera.reads()
            for ret,frame in frames: 
                data,error = detectionObjects.detection(ret,frame)
                if data: self.emit_alarm()
                frame_str = camera.frame_to_str(frame)
                list_frames.append(frame_str)
            emit("get_cameras_video",list_frames)
    
    def emit_alarm(self):
        datas = databaseAlarm.get_all()
        for data in datas:
            alarm = json.loads(data["alarm"])
            time = alarm["time"]
            alarm_is_processing = self.alarm.process(time)
            if alarm_is_processing: emit("camera_detect_obejct","person")