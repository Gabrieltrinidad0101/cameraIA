from datetime import datetime
import pytest
from .utils.make_alarm_especific_time import make_alarm_especific_time
from server.src.socket.camera.utils.alarm import Alarm
from .utils.make_alarm_current_time import make_alarm
from .utils.import_json_file import import_json_file
alarm = Alarm()

monday_to_saturday = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
all_days = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]

default_alarms = import_json_file("test_default_alarms.json")
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
        ([0,0,0,-10],[10,13,16],False),
        ([-30,0,0,-10],[2344,-2332],False),
        ([-500,-20,-30,-10],[3342],False),
        ([-3,0,500,50],[-7],True),
        ([-3,0,1,0],[-6],False),
        ([-3,0,1,50],[-5,-4,3,4],False),
        ([-3,0,0,0],[-7,7],True),
        ([-2,0,0,0],[-7,7],True),
        ([0,-100,0,0],[-7,7,0],True),
        ([0,0,0,1],[-7,7,0],True),
    ]
)
def test_check_if_current_time_is_between_start_alarm_and_end_alarm(input_a,days,expected):
    alarm_data,alarm_days = make_alarm(input_a,days)
    if(alarm_data == "overflow"): return
    assert(alarm.process(alarm_data,alarm_days) == expected)

# ([17,26,22,0],["Friday"],datetime(2022,5,14,18,27,0),True),

# 2022,5,14,4,59,41 is moth = may and day = Saturday
# ([17,0,12,59],["Wednesday","Friday"],datetime(2022,5,10,12,58,41),True),
@pytest.mark.parametrize(
    "alarm_data,days,current_time,expected",
    [
        ([18,0,5,0],["Friday"],datetime(2022,5,14,4,59,41),True),
        ([18,0,3,0],["Friday"],datetime(2022,5,14,4,59,41),False),
        ([18,0,3,0],["Saturday"],datetime(2022,5,14,4,59,41),False),
        ([18,0,5,0],["Saturday"],datetime(2022,5,15,4,59,41),True),
        ([18,0,5,0],["Friday","Saturday"],datetime(2022,5,14,4,59,41),True),
        ([18,0,5,0],["Monday"],datetime(2022,5,10,4,59,41),True),
        ([18,0,5,0],["Monday"],datetime(2022,5,11,4,59,41),False),
        ([18,0,5,0],["Tuesday"],datetime(2022,5,10,4,59,41),False),
        ([18,0,5,0],["Thursday"],datetime(2022,5,10,4,59,41),False),
        ([17,0,12,59],["Tuesday","Friday"],datetime(2022,5,10,18,58,41),True),
        ([17,26,22,0],["Friday"],datetime(2022,5,14,18,27,0),False),
        ([18,15,7,45],monday_to_saturday,datetime(2022,5,10,18,0,41),False),
        ([18,15,7,45],monday_to_saturday,datetime(2022,5,12,6,10,0),True),
        ([18,15,7,45],monday_to_saturday,datetime(2022,5,14,17,0,0),False),
        ([0,0,23,59],["Sunday"],datetime(2022,5,15,5,0,0),True),
        ([18,15,7,45],monday_to_saturday,datetime(2022,5,16,3,0,0),False),
        ([18,25,7,45],monday_to_saturday,datetime(2022,5,14,18,30,0),True),
        ([18,25,7,45],["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday"],datetime(2022,5,14,21,52,0),False),
        ([18,25,7,45],["Sunday","Monday","Tuesday","Wednesday","Thursday","Saturday"],datetime(2022,5,13,21,52,0),False),
        ([18,25,7,45],["Monday","Wednesday"],datetime(2022,5,10,3,52,0),True),
        ([18,25,17,45],["Monday","Wednesday"],datetime(2022,5,10,14,52,0),True),
        ([18,25,17,45],["Monday","Wednesday"],datetime(2022,5,12,10,52,0),True),
        ([18,25,17,45],["Friday"],datetime(2022,5,12,10,52,0),False),
        ([18,25,19,45],["Friday"],datetime(2022,5,13,18,52,0),True),
        ([0,0,23,59],all_days,datetime(2022,5,13,21,52,0),True),
        ([0,0,23,59],all_days,datetime(2015,4,22,2,5,0),True),
        ([0,0,23,59],all_days,datetime(2015,12,22,23,59,59),True),
        ([0,0,23,59],all_days,datetime.now(),True),

    ]
)
def test_alarm_with_default_alarm(alarm_data,days,current_time,expected):
    alarm_data = make_alarm_especific_time(alarm_data)
    assert alarm.process(alarm_data,days,current_time) == expected










