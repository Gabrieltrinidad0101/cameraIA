import json
def import_json_file(path):
    alarm_data_modify_json = open(f"test/utils/data/{path}")
    return json.load(alarm_data_modify_json)