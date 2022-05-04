import 'package:flutter/material.dart';
import 'package:frontend/screens/addOrEditAlarm/addOrEditAlarmController.dart';
import 'package:frontend/widgets/buttons/timeButton.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

class Clock extends StatefulWidget {
  const Clock({Key? key}) : super(key: key);

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  DateTime _dateTime = DateTime.now();
  AddOrEditAlarmController addOrEditAlarmController =
      AddOrEditAlarmController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hora de inicio")),
      body: Center(
        child: Column(
          children: [
            TimePicker(),
            Text(
                _dateTime.hour.toString().padLeft(2, '0') +
                    ':' +
                    _dateTime.minute.toString().padLeft(2, '0'),
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }

  Widget TimePicker() {
    return TimePickerSpinner(
      is24HourMode: false,
      normalTextStyle: TextStyle(fontSize: 24),
      highlightedTextStyle: TextStyle(fontSize: 24),
      spacing: 50,
      itemHeight: 80,
      isForce2Digits: true,
      onTimeChange: (time) {
        setState(() {
          _dateTime = time;
        });
      },
    );
  }
}
