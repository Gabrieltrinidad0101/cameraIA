from server.src.config.config_server import ConfigServer
dev = ConfigServer.config("development")
from server.src.app import create_app
if __name__ == "__main__":
    app,socket = create_app(dev)
    socket.run(app)