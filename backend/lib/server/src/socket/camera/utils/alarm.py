import datetime,time
from .get_current_day import get_day_name

class Alarm:
    def get_time(self,date={}):
        year = self.get_specific_time(date,"year")
        month = self.get_specific_time(date,"month")
        day = self.get_specific_time(date,"day")
        hour = self.get_specific_time(date,"hour")
        minute = self.get_specific_time(date,"minute")
        second = self.get_specific_time(date,"second")
        current_date = datetime.datetime(year, month, day, hour, minute,second)
        return current_date

    def get_specific_time(self,date,_type):
        current_date = datetime.datetime.now()
        specific_date = date.get(_type,False)
        if(specific_date or specific_date is 0): return specific_date
        if(not specific_date): return getattr(current_date,_type)


    def verify_alarm_days(self,days):
        if(get_day_name() in days):
            return True

    def check_if_current_time_is_between_start_alarm_and_end_alarm(self,alarm,alarm_days,current_time):
        start_alarm = alarm["start_alarm"]
        end_alarm = alarm["end_alarm"]

        current_time = current_time or self.get_time()
        start_alarm_time = self.get_time(start_alarm)
        end_alarm_time  = self.get_time(end_alarm)
        if start_alarm_time > end_alarm_time:
            end_alarm_time = end_alarm_time + datetime.timedelta(days=1)
            day_name = get_day_name(end_alarm_time)
            alarm_days.append(day_name)
        is_alarm_day = self.verify_alarm_days(alarm_days)
        if current_time >= start_alarm_time and current_time <= end_alarm_time and is_alarm_day:
            return True
        return False

    def process(self,alarm,alarm_days,current_time=None):
        alarm_is_processing = self.check_if_current_time_is_between_start_alarm_and_end_alarm(alarm,alarm_days,current_time)
        return alarm_is_processing