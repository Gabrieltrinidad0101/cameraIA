def make_alarm_especific_time(alarm_data):
    return {
                "start_alarm": {
                    "hour": alarm_data[0],
                    "minute": alarm_data[1]
                },
                "end_alarm":{
                    "hour": alarm_data[2],
                    "minute": alarm_data[3]
                }
            }

