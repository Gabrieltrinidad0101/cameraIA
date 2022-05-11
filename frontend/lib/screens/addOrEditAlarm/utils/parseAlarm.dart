import 'package:flutter/material.dart' show TimeOfDay;
import 'package:frontend/utils/parseDays.dart';

Map parseAlarm(
    {required TimeOfDay startAlarm,
    required TimeOfDay endAlarm,
    required List alarmDays,
    required List alarmObjects}) {
  ParseDays parseDays = ParseDays();
  return {
    "time": {
      "start_alarm": {
        "hour": startAlarm.hour.toInt(),
        "minute": startAlarm.minute.toInt()
      },
      "end_alarm": {
        "hour": endAlarm.hour.toInt(),
        "minute": endAlarm.minute.toInt()
      }
    },
    "alarm_days": parseDays.daysEncode(alarmDays),
    "objects": alarmObjects
  };
}
