import datetime, time
import threading

alarms = {}

def get_current_time():
    current_date = datetime.datetime.now()
    year = current_date.year
    month = current_date.month
    day = current_date.day
    hour = current_date.hour
    minute = current_date.minute
    second = current_date.second
    current_date = datetime.datetime(year, month, day, hour, minute,second)
    return current_date,year, month, day, hour, minute

def make_alarm(second,name):
    while True:
        current_date,year, month, day, hour, minute = get_current_time()
        alarm_1 = datetime.datetime(year, month, day, hour, minute,second)
        time_1 =  time.mktime(alarm_1.timetuple()) - time.mktime(current_date.timetuple())
        if(alarms[name]):
            print("end")
            break
        if(time_1 <= 0):
            print(f"done {name}")
            break
while True:
    stop = input("stop ")
    if(stop): alarms[stop] = True
    name = input("name ")
    alarms[name] = False
    second = int(input("second "))
    t1 = threading.Thread(target=make_alarm,args=(second,name))
    t1.start()

