from server.src.socket.camera.utils.days_controller import get_next_days,get_day
from datetime import datetime
import pytest

@pytest.mark.parametrize(
    "days,expected",
    [
        (["Sunday","Monday"],["Sunday","Monday","Monday","Tuesday"]),
        (["Sunday","Tuesday"], ["Sunday","Monday","Tuesday","Wednesday"]),
        (["Monday","Sunday"], ["Monday","Tuesday","Sunday","Monday"]),
        (["Tuesday"], ["Tuesday","Wednesday"]),
        (["Thursday"], ["Thursday","Friday"]),
        (["Thursday","Sunday"], ["Thursday","Friday","Sunday","Monday"]),
    ]
)
def test_get_next_day(days,expected):
    days_with_next_days = get_next_days(days)
    assert days_with_next_days == expected
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
