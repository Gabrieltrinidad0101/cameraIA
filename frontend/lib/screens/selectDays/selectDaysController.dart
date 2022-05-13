import 'package:flutter/material.dart';

class SelectDaysController {
  List<String> getSelectDays(List? alarmDays) {
    List<String> days = [];
    alarmDays?.forEach((day) {
      if (day["status"]) {
        days.add(day["name"]);
      }
    });
    return days;
  }

  List<Map> getSelectedDaysOfArguments(context, _alarmDays) {
    var arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments == null) return _alarmDays;
    List? selectObjects = arguments as List;
    List<Map> alarmDays =
        setSeletedcObjectsInAlarmDays(_alarmDays, selectObjects);
    return alarmDays;
  }

  goToBack(context, [_alarmDays]) {
    List<String> alarmDays = getSelectDays(_alarmDays);
    Navigator.pop(context, alarmDays);
  }

  List<Map> setSeletedcObjectsInAlarmDays(
      List<Map> alarmDays, List selectDays) {
    for (var day in alarmDays) {
      for (var selectDay in selectDays) {
        if (day["name"] == selectDay) {
          day["status"] = true;
        }
      }
    }
    return alarmDays;
  }
}
