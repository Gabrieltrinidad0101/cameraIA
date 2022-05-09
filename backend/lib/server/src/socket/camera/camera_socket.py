from flask_socketio import Namespace,emit
from flask import request
from readers.src.camera.camera import Camera
from ia.src.ia_detection_objects.ia_detection_objects import DetectionObjects
from .utils.alarm import Alarm
from server.src.services.database.alarms import DatabaseAlarm
from  .utils.return_repeat_elements import return_repeat_elements
import server.src.services.database.token as DatabaseToken
import json

detectionObjects = DetectionObjects()
databaseAlarm = DatabaseAlarm()


class CameraSocket(Namespace):
    def __init__(self, namespace=None,start_background_task=None,sleep=None):
        super().__init__(namespace)
        self.alarm = Alarm()
        self.start_background_task = start_background_task
        self.sleep = sleep


    def on_connect(self):
        token = request.args["token"]
        user_id = request.sid
        token_is_not_correct = DatabaseToken.verify_token(token)
        if token_is_not_correct: self.disconnect(user_id)
    
    def on_disconnect(self):
        pass

    def on_cameras_video(self, message):
        camera = Camera("http://10.0.0.12:3000/videoplayback.mp4")
        while True:
            list_frames = []
            frames = camera.reads()
            for ret,frame in frames: 
                ai_data,error = detectionObjects.detection(ret,frame)
                if error: return emit("camera_error",error)
                if ai_data["labels"]: self.emit_alarm(ai_data)
                frame_str = camera.frame_to_str(frame)
                list_frames.append(frame_str)
            self.sleep(.5)

    
    def emit_alarm(self,ai_data):
        datas = databaseAlarm.get_all()
        labels = ai_data["labels"]
        for data in datas:
            alarm = json.loads(data["alarm"])
            alarm_days = alarm["alarm_days"]
            objects_to_detect = alarm["objects"]
            time = alarm["time"]
            alarm_is_processing = self.alarm.process(time,alarm_days)
            if alarm_is_processing:
                detected_objects = return_repeat_elements(labels,objects_to_detect)
                if detected_objects:
                    emit("camera_detect_obejct",detected_objects)