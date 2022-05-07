import datetime,time
class Alarm:
    def get_time(self,date={}):
        current_date = datetime.datetime.now()
        year = date.get("year",False) or current_date.year
        month = date.get("month",False) or current_date.month
        day = date.get("day",False)  or current_date.day
        hour = date.get("hour",False) or current_date.hour
        minute = date.get("minute",False) or current_date.minute
        second = date.get("second",False) or current_date.second
        current_date = datetime.datetime(year, month, day, hour, minute,second)
        current_date_in_second = time.mktime(current_date.timetuple())
        return current_date_in_second

    def verify_alarm_days(self,days):
        if(datetime.datetime.now().strftime('%A') in days):
            return True

    def check_if_current_time_is_between_start_alarm_and_end_alarm(self,alarm,alarm_days):
        start_alarm = alarm["start_alarm"]
        end_alarm = alarm["end_alarm"]
        
        current_time_in_second = self.get_time()
        start_alarm_time_in_second = self.get_time(start_alarm)
        end_alarm_time_in_second  = self.get_time(end_alarm)
        is_alarm_day = self.verify_alarm_days(alarm_days)
        if current_time_in_second >= start_alarm_time_in_second and current_time_in_second <= end_alarm_time_in_second and is_alarm_day:
            return True
        return False

    def process(self,alarm,alarm_days):
        alarm_is_processing = self.check_if_current_time_is_between_start_alarm_and_end_alarm(alarm,alarm_days)
        return alarm_is_processing


