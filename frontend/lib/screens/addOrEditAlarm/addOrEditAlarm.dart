import 'package:flutter/material.dart';
import 'package:frontend/screens/addOrEditAlarm/addOrEditAlarmController.dart';
import 'package:frontend/widgets/buttons/timeButton.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

class AddOrEditAlarm extends StatefulWidget {
  const AddOrEditAlarm({Key? key}) : super(key: key);

  @override
  State<AddOrEditAlarm> createState() => _AddOrEditAlarmState();
}

class _AddOrEditAlarmState extends State<AddOrEditAlarm> {
  String appBarTitle = "Agregar Alarma";
  TimeOfDay? timeStart;
  TimeOfDay? timeEnd;
  AddOrEditAlarmController addOrEditAlarmController =
      AddOrEditAlarmController();
  DateTime _dateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
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
            child: const ListTile(
              title: Text("DIAS DE ALARMAS"),
              subtitle: Text("Lun. Mar. Mie."),
            ),
            onTap: () {
              addOrEditAlarmController.goToSelectDays(context);
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
