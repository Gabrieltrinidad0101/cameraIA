from crypt import methods
from dotenv import load_dotenv
from flask import Flask
from .config.config_server import ConfigServer
from flask_socketio import SocketIO
from flask_cors import CORS
from .socket.camera.camera_socket import CameraSocket
from .routes.router import router
#from .socket.alarm.alarm import AlarmSocket
from .scripts.qr_code.qr_code import QrCode
qr_code = QrCode()
qr_code.make()

app = Flask(__name__) 

@app.route("/",methods=["GET"])
def a():
    return "ok"

CORS(app)    
app.config.from_object(ConfigServer.config())
load_dotenv()
app.register_blueprint(router)
socket = SocketIO(app,cors_allowed_origins="*")
socket.on_namespace(CameraSocket("/camera"))
