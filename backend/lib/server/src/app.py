from crypt import methods
from dotenv import load_dotenv
from flask import Flask
from .config.config_server import ConfigServer
from flask_socketio import SocketIO
from flask_cors import CORS
from .socket.camera.camera_socket import CameraSocket
from .routes.router import router
from .scripts.qr_code.qr_code import QrCode
qr_code = QrCode()
qr_code.make()

app = Flask(__name__) 

CORS(app)    
app.config.from_object(ConfigServer.config())
load_dotenv()
app.register_blueprint(router)
socket = SocketIO(app,cors_allowed_origins="*",always_connect=True, async_mode="threading")
socket.on_namespace(CameraSocket("/camera"))
