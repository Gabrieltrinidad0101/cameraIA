import datetime,time
class ProcessTime:
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

    def make_alarm(self,second):
        current_time = self.get_time()
        run_alarm  = self.get_time(second=second)
        if(run_alarm <= current_time):
            return True
