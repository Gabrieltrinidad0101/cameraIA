import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:frontend/screens/addOrEditAlarm/addOrEditAlarmController.dart';
import 'package:frontend/widgets/buttons/timeButton.dart';

class AddOrEditAlarm extends StatefulWidget {
  const AddOrEditAlarm({Key? key}) : super(key: key);

  @override
  State<AddOrEditAlarm> createState() => _AddOrEditAlarmState();
}

class _AddOrEditAlarmState extends State<AddOrEditAlarm> {
  String appBarTitle = "Agregar Alarma";
  AddOrEditAlarmController addOrEditAlarmController =
      AddOrEditAlarmController();
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
              time: "10:30 MP",
              onPressed: () {
                _showDialog();
              }),
          TimeButton(
              name: "Termina la alarma", time: "10:34 MP", onPressed: () {}),
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

  void _showDialog() {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      transitionDuration: Duration(milliseconds: 2000),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            child: child,
          ),
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.all(20),
            color: Colors.white,
            child: Center(
              child:Column(
                 mainAxisSize: MainAxisSize.min,
              children:<Widget> [
                Text('Hai This Is Full Screen Dialog', style: TextStyle(color: Colors.red, fontSize: 20.0),),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("DISMISS",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
            ),
          ),
        );
      },
    );
  }
  }

  Padding CardClock() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 12,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Hora de inicio",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Clock(),
            ],
          ),
        ),
      ),
    );
  }

  Widget Clock() {
    return TimePickerSpinner(
      is24HourMode: false,
      normalTextStyle: TextStyle(fontSize: 24),
      highlightedTextStyle: TextStyle(fontSize: 24),
      spacing: 50,
      itemHeight: 80,
      isForce2Digits: true,
      onTimeChange: (time) {
        setState(() {});
      },
    );
  }
}
