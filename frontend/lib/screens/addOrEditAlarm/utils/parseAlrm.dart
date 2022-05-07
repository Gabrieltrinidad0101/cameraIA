import 'package:flutter/material.dart' show TimeOfDay;
import 'package:frontend/utils/parseDays.dart';

Map parseAlarm(TimeOfDay timeStart, TimeOfDay timeEnd, List<String> alarmDays) {
  ParseDays parseDays = ParseDays();
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
    "alarm_days": parseDays.daysEncode(alarmDays),
    "objects": ["person", "cat"]
  };
}
