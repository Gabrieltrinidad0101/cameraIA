import 'package:flutter/material.dart' show Navigator;

class SelectDaysController {
  List filterDays(List listOfDays) {
    List<String> days = [];
    for (var day in listOfDays) {
      if (day["status"]) {
        days.add(day["name"]);
      }
    }
    return days;
  }

  goToBack(context) {
    Navigator.pop(context);
  }

  gotToAddOrEditAlarm(context, listOfDays) {
    List alarmDays = filterDays(listOfDays);
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
