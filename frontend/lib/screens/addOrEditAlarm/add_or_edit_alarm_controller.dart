import 'package:flutter/material.dart';
import 'package:frontend/screens/addOrEditAlarm/utils/parse_alarm.dart';
import 'package:frontend/services/api/alarms.dart' as alarm_http;
import 'package:frontend/widgets/alert/error.dart';
import 'package:frontend/Mixins/array_to_string.dart';
import 'package:frontend/utils/parse_days.dart';
import 'package:frontend/Mixins/loading_dialog.dart';
import 'package:frontend/widgets/text/text_language.dart';

class AddOrEditAlarmController with ArrayToString, LoadingDialog {
  ParseDays parseDays = ParseDays();

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

  processAlarmData(Map alarm) {
    Map _alarm = alarm;

    TimeOfDay startAlarm = TimeOfDay(
      hour: _alarm["time"]["start_alarm"]["hour"],
      minute: _alarm["time"]["start_alarm"]["minute"],
    );

    TimeOfDay endAlarm = TimeOfDay(
      hour: _alarm["time"]["end_alarm"]["hour"],
      minute: _alarm["time"]["end_alarm"]["minute"],
    );

    alarm = {
      "startAlarm": startAlarm,
      "endAlarm": endAlarm,
      "alarmDays": _alarm["alarm_days"],
      "_id": _alarm["_id"].toString(),
      "objects": _alarm["objects"],
      "status": _alarm["status"]
    };
    return alarm;
  }

  Map? getArguments(context) {
    var arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments == null) return null;
    Map data = arguments as Map;

    String title = data["title"];
    Map alarm = processAlarmData(data["alarm"]);
    alarm["isEdit"] = true;
    return {"alarm": alarm, "title": title};
  }

  saveOrEditAlarm(context, Map alarm, _keyLoader) async {
    showLoadingDialog(context, _keyLoader);
    Map newAlarm = parseAlarm(alarm);
    Map res = {};
    if (alarm["isEdit"] == null) {
      res = await alarm_http.add(newAlarm);
    } else {
      res = await alarm_http.update(newAlarm, alarm["_id"]);
    }
    if (res["error"] != null) {
      hiddenLoadingDialog(_keyLoader);
      alertError(context, TextLanguage(res["error"]));
      return;
    }
    newAlarm["alarm_days"] = parseDays.daysDecode(newAlarm["alarm_days"]);
    newAlarm["_id"] = res["id"];
    hiddenLoadingDialog(_keyLoader);
    Navigator.pop(context, newAlarm);
  }

  List getDaysName(List alarmDays) {
    List days = [];
    for (Map alarmDay in alarmDays) {
      days.add(alarmDay["name"]);
    }
    return days;
  }
}
