import 'package:flutter/material.dart' show Navigator;
import 'package:frontend/widgets/alert/info.dart';
import 'package:frontend/widgets/alert/warningDeleteAlarm.dart';
import 'utils/ParserAlarm.dart';
import 'package:frontend/Mixins/arrayToString.dart';
import 'package:frontend/utils/parseDays.dart';
import 'utils/format12Hour.dart';
import 'package:frontend/services/api/alarms.dart' as AlarmHttp;
import 'package:frontend/Mixins/loadingDialog.dart';

class AlarmsControllers with ArrayToString, LoadingDialog {
  ParseDays parseDays = ParseDays();
  List? alarms;

  Future<List?> getAlarms(context) async {
    Map<String, dynamic> getAlarms = await AlarmHttp.get();
    if (getAlarms["error"] != null) {
      alertInfo(
        context: context,
        title: "Error",
        description: getAlarms["error"],
      );
      return null;
    }
    return fromJson(getAlarms["data"]);
  }

  updateAlarm(context, _keyLoader, int index) async {
    Map alarm = {...alarms?[index]};
    showLoadingDialog(context, _keyLoader);
    alarm["alarm_days"] = parseDays.daysEncode(alarm["alarm_days"]);
    await AlarmHttp.update(alarm, alarm["_id"]);
    hiddenLoadingDialog(_keyLoader);
  }

  List fromJson(alarms) {
    ParserAlarm parserAlarm = ParserAlarm();
    return parserAlarm.fromJson(alarms);
  }

  String getTitle(index) {
    int startHour = alarms?[index]["time"]["start_alarm"]["hour"];
    int startMinute = alarms?[index]["time"]["start_alarm"]["minute"];

    int endHour = alarms?[index]["time"]["end_alarm"]["hour"];
    int endMinute = alarms?[index]["time"]["end_alarm"]["minute"];
    return "${Format12Hour(startHour, startMinute)} / ${Format12Hour(endHour, endMinute)}";
  }

  String getDays(index) {
    List alarmDays = alarms?[index]["alarm_days"];
    return arrayToString(alarmDays);
  }

  double getMargin(index) {
    return index != (alarms?.length ?? 0) - 1 ? 5 : 80;
  }

  Future<Map?> gotToEditAlarm(context, index) async {
    var data =
        await Navigator.pushNamed(context, "/addOrEditAlarm", arguments: {
      "title": "Edit Alarm",
      "alarm": alarms?[index],
    });
    return data == null ? null : data as Map;
  }

  Future<Map?> gotToAddAlarm(context) async {
    var newAlarm = await Navigator.pushNamed(context, "/addOrEditAlarm");
    print(newAlarm);
    return newAlarm == null ? null : newAlarm as Map;
  }

  Future<void> deleteAlarm(context, int index, Function callBack) async {
    await alertWarning(
        context: context,
        title: "Elimar",
        description: "Deseas eliminar esta alarma",
        callBack: () async {
          await AlarmHttp.delete(alarms?[index]["_id"]);
          alarms?.removeAt(index);
          callBack(alarms);
        });
  }
}
