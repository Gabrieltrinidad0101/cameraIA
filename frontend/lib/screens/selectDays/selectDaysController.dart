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
    listOfDays.forEach((dataOfDay) {
      selectDays.forEach((selectDay) {
        if (dataOfDay["name"] == selectDay) {
          dataOfDay["status"] = true;
        }
      });
    });
    //for (var j = 0; j < listOfDays.length; j++) {
    //  for (var i = 0; i < selectDays.length; i++) {
    //    if (listOfDays[j]["name"] == selectDays[i]) {
    //      listOfDays[j]["status"] = true;
    //    }
    //  }
    //}
    return listOfDays;
  }
}
