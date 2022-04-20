import socket
from server.src.app import create_app
import pytest

@pytest.fixture
def client():
    app,_ = create_app("test")
    flask_app = app.test_client()
    return flask_app


def test_add_alarm(client):
    response = client.post("/api/alarm/add",data = {
    "time": {
        "start_alarm": {
            "second": 0,
            "minute": 54
        },
        "end_alarm":{
            "second": 0,
            "minute": 55
        }
    },
    "objects": ["person"]
})
    assert(response.status_code == 200)