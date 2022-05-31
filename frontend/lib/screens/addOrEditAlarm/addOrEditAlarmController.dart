import 'package:flutter/material.dart';
import 'package:frontend/screens/addOrEditAlarm/utils/parseAlarm.dart';
import 'package:frontend/services/api/alarms.dart' as AlarmHttp;
import 'package:frontend/widgets/alert/info.dart';
import 'package:frontend/Mixins/arrayToString.dart';
import 'package:frontend/utils/parseDays.dart';
import 'package:frontend/Mixins/loadingDialog.dart';

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

  alert(BuildContext context, String messageError) {
    alertInfo(
      context: context,
      title: "Error",
      description: messageError,
    );
  }

  saveOrEditAlarm(context, Map alarm, _keyLoader) async {
    showLoadingDialog(context, _keyLoader);
    Map newAlarm = parseAlarm(alarm);
    Map res = {};
    if (alarm["isEdit"] == null) {
      res = await AlarmHttp.add(newAlarm);
    } else {
      res = await AlarmHttp.update(newAlarm, alarm["_id"]);
    }
    if (res["error"] != null) {
      hiddenLoadingDialog(_keyLoader);
      alert(context, res["error"]);
      return;
    }
    newAlarm["alarm_days"] = parseDays.daysDecode(newAlarm["alarm_days"]);
    newAlarm["_id"] = res["id"];
    hiddenLoadingDialog(_keyLoader);
    Navigator.pop(context, newAlarm);
  }
}
