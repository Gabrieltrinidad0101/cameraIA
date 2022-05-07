import pytest
from server.src.socket.camera.utils.alarm import Alarm
from .utils.make_alarm import make_alarm
@pytest.mark.parametrize(
    "input_a,days,expected",
    [
        ([-1,0,1,0],[0,1,-1],True),
        ([1,1,1,1],[1,-1],False),
        ([-2,0,-1,0],[-2,1],False),
        ([0,1,0,1],[-2,-3],False),
        ([0,-1,0,0],[0],True),
        ([0,0,0,-1],[3],False),
        ([1,0,0,0],[4],False),
        ([0,0,0,-10],[10,13,15],False),
        ([-30,0,0,-10],[2344,-2332],False),
        ([-500,-20,-30,-10],[3342],False),
        ([-3,0,500,50],[-7],True),
        ([-3,0,1,0],[-6],False),
        ([-3,0,1,50],[-5,-4,3,4],False),
        ([-3,0,0,0],[-7,7],True),
        ([-2,0,0,0],[-7,7],True),
        ([0,-100,0,0],[-7,7,0],True),
    ]
)
def test_check_if_current_time_is_between_start_alarm_and_end_alarm(input_a,days,expected):
    alarm = Alarm()
    alarm_data,days_by_names = make_alarm(input_a,days)
    if(alarm_data == "overflow"): return
    alarm_data,days_by_names = make_alarm(input_a,days)
    assert(alarm.process(alarm_data,days_by_names) == expected)
