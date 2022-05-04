import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/clock/clock.dart';

class AddOrEditAlarmController {
  go(context, name) {
    Navigator.of(context).pushNamed(name);
  }

  goToSelectDays(context) {
    go(context, "/selectDays");
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
}
