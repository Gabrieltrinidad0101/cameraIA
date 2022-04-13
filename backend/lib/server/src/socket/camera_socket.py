from flask_socketio import Namespace,emit
from flask import request
from readers.src.camera.camera import Camera
from ia.src.ia_detection_objects.ia_detection_objects import DetectionObjects
import server.src.services.db as db
camera = Camera("video")
detectionObjects = DetectionObjects()

class CameraSocket(Namespace):
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




