from server.src.scripts.qr_code.get_IPv4 import IPv4

class Config:
    DATABASE_NAME = "camera_ia"
    HOST = IPv4()
    PORT = "8080"
