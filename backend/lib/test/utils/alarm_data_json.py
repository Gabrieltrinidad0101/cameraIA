import json
AlarmData = {
    "data1_json": json.dumps({
            "time": {
                "start_alarm": {
                    "second": 0,
                    "minute": 54
                },
                "end_alarm":{
                    "second": 0,
                    "minute": 55
                }
            },
            "objects": ["person"]
    }),
    "data2_json": json.dumps({
            "time": {
                "start_alarm": {
                    "second": 0,
                    "minute": 20
                },
                "end_alarm":{
                    "second": 0,
                    "minute": 39
                }
            },
            "objects": ["person"]
    })
}