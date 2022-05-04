import 'package:flutter/material.dart';
import 'package:frontend/screens/selectDays/selectDaysController.dart';

class SelectDays extends StatefulWidget {
  SelectDays({Key? key}) : super(key: key);

  @override
  State<SelectDays> createState() => _SelectDaysState();
}

class _SelectDaysState extends State<SelectDays> {
  Map makeDay(day, bool status) => {"day": day, "status": status};

  List<Map> ListOfDay = [
    {"day": "Domigo", "status": false},
    {"day": "Lunes", "status": false},
    {"day": "Marte", "status": false},
    {"day": "miércoles", "status": false},
    {"day": "Jueve", "status": false},
    {"day": "Viernes", "status": false},
    {"day": "Sábado", "status": false},
  ];

  SelectDaysController selectDaysController = SelectDaysController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("DIAS DE ALARMAS"),
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () => selectDaysController.goToBack(context),
          ),
          actions: [
            FractionallySizedBox(
              heightFactor: 0.7,
              child: ElevatedButton(
                onPressed: () {
                  selectDaysController.gotToAddOrEditAlarm(context, ListOfDay);
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
        body: ListView.builder(
          itemCount: ListOfDay.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(ListOfDay[index]["day"]),
              trailing: Checkbox(
                  value: ListOfDay[index]["status"],
                  onChanged: (value) {
                    setState(() {
                      ListOfDay[index]["status"] = value;
                    });
                  }),
            );
          },
        ));
  }
}
