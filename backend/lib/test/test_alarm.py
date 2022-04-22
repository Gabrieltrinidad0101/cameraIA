from signal import alarm
from server.src.config.config_server import ConfigServer
test = ConfigServer.config("test")
from server.src.app import create_app
import pytest
from .utils.headers_token_content_json import headers_token_content_json
import json

alarm_data = open("test/utils/data/alarm_data.json")
alarm_data_dict = json.load(alarm_data)


alarm_data_modify_json = open("test/utils/data/alarm_data_modify.json")
alarm_data_modify = json.load(alarm_data_modify_json)

@pytest.fixture
def client():
    app,_ = create_app(test)
    flask_app = app.test_client()
    return flask_app


def test_add_alarm(client):
    for key in alarm_data_dict:
        response = client.post("api/alarm/add",
            data = json.dumps(alarm_data_dict[key]),
            headers=headers_token_content_json
        )
        assert(response.status_code == 200)


def test_get_alarm(client):
    response = client.get("api/alarm/get",
        headers=headers_token_content_json
    )
    assert(response.json != None)
    assert(response.status_code == 200)


def test_edit_alarm(client):
    get_alarms = client.get("api/alarm/get",
        headers=headers_token_content_json
    )
    for i in range(0,len(alarm_data_modify)):
        alarm_id = get_alarms.json[i]["_id"]["$oid"]
        update_alarm = client.put(f"api/alarm/update/{alarm_id}",
            data = json.dumps(alarm_data_modify[i]),
            headers=headers_token_content_json
        )
        assert(update_alarm.status_code == 200)

        alarm = client.get(f"api/alarm/get_one/{alarm_id}",
            headers=headers_token_content_json
        )
        assert(alarm.json["alarm"] ==  json.dumps(alarm_data_modify[i]))



def test_delete_alarm(client):
    get_alarms = client.get("api/alarm/get",
        headers=headers_token_content_json
    )
    for i in range(0,len(get_alarms.json)):
        alarm_id = get_alarms.json[i]["_id"]["$oid"]
        delate_alarm = client.delete(f"api/alarm/delete/{alarm_id}",
            headers=headers_token_content_json
        )
        assert(delate_alarm.status_code == 200)

        alarm = client.get(f"api/alarm/get_one/{alarm_id}",
            headers=headers_token_content_json
        )
    
        assert(alarm.json == None)


def test_error_token(client):
    get_alarms = client.get("api/alarm/get",
        headers={'Content-Type': 'application/json'}
    )
    assert(get_alarms.json["error"] == "you don't have token" and get_alarms.status_code == 500)

    get_alarms = client.get("api/alarm/get",
        headers={"token": "ssssss",'Content-Type': 'application/json'}
    )
    assert(get_alarms.json["error"] == "the token is incorrent" and get_alarms.status_code == 500)