import cv2
import sys
import base64
class Camera:
    def __init__(self,video) -> None:
        self.cap = cv2.VideoCapture(video)
        
    def reads(self):
        return [self.cap.read(),self.cap.read()]
    
    def frame_to_str(self,frame):
        res, frame = cv2.imencode(".jpg",frame)
        data = base64.b64encode(frame)
        frame_str = str(data, "utf-8")
        return frame_str   

    def show_frame(self,frame):
        cv2.imshow('frame', frame)
        if cv2.waitKey(1) == ord('q'): return None,"Stop camera"




