import "package:frontend/languages/laguages.dart";

Map defaultAlarm() {
  Languages languages = Languages();

  List alarmDays = languages.get("alarmDays");

  List days = [];
  for (Map alarmDay in alarmDays) {
    days.add(alarmDay["name"]);
  }

  return {
    "time": {
      "start_alarm": {"hour": 18, "minute": 15},
      "end_alarm": {"hour": 7, "minute": 45}
    },
    "alarm_days": days,
    "objects": ["person"],
    "status": true
  };
}
