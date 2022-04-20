from server.src.app import create_app

if __name__ == "__main__":
    app,socket = create_app("development")
    socket.run(app)