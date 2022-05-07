import 'package:flutter/material.dart';
import 'package:frontend/screens/addOrEditAlarm/utils/parseAlrm.dart';
import 'package:frontend/services/api/alarms.dart' as AlarmServices;
import 'package:frontend/widgets/alert/info.dart';
import 'package:frontend/Mixins/arrayToString.dart';

class AddOrEditAlarmController with ArrayToString {
  goToBack(context) {
    Navigator.pop(context);
  }

  go({context, name, arguments}) async {
    return await Navigator.of(context).pushNamed(name, arguments: arguments);
  }

  Future? goToSelectDays(context, _alarmDays) async {
    List? alarmDays =
        await go(context: context, name: "/selectDays", arguments: _alarmDays);
    return alarmDays;
  }

  goToObjectToDetect(context) {
    go(context: context, name: "/objectToDetect");
  }

  String processTime(TimeOfDay? time, context) {
    return time?.format(context) ?? "00:00 PM/AM";
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

  saveAlarm(context, TimeOfDay? timeStart, TimeOfDay? timeEnd,
      List<String> alarmDays) async {
    if (timeStart == null || timeEnd == null || alarmDays.isEmpty) {
      return alert_info(
          context: context,
          title: "Error",
          description: "Es necesario que agrege tiempo de inicio y final");
    }
    Map alarm = parseAlarm(timeStart, timeEnd, alarmDays);
    final data = await AlarmServices.add(alarm);
    print(data);
  }
}
