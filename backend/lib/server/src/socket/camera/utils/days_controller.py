import datetime
from server.src.constant.days import NEXT_DAYS,DAYS,DAYS_BY_INDEX

def get_day(day=False):
    current_date = day or datetime.datetime.now()
    numero_dia = int(current_date.strftime("%w"))
    day = DAYS[numero_dia]
    return day

def get_yesterday(date = None):
    yesterday = (date or datetime.datetime.now()) + datetime.timedelta(days=-1)
    yerterday_name = get_day(yesterday)
    return yerterday_name