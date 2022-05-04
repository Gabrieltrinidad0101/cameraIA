import 'package:flutter/material.dart' show Navigator;

class SelectDaysController {
  List filterDays(List listOfDays) {
    List<String> days = [];
    for (var dataOfDay in listOfDays) {
      if (dataOfDay["status"]) {
        days.add(dataOfDay["day"]);
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
}
