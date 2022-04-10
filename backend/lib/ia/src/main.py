from .ia_detection_objects.ia_detection_objects import DetectionObjects

detectionObjects = DetectionObjects(previous=True,type_read="video")

def IA():
    return detectionObjects.detection()

if __name__ == "__main__":
    IA()