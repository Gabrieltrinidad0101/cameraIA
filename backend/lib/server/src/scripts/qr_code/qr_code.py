import pyqrcode
import uuid
import server.src.services.database.token as DatabaseToken
class QrCode:
    def make(self):
        token = uuid.uuid1().hex
        token = DatabaseToken.if_exists_return_old_token_otherwise_save_it(token)
        token = pyqrcode.create(f"{token}")
        print(token.terminal())