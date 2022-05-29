import cv2
import base64
class Camera:
    def __init__(self,type) -> None:
        self.cap = cv2.VideoCapture(type)
        
    def reads(self):
        frame = self.cap.read()
        return [frame,frame]
    
    def frame_to_str(self,frame):
        res, frame = cv2.imencode(".jpg",frame)
        data = base64.b64encode(frame)
        frame_str = str(data, "utf-8")
        return frame_str   

    def show_frame(self,frame):
        cv2.imshow('frame', frame)
        if cv2.waitKey(1) == ord('q'): return None,"Stop camera"




