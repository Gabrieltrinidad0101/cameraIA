import datetime
from .days_controller import get_day, get_next_days, get_yesterday
import copy

class Alarm:
    def get_time(self,date={},current_time = None):
        year = self.get_specific_time(date,"year",current_time)
        month = self.get_specific_time(date,"month",current_time)
        day = self.get_specific_time(date,"day",current_time)
        hour = self.get_specific_time(date,"hour",current_time)
        minute = self.get_specific_time(date,"minute",current_time)
        second = self.get_specific_time(date,"second",current_time)
        current_date = datetime.datetime(year, month, day, hour, minute,second)
        return current_date

    def get_specific_time(self,date,_type,current_time):
        current_date = current_time or datetime.datetime.now()
        specific_date = date.get(_type,False)
        if(specific_date or specific_date is 0): return specific_date
        if(not specific_date): return getattr(current_date,_type)


    def verify_alarm_days(self,days,current_time):
        if(get_day(current_time) in days):
            return True
        return False

    def check_if_current_time_is_between_start_alarm_and_end_alarm(self,alarm,alarm_days,current_time):
        start_alarm = alarm["start_alarm"]
        end_alarm = alarm["end_alarm"]

        current_time = current_time or self.get_time()
        start_alarm_time = self.get_time(start_alarm,current_time)
        end_alarm_time  = self.get_time(end_alarm,current_time)
        if start_alarm_time > end_alarm_time:
            exists_yesterday_name = get_yesterday(current_time) in alarm_days
            alarm_days = get_next_days(alarm_days)
            if exists_yesterday_name:
                new_start_alarm_time = start_alarm_time + datetime.timedelta(days=-1)
                if current_time >= new_start_alarm_time and current_time <= end_alarm_time and self.verify_alarm_days(alarm_days,current_time):
                    return True
            end_alarm_time = end_alarm_time + datetime.timedelta(days=1)
        # print(f"s {start_alarm_time}")
        # print(f"e {end_alarm_time}")
        # print(f"c {current_time}")
        # print(f"d {alarm_days}")
        is_alarm_day = self.verify_alarm_days(alarm_days,current_time)
        if current_time >= start_alarm_time and current_time <= end_alarm_time and is_alarm_day:
            return True
        return False

    def get_midday(self):
        return self.get_time({"hour": 12,"minute": 59,"second": 59})


    def process(self,alarm,alarm_days,current_time=None):
        alarm_is_processing = self.check_if_current_time_is_between_start_alarm_and_end_alarm(alarm,alarm_days,current_time)
        return alarm_is_processing