import 'package:flutter/material.dart';
import 'package:frontend/screens/selectDays/selectDaysController.dart';

class SelectDays extends StatelessWidget {
  List<String> ListOfDay = [
    "Domingo",
    "Lunes",
    "Marte",
    "miércoles,",
    "Jueve",
    "Viernes",
    "Sábado",
  ];
  SelectDaysController selectDaysController = SelectDaysController();
  SelectDays({Key? key}) : super(key: key);
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
                  // Add your onPressed code here!
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
              title: Text(ListOfDay[index]),
              trailing: Checkbox(value: false, onChanged: (value) {}),
            );
          },
        ));
  }
}
