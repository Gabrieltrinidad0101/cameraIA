from server.src.config.config_server import ConfigServer
environment = ConfigServer.config("development")
from server.src.app import create_app


if __name__ == "__main__":
    app,socket = create_app(environment)
    socket.run(app,host=environment.HOST,port=environment.PORT)