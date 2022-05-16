import datetime

from numpy import number
from server.src.constant.days import NEXT_DAYS,DAYS,DAYS_BY_INDEX

def get_day(day=False):
    current_date = day or datetime.datetime.now()
    numero_dia = int(current_date.strftime("%w"))
    day = DAYS[numero_dia]
    return day


def get_next_days(days: list):
    len_days = len(days)
    days_with_next_days = [*days]
    for i in range(0,len_days):
        next_day = NEXT_DAYS[days[i]]
        if i == len_days - 1:
            days_with_next_days.append(next_day)
            break
        days_with_next_days.insert(i + 1,next_day)
    return days_with_next_days

def get_next_day(date=None):
    next_day = (date or datetime.datetime.now()) + datetime.timedelta(days=1)
    next_day = get_day(next_day)
    return next_day
def get_yesterday(date = None):
    yesterday = (date or datetime.datetime.now()) + datetime.timedelta(days=-1)
    yerterday_name = get_day(yesterday)
    return yerterday_name

def get_number_of_day(day_name,current_time):
    number_of_day = DAYS_BY_INDEX[day_name]
    return ((current_time or datetime.datetime.now()) + datetime.timedelta(days=-number_of_day)).day
