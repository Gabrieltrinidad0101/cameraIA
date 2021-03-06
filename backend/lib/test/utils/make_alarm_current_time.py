import datetime
from datetime import timedelta

def reset_time(hour,minute):
    while minute < 0:
        minute += 59
        hour -= 1
    while hour < 0:
        hour += 23
    return {"hour": hour,"minute": minute}

def overflow(hour,minute):
    if minute > 59:
        return "overflow"
    if hour > 23:
        return "overflow"

def parse_days(_days):
    days_by_names = []
    for day in _days:
        today = datetime.date.today()
        day = today - timedelta(days = day)
        days_by_names.append(day.strftime('%A'))
    return days_by_names


def make_alarm(array_date,days,date=None):
    current_date = date or datetime.datetime.now()
    hour = current_date.hour
    minute = current_date.minute
    start_hour = hour + array_date[0]
    start_minute = minute + array_date[1]

    if(overflow(start_hour,start_minute) == "overflow"): return "overflow",None

    end_hour = hour + array_date[2]
    end_minute = minute + array_date[3]
    if(overflow(end_hour,end_minute) == "overflow"): return "overflow",None
    alarm_data = {
            "start_alarm": reset_time(start_hour,start_minute),
            "end_alarm":reset_time(end_hour,end_minute)
        }
    days_by_names = parse_days(days)
    return alarm_data,days_by_names
    

