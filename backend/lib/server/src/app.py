from dotenv import load_dotenv
from flask import Flask
from .config.config_server import ConfigServer
from flask_socketio import SocketIO
from flask_cors import CORS
from .socket.camera.camera_socket import CameraSocket
from .socket.alarm.alarm import AlarmSocket
from .scripts.qr_code.qr_code import QrCode
qr_code = QrCode()
qr_code.make()

app = Flask(__name__) 
load_dotenv()
CORS(app)
app.config.from_object(ConfigServer.config())
socket = SocketIO(app,cors_allowed_origins="*")
socket.on_namespace(CameraSocket("/camera"))
socket.on_namespace(AlarmSocket("/alarms"))
