import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddOrEditAlarmController {
  goToBack(context) {
    Navigator.pop(context);
  }

  go(context, name) async {
    return await Navigator.of(context).pushNamed(name);
  }

  Future? goToSelectDays(context) async {
    List? alarmDays = await go(context, "/selectDays");
    return alarmDays;
  }

  goToObjectToDetect(context) {
    go(context, "/objectToDetect");
  }

  String processTime(TimeOfDay? time, context) {
    return time?.format(context) ?? TimeOfDay.now().format(context);
  }

  Future<TimeOfDay?> clock(TimeOfDay? initialTime, context) async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: initialTime ?? TimeOfDay.now(),
    );
    return time;
  }

  String alarmDaysProcess(List alarmDays) {
    String days = " ";
    alarmDays.forEach((day) => days += "$day ");
    return days;
  }
}
