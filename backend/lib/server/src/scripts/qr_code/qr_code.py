import pyqrcode
import uuid
import server.src.services.database.token as DatabaseToken
from server.src.config.config_server import ConfigServer
class QrCode:
    def make(self):
        server_url = ConfigServer.server_url()
        token = uuid.uuid1().hex
        token = DatabaseToken.if_exists_return_old_token_otherwise_save_it(token)
        token = pyqrcode.create(f"{token} {server_url}")
        print(token.terminal())