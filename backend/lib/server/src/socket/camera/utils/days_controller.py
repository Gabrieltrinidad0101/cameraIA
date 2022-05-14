import datetime
from server.src.constant.days import NEXT_DAYS,DAYS

def get_day(day=False):
    current_date = day or datetime.datetime.now()
    numero_dia = int(current_date.strftime("%w"))
    day = DAYS[numero_dia]
    return day


def get_next_day(days: list):
    len_days = len(days)
    days_with_next_days = [*days]
    for i in range(0,len_days):
        next_day = NEXT_DAYS[days[i]]
        if i == len_days - 1:
            days_with_next_days.append(next_day)
            break
        days_with_next_days.insert(i + 1,next_day)
    return days_with_next_days


def get_yesterday(date = None):
    return (date or datetime.datetime.now()) + datetime.timedelta(days=-1)