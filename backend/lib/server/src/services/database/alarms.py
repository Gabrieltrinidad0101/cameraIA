from pymongo import MongoClient
from bson.objectid import ObjectId
import json
import bson.json_util as json_util
from server.src.config.config_server import ConfigServer
class DatabaseAlarm:
    def __init__(self) -> None:
        cluster = MongoClient('mongodb://localhost:27017/')
        db = cluster[ConfigServer.get().DATABASE_NAME]
        self.alarms_db = db["alarms"]

    def _parse_json(self,data):
        return json.loads(json_util.dumps(data))

    def save(self,alarm):
        self.alarms_db.insert_one({"alarm": json.dumps(alarm)})

    def delete(self,id):
        self.alarms_db.delete_one({"_id": ObjectId(id)})

    def edit(self,id,alarm):
        self.alarms_db.update_one({"_id": ObjectId(id)},{"$set": {"alarm":json.dumps(alarm)}})

    def find_one(self,id):
        return self._parse_json(self.alarms_db.find_one({"_id": ObjectId(id)}))

    def get_all(self):
        return self._parse_json(self.alarms_db.find({"alarm": {"$exists": 1}}))
