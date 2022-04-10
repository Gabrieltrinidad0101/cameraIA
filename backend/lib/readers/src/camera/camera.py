import cv2
import sys

class Camera:
    def __init__(self,type: str = "",path: str = "/test_video/videoplayback.mp4") -> None:
        self.video_path = f"{sys.path[0]}/readers/src/camera"
        self.cap = self._type_of_read(type,path)
        
    def _type_of_read(self,type, path: str = ""):
        cap = None
        if type == "video":
            cap = cv2.VideoCapture(f"{self.video_path}{path}")
        else:
            cap = cv2.VideoCapture(0)
        return  cap
    
    def reads(self):
        return self.cap.read()
    

    def show_frame(self,frame):
        cv2.imshow('frame', frame)
        if cv2.waitKey(1) == ord('q'): return None,"Stop camera"




