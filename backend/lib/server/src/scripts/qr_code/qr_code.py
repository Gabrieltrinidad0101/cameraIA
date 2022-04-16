import pyqrcode
import uuid
import server.src.services.db as db
class QrCode:
    def make(self):
        token = uuid.uuid1().hex
        token = db.if_exists_return_old_token_otherwise_save_it(token)
        token = pyqrcode.create(f"{token}")
        print(token.terminal())