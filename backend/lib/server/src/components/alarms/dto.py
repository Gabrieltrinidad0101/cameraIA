def dto_alarm(alarm):
    start_alarm = alarm["time"]["start_alarm"]
    end_alarm = alarm["time"]["end_alarm"]

    start_hour = start_alarm["hour"]
    start_minute = start_alarm["minute"]

    end_hour = end_alarm["hour"]
    end_minute = end_alarm["minute"]

    return {
        "time": {
            "start_alarm": {
                "hour": start_hour,
                "minute": start_minute
            },
            "end_alarm":{
                "hour": end_hour,
                "minute": end_minute
            }
        },
        "objects": alarm["objects"]
    }