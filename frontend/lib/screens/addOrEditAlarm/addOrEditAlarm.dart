import 'package:flutter/material.dart';
import 'package:frontend/screens/addOrEditAlarm/addOrEditAlarmController.dart';
import 'package:frontend/widgets/buttons/timeButton.dart';

class AddOrEditAlarm extends StatefulWidget {
  const AddOrEditAlarm({Key? key}) : super(key: key);

  @override
  State<AddOrEditAlarm> createState() => _AddOrEditAlarmState();
}

class _AddOrEditAlarmState extends State<AddOrEditAlarm> {
  String appBarTitle = "Agregar Alarma";
  TimeOfDay? timeStart;
  TimeOfDay? timeEnd;
  List<String> alarmDays = [];
  AddOrEditAlarmController addOrEditAlarmController =
      AddOrEditAlarmController();
  DateTime _dateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        actions: [
          FractionallySizedBox(
            heightFactor: 0.7,
            child: ElevatedButton(
              onPressed: () async {
                await addOrEditAlarmController.saveAlarm(
                    context, timeStart, timeEnd, alarmDays);
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
              time: addOrEditAlarmController.processTime(timeStart, context),
              onPressed: () async {
                TimeOfDay? t =
                    await addOrEditAlarmController.clock(timeStart, context);
                setState(() {
                  timeStart = t;
                });
              }),
          TimeButton(
              name: "Termina la alarma",
              time: addOrEditAlarmController.processTime(timeEnd, context),
              onPressed: () async {
                TimeOfDay? t =
                    await addOrEditAlarmController.clock(timeEnd, context);
                setState(() {
                  timeEnd = t;
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
              subtitle: Text(addOrEditAlarmController.arrayToString(alarmDays)),
            ),
            onTap: () async {
              List<String>? _alarmDays = await addOrEditAlarmController
                  .goToSelectDays(context, alarmDays);
              if (_alarmDays != null) {
                setState(() {
                  alarmDays = _alarmDays;
                });
              }
            },
          ),
          InkWell(
              child: ListTile(
                title: Text("OBJECTOS A DETECTAR"),
                subtitle: Text("Persona"),
              ),
              onTap: () {
                addOrEditAlarmController.goToObjectToDetect(context);
              })
        ],
      ),
    );
  }
}
