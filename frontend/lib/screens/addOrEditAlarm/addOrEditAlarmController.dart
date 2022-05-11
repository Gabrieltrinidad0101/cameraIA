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

  Map? getArguments(context) {
    var arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments == null) return null;
    Map data = arguments as Map;

    String title = data["title"];

    Map _alarm = data["alarm"];
    TimeOfDay startAlarm = TimeOfDay(
      hour: _alarm["time"]["start_alarm"]["hour"],
      minute: _alarm["time"]["start_alarm"]["minute"],
    );
    TimeOfDay endAlarm = TimeOfDay(
      hour: _alarm["time"]["end_alarm"]["hour"],
      minute: _alarm["time"]["end_alarm"]["minute"],
    );
    Map alarm = {
      "startAlarm": startAlarm,
      "endAlarm": endAlarm,
      "alarmDays": _alarm["alarm_days"],
      "isEdit": true,
      "_id": _alarm["_id"].toString(),
      "objects": _alarm["objects"]
    };
    return {"alarm": alarm, "title": title};
  }

  saveOrEditAlarm(context, Map? alarm, _keyLoader) async {
    showLoadingDialog(context, _keyLoader);

    if (alarm?["startAlarm"] == null ||
        alarm?["endAlarm"] == null ||
        alarm?["alarmDays"].isEmpty) {
      return alertInfo(
          context: context,
          title: "Error",
          description: "Es necesario que agrege tiempo de inicio y final");
    }

    Map newAlarm = parseAlarm(
        startAlarm: alarm?["startAlarm"],
        endAlarm: alarm?["endAlarm"],
        alarmDays: alarm?["alarmDays"],
        alarmObjects: alarm?["objects"]);
    String id = "";
    if (alarm?["isEdit"] == null) {
      Map data = await AlarmHttp.add(newAlarm);
      id = data["_id"][r"$oid"].toString();
    } else {
      await AlarmHttp.update(newAlarm, alarm?["_id"]);
      id = alarm?["_id"];
    }
    newAlarm["alarm_days"] = parseDays.daysDecode(newAlarm["alarm_days"]);
    newAlarm["_id"] = id;
    hiddenLoadingDialog(_keyLoader);
    Navigator.pop(context, newAlarm);
  }
}
