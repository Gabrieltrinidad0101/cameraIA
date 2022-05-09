import 'package:flutter/material.dart' show Navigator;

class SelectDaysController {
  List getSelectDays(List alarmDays) {
    List<String> days = [];
    for (var day in alarmDays) {
      if (day["status"]) {
        days.add(day["name"]);
      }
    }
    return days;
  }

  goToBack(context, [_alarmDays]) {
    List alarmDays = getSelectDays(_alarmDays);
    Navigator.pop(context, alarmDays);
  }

  List<Map> getSelectedDays(List<Map> listOfDays, List selectDays) {
    for (var dataOfDay in listOfDays) {
      for (var selectDay in selectDays) {
        if (dataOfDay["name"] == selectDay) {
          dataOfDay["status"] = true;
        }
      }
    }
    return listOfDays;
  }
}
