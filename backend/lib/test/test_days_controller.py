from server.src.socket.camera.utils.days_controller import get_day
from datetime import datetime
import pytest


@pytest.mark.parametrize(
    "day,expected",
    [
        (datetime(2022,5,15,3,0,0),"Sunday"),
        (datetime(2022,5,16,3,0,0),"Monday"),
        (datetime(2022,5,17,3,0,0),"Tuesday"),
        (datetime(2022,5,18,3,0,0),"Wednesday"),
        (datetime(2022,5,19,3,0,0),"Thursday"),
        (datetime(2022,5,20,3,0,0),"Friday"),
        (datetime(2022,5,21,3,0,0),"Saturday"),
    ]
)

def test_get_day(day,expected):
    assert get_day(day) == expected
