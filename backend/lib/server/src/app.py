from flask import Flask
from .config.config_server import ConfigServer
from flask_socketio import SocketIO
from flask_cors import CORS
from .socket.camera.camera_socket import CameraSocket
from .routes.router import router
from .scripts.qr_code.qr_code import QrCode
def create_app(enviroment):
    qr_code = QrCode()
    qr_code.make()
    app = Flask(__name__) 
    app.config.from_object(enviroment)
    CORS(app)   
    app.register_blueprint(router)
    socket = SocketIO(app,cors_allowed_origins="*")
    socket.on_namespace(CameraSocket("/camera"))
    return app,socket