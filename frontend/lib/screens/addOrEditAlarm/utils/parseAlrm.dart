import 'package:flutter/material.dart' show TimeOfDay;

Map parseAlarm(TimeOfDay timeStart, TimeOfDay timeEnd, List<String> alarmDays) {
  return {
    "time": {
      "start_alarm": {
        "hour": timeStart.hour.toInt(),
        "minute": timeStart.minute.toInt()
      },
      "end_alarm": {
        "hour": timeEnd.hour.toInt(),
        "minute": timeEnd.minute.toInt()
      }
    },
    "alarm_days": alarmDays,
    "objects": ["person", "cat"]
  };
}
