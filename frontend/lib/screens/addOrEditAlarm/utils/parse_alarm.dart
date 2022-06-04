import 'package:frontend/utils/parse_days.dart';

Map parseAlarm(alarm) {
  ParseDays parseDays = ParseDays();
  return {
    "time": {
      "start_alarm": {
        "hour": alarm["startAlarm"].hour.toInt(),
        "minute": alarm["startAlarm"].minute.toInt()
      },
      "end_alarm": {
        "hour": alarm["endAlarm"].hour.toInt(),
        "minute": alarm["endAlarm"].minute.toInt()
      }
    },
    "alarm_days": parseDays.daysEncode(alarm["alarmDays"]),
    "objects": alarm["objects"],
    "status": alarm["status"],
  };
}
