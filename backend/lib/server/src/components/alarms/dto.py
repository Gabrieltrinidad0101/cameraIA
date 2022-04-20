def dto_alarm(alarm):
    start_alarm = alarm["time"]["start_alarm"]
    end_alarm = alarm["time"]["end_alarm"]

    start_second = start_alarm["second"]
    start_minute = start_alarm["minute"]

    end_second = end_alarm["second"]
    end_minute = end_alarm["minute"]

    return {
        "time": {
            "start_alarm": {
                "second": start_second,
                "minute": start_minute
            },
            "end_alarm":{
                "second": end_second,
                "minute": end_minute
            }
        },
        "objects": alarm["objects"]
    }