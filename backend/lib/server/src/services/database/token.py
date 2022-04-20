from pymongo import MongoClient
from flask import current_app

cluster = MongoClient('mongodb://localhost:27017/')
db = cluster[current_app.config["DATABASE_NAME"]]
configs = db["configs"]

def if_exists_return_old_token_otherwise_save_it(token: str) -> str:
    config_data = configs.find_one({"token": {"$exists": 1}},{"_id": 0,})
    if config_data: return config_data["token"]
    configs.insert_one({"token": token})
    return token

def verify_token(token):
    config_data = configs.find_one({"token": token})
    print(config_data)
    if config_data: return False
    return True
