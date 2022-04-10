import cv2
import sys
from readers.src.camera.camera import Camera

class DetectionObjects:
    def __init__(self,previous: bool = False,type_read = "") -> None:
        self.Conf_threshold = 0.4    
        self.NMS_threshold = 0.4
        self.camera = Camera(type_read)
        self.previous = previous

        self.IA_DETECTION_OBJECTS_DATA_PATH = f"{sys.path[0]}/ia/ias/ia_detection_objects_data" 
        self.OBJECTS_NAME_PATH_TO_DETECT = f"{self.IA_DETECTION_OBJECTS_DATA_PATH}/object_to_detect/coco.names"
        self.YOLOV4_TINY_WEIGHT_PATH = f"{self.IA_DETECTION_OBJECTS_DATA_PATH}/model_ia/yolov4-tiny.weights"
        self.YOLOV4_TINY_CFG_PATH = f"{self.IA_DETECTION_OBJECTS_DATA_PATH}/config_ia/yolov4-tiny.cfg"

        self.name_of_the_objects_to_detect = self.get_the_name_of_the_objects_to_detect()


    def get_the_name_of_the_objects_to_detect(self) -> list:
        with open(self.OBJECTS_NAME_PATH_TO_DETECT, "r") as object_to_detect:
            list_to_object_to_detect = [cname.strip() for cname in object_to_detect.readlines()]    
            return list_to_object_to_detect
    
    def load_objects_to_detect(self):
        net = cv2.dnn.readNet(self.YOLOV4_TINY_WEIGHT_PATH, self.YOLOV4_TINY_CFG_PATH)
        net.setPreferableBackend(cv2.dnn.DNN_BACKEND_OPENCV)
        net.setPreferableTarget(cv2.dnn.DNN_TARGET_CPU)
        return net
    
    def get_model(self):
        net = self.load_objects_to_detect()
        model = cv2.dnn_DetectionModel(net)
        model.setInputParams(size=(416, 416), scale=1/255, swapRB=True)
        return model
    
    def detection(self):
        model = self.get_model()
        ret,frame = self.camera.reads()
        if not ret:
            return None,"We can not open camera"
        if self.previous: 
            stop_read = self.camera.show_frame(frame)
            if stop_read: return stop_read
            
        _,_ ,boxes = model.detect(frame, self.Conf_threshold, self.NMS_threshold)
        return {"frame": frame,"position_of_square": boxes},None

    
if __name__ == "__main__":
    detectionObject = DetectionObjects()
    print(detectionObject.detect())