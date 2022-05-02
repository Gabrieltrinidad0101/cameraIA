import pytest
from server.src.socket.camera.utils.alarm import Alarm
from .utils.make_alarm import make_alarm
@pytest.mark.parametrize(
    "input_a,expected",
    [
        ([-1,0,1,0],True),
        ([1,1,1,1],False),
        ([-2,0,-1,0],False),
        ([0,1,0,1],False),
        ([0,-1,0,0],True),
        ([0,0,0,-1],False),
        ([1,0,0,0],False),
        ([0,0,0,-10],False),
        ([-30,0,0,-10],False),
        ([-500,-20,-30,-10],False),
        ([-3,0,500,50],True),
    ]
)
def test_check_if_current_time_is_between_start_alarm_and_end_alarm(input_a,expected):
    alarm = Alarm()
    alarm_data = make_alarm(input_a)
    if(alarm_data == "overflow"): return
    assert(alarm.process(alarm_data) == expected)
