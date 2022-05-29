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
  AddOrEditAlarmController addOrEditAlarmController =
      AddOrEditAlarmController();
  Map alarm = {
    "time": {
      "start_alarm": {"hour": 18, "minute": 15},
      "end_alarm": {"hour": 7, "minute": 45}
    },
    "alarm_days": [
      "Domigo",
      "Lunes",
      "Marte",
      "Miércoles",
      "Jueve",
      "Viernes",
      "Sábado",
    ],
    "objects": ["person"],
    "status": true
  };
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
                  alarm["startAlarm"], context),
              onPressed: () async {
                TimeOfDay? t = await addOrEditAlarmController.clock(
                    alarm["startAlarm"], context);
                setState(() {
                  alarm["startAlarm"] = t;
                });
              }),
          TimeButton(
              name: "Termina la alarma",
              time: addOrEditAlarmController.processTime(
                  alarm["endAlarm"], context),
              onPressed: () async {
                TimeOfDay? t = await addOrEditAlarmController.clock(
                    alarm["endAlarm"], context);
                setState(() {
                  alarm["endAlarm"] = t;
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
                  addOrEditAlarmController.arrayToString(alarm["alarmDays"])),
            ),
            onTap: () async {
              List<String> _alarmDays = await routerController.goToSelectDays(
                  context, alarm["alarmDays"]);
              if (_alarmDays.isEmpty) return;
              setState(() {
                alarm["alarmDays"] = _alarmDays;
              });
            },
          ),
          InkWell(
              child: ListTile(
                title: Text("OBJECTOS A DETECTAR"),
                subtitle: Text(
                    addOrEditAlarmController.arrayToString(alarm["objects"])),
              ),
              onTap: () async {
                List selectedObjects = await routerController
                    .goToObjectToDetect(context, alarm["objects"]);
                print("get objects = $selectedObjects");
                if (selectedObjects.isEmpty) return;
                setState(() {
                  alarm["objects"] = selectedObjects;
                });
              })
        ],
      ),
    );
  }
}
