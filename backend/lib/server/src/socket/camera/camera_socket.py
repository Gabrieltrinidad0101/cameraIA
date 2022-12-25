from flask_socketio import Namespace,emit
from flask import request,copy_current_request_context
from readers.src.camera.camera import Camera
from ia.src.ia_detection_objects.ia_detection_objects import DetectionObjects
from .utils.alarm import Alarm
from server.src.services.database.alarms import DatabaseAlarm
from  .utils.return_repeat_elements import return_repeat_elements
import server.src.services.database.token as DatabaseToken
from server.src.config.config_server import ConfigServer
from concurrent.futures import ThreadPoolExecutor
import json

detectionObjects = DetectionObjects()
databaseAlarm = DatabaseAlarm()
camera_url_test = ConfigServer.get().HOST
camera = Camera(f"http://{camera_url_test}:3000/videoplayback.mp4")
executor = ThreadPoolExecutor(max_workers=10)

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
        print("Start processs camera")
        self.process_camera()

    def process_camera(self):
        while True:
            objects_to_detect = self.there_are_alarms_are_in_progress()
            self.sleep(.06)
            if not objects_to_detect: continue
            camera_detect_object = self.detect_objects()
            detected_objects = return_repeat_elements(camera_detect_object,objects_to_detect)
            if detected_objects: 
                executor.submit(copy_current_request_context(lambda: self.send_alart(detected_objects)))

    def send_alart(self,detected_objects):
        self.sleep(.01)
        emit("camera_detect_obejct",detected_objects)

    def detect_objects(self):
        frames = camera.reads()
        for ret,frame in frames:
            camera.show_frame(frame)
            ai_data,error = detectionObjects.detection(ret,frame)
            if error: return emit("camera_error",error)
        return ai_data["labels"]

    def there_are_alarms_are_in_progress(self):
        datas = databaseAlarm.get_all()
        for data in datas:
            alarm = json.loads(data["alarm"])
            status = alarm["status"]
            if not status: continue
            alarm_days = alarm["alarm_days"]
            objects_to_detect = alarm["objects"]
            time = alarm["time"]
            alarm_is_processing = self.alarm.process(time,alarm_days)
            if alarm_is_processing:
                return objects_to_detect