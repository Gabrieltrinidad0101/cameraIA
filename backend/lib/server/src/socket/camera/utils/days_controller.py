from datetime import datetime
from server.src.constant.days import DICT_DAYS,DAYS

def get_current_day(day=False):
    current_date = day or datetime.now()
    numero_dia = int(current_date.strftime("%w"))
    day = DAYS[numero_dia]
    return day


def get_next_day(days: list):
    len_days = len(days)
    days_with_next_days = [*days]
    for i in range(0,len_days):
        next_day = DICT_DAYS[days[i]]
        if i == len_days - 1 and not next_day in days:
            days_with_next_days.append(next_day)
        elif not next_day in days:
            days_with_next_days.insert(i + 1,next_day)
    return days_with_next_days
