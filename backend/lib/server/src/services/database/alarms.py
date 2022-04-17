from pymongo import MongoClient
from bson.objectid import ObjectId
import json
import bson.json_util as json_util
class DatabaseAlarm:
    def __init__(self) -> None:
        cluster = MongoClient('mongodb://localhost:27017/')
        db = cluster["cameraia"]
        self.alarms_db = db["alarms"]

    def _parse_json(self,data):
        return json.loads(json_util.dumps(data))

    def save(self,alarm):
        self.alarms_db.insert_one({"alarm": json.dumps(alarm)})

    def delete(self,id):
        self.alarms_db.delete_one({"_id": ObjectId(id)})

    def edit(self,id,alarm):
        self.alarms_db.update_one({"_id": ObjectId(id)},{"$set": {"alarm":json.dumps(alarm)}})
    
    def get_all(self):
        a = self._parse_json(self.alarms_db.find({"alarm": {"$exists": 1}}))
        return a