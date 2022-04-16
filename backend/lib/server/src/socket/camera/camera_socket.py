from flask_socketio import Namespace,emit
from flask import request
from readers.src.camera.camera import Camera
from ia.src.ia_detection_objects.ia_detection_objects import DetectionObjects
import server.src.services.database.token as DatabaseToken
from .utils.alarm import Alarm


camera = Camera("video")
detectionObjects = DetectionObjects()

class CameraSocket(Namespace):
    def __init__(self, namespace=None):
        super().__init__(namespace)
        self.config_alarms = {}
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

    def on_add_new_alarm(self, alarm_data):
        id = "10"
        self.config_alarms[id] = alarm_data
    
    def on_delete_alarm(self,id):
        del self.self.config_alarms[id]
    
    def emit_alarm(self):
        alarms = self.config_alarms["time"]
        alarm_is_processing = self.alarm.process(self.config_alarms)
        if alarm_is_processing: emit("camera_detect_obejct","person")