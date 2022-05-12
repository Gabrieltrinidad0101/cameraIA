from datetime import datetime
from server.src.constant.days import DAYS

def get_day_name(day=False):
    current_date = day or datetime.now()
    numero_dia = int(current_date.strftime("%w"))
    day = DAYS.get(numero_dia)
    return day
