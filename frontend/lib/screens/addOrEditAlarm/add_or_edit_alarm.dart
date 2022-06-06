import 'package:flutter/material.dart';
import 'package:frontend/screens/addOrEditAlarm/add_or_edit_alarm_controller.dart';
import 'package:frontend/screens/addOrEditAlarm/router_controller.dart';
import 'package:frontend/screens/addOrEditAlarm/utils/default_alarm.dart';
import 'package:frontend/widgets/buttons/time_button.dart';

import 'package:frontend/languages/laguages.dart';

class AddOrEditAlarm extends StatefulWidget {
  const AddOrEditAlarm({Key? key}) : super(key: key);

  @override
  State<AddOrEditAlarm> createState() => _AddOrEditAlarmState();
}

class _AddOrEditAlarmState extends State<AddOrEditAlarm> {
  String title = "Agregar Alarma";
  AddOrEditAlarmController addOrEditAlarmController =
      AddOrEditAlarmController();
  Languages languages = Languages();
  Map alarm = defaultAlarm();
  RouterController routerController = RouterController();
  final GlobalKey<State> _keyLoader = GlobalKey<State>();

  @override
  void didChangeDependencies() {
    if (alarm["time"]?["start_alarm"] == null) return;
    alarm = addOrEditAlarmController.processAlarmData(alarm);
    Map? data = addOrEditAlarmController.getArguments(context);
    title = data?["title"] ?? title;
    alarm = data?["alarm"] ?? alarm;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return appMain(context);
  }

  Scaffold appMain(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          FractionallySizedBox(
            heightFactor: 0.7,
            child: ElevatedButton(
              onPressed: () async {
                addOrEditAlarmController.saveOrEditAlarm(
                    context, alarm, _keyLoader);
              },
              child: const Text("Guardar"),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.orangeAccent),
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          timeButton(
              name: languages.get("startAlarm"),
              time: addOrEditAlarmController.processTime(
                  alarm["startAlarm"], context),
              onPressed: () async {
                setTimeInTimeButton("startAlarm");
              }),
          timeButton(
              name: languages.get("endAlarm"),
              time: addOrEditAlarmController.processTime(
                  alarm["endAlarm"], context),
              onPressed: () async {
                setTimeInTimeButton("endAlarm");
              }),
          options()
        ],
      ),
    );
  }

  Expanded options() {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          InkWell(
            child: ListTile(
              title: Text(languages.get("alarmOfDays")),
              subtitle: Text(
                  addOrEditAlarmController.arrayToString(alarm["alarmDays"])),
            ),
            onTap: () {
              setDaysInAlarmDays();
            },
          ),
          InkWell(
              child: ListTile(
                title: Text(languages.get("objectToDetectText")),
                subtitle: Text(
                    addOrEditAlarmController.arrayToString(alarm["objects"])),
              ),
              onTap: () {
                setObjectsInObjectsToDetect();
              })
        ],
      ),
    );
  }

  setTimeInTimeButton(startOrEndAlarm) async {
    TimeOfDay? t =
        await addOrEditAlarmController.clock(alarm[startOrEndAlarm], context);
    if (t == null) return;
    setState(() {
      alarm[startOrEndAlarm] = t;
    });
  }

  setDaysInAlarmDays() async {
    List<String> _alarmDays =
        await routerController.goToSelectDays(context, alarm["alarmDays"]);
    if (_alarmDays.isEmpty) return;
    setState(() {
      alarm["alarmDays"] = _alarmDays;
    });
  }

  setObjectsInObjectsToDetect() async {
    List selectedObjects =
        await routerController.goToObjectToDetect(context, alarm["objects"]);
    if (selectedObjects.isEmpty) return;
    setState(() {
      alarm["objects"] = selectedObjects;
    });
  }
}
