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

    def check_if_current_time_is_between_start_alarm_and_end_alarm(self,alarm):
        start_alarm = alarm.get("start_alarm")
        end_alarm = alarm.get("end_alarm")
        
        current_time_in_second = self.get_time()
        start_alarm_time_in_second = self.get_time(start_alarm)
        end_alarm_time_in_second  = self.get_time(end_alarm)

        if current_time_in_second >= start_alarm_time_in_second and current_time_in_second <= end_alarm_time_in_second:
            return True
        return False

    def process(self,alarm):
        alarm_is_not_processing = False 
        if not alarm: return alarm_is_not_processing
        alarm_is_processing = self.check_if_current_time_is_between_start_alarm_and_end_alarm(alarm)
        return alarm_is_processing


