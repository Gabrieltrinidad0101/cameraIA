# Import Module
import socket

def IPv4():
    # Create a socket object
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

    # connect to the server on local computer
    s.connect(("8.8.8.8", 80))

    # Print Output
    host_name = s.getsockname()[0]
    s.close()
    return host_name