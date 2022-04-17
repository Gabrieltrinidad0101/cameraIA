import datetime,time
class Alarm:
    def get_time(self,year = False,month = False,day = False,hour = False,minute = False,second = False):
        current_date = datetime.datetime.now()
        year = year or current_date.year
        month = month or current_date.month
        day = day or current_date.day
        hour = hour or current_date.hour
        minute = minute or current_date.minute
        second = second or current_date.second
        current_date = datetime.datetime(year, month, day, hour, minute,second)
        current_date_in_second = time.mktime(current_date.timetuple())
        return current_date_in_second
    
    def get_time_from_alarm(self,time):
        second = time.get("second")
        minute = time.get("minute")
        return second,minute

    def check_if_current_time_is_between_start_alarm_and_end_alarm(self,alarm):
        start_alarm = alarm.get("start_alarm")
        end_alarm = alarm.get("end_alarm")
        start_alarm_second,start_alarm_minute = self.get_time_from_alarm(start_alarm)
        end_alarm_second,end_alarm_minute = self.get_time_from_alarm(end_alarm)
        
        current_time_in_second = self.get_time()
        start_alarm_time_in_second = self.get_time(second=start_alarm_second,minute=start_alarm_minute)
        end_alarm_time_in_second  = self.get_time(second=end_alarm_second,minute=end_alarm_minute)

        if current_time_in_second >= start_alarm_time_in_second and current_time_in_second <= end_alarm_time_in_second:
            return True
        return False

    def process(self,alarm):
        alarm_is_not_processing = False 
        if not alarm: return alarm_is_not_processing
        alarm_is_processing = self.check_if_current_time_is_between_start_alarm_and_end_alarm(alarm)
        return alarm_is_processing


