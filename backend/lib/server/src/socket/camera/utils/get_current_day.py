from datetime import datetime

days = {
    0: "Sunday",
    1: "Monday",
    2: "Tuesday",
    3: "Wednesday",
    4: "Thursday",
    5: "Friday",
    6: "Saturday",
}
def get_current_date():
    current_date = datetime.now()
    numero_dia = int(current_date.strftime("%w"))
    day = days.get(numero_dia)
    return day
