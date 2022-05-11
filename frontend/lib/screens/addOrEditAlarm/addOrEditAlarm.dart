import 'package:flutter/material.dart';
import 'package:frontend/screens/addOrEditAlarm/addOrEditAlarmController.dart';
import 'package:frontend/screens/addOrEditAlarm/routerController.dart';
import 'package:frontend/widgets/buttons/timeButton.dart';

class AddOrEditAlarm extends StatefulWidget {
  const AddOrEditAlarm({Key? key}) : super(key: key);

  @override
  State<AddOrEditAlarm> createState() => _AddOrEditAlarmState();
}

class _AddOrEditAlarmState extends State<AddOrEditAlarm> {
  String title = "Agregar Alarma";
  Map? alarm = {};
  AddOrEditAlarmController addOrEditAlarmController =
      AddOrEditAlarmController();
  RouterController routerController = RouterController();
  DateTime _dateTime = DateTime.now();

  @override
  void didChangeDependencies() {
    Map? data = addOrEditAlarmController.getArguments(context);
    title = data?["title"] ?? title;
    alarm = data?["alarm"] ?? {};
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          FractionallySizedBox(
            heightFactor: 0.7,
            child: ElevatedButton(
              onPressed: () async {
                await addOrEditAlarmController.saveOrEditAlarm(context, alarm);
              },
              child: Text("Guardar"),
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
          TimeButton(
              name: "Comienza la alarma",
              time: addOrEditAlarmController.processTime(
                  alarm?["startAlarm"], context),
              onPressed: () async {
                TimeOfDay? t = await addOrEditAlarmController.clock(
                    alarm?["startAlarm"], context);
                setState(() {
                  alarm?["startAlarm"] = t;
                });
              }),
          TimeButton(
              name: "Termina la alarma",
              time: addOrEditAlarmController.processTime(
                  alarm?["endAlarm"], context),
              onPressed: () async {
                TimeOfDay? t = await addOrEditAlarmController.clock(
                    alarm?["endAlarm"], context);
                setState(() {
                  alarm?["endAlarm"] = t;
                });
              }),
          Options()
        ],
      ),
    );
  }

  Expanded Options() {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          InkWell(
            child: ListTile(
              title: Text("DIAS DE ALARMAS"),
              subtitle: Text(
                  addOrEditAlarmController.arrayToString(alarm?["alarmDays"])),
            ),
            onTap: () async {
              List<String> _alarmDays = await routerController.goToSelectDays(
                  context, alarm?["alarmDays"]);
              if (_alarmDays.isEmpty) return;
              setState(() {
                alarm?["alarmDays"] = _alarmDays;
              });
            },
          ),
          InkWell(
              child: ListTile(
                title: Text("OBJECTOS A DETECTAR"),
                subtitle: Text(
                    addOrEditAlarmController.arrayToString(alarm?["objects"])),
              ),
              onTap: () async {
                List selectedObjects = await routerController
                    .goToObjectToDetect(context, alarm?["objects"]);
                if (selectedObjects.isEmpty) return;
                setState(() {
                  alarm?["objects"] = selectedObjects;
                });
              })
        ],
      ),
    );
  }
}
