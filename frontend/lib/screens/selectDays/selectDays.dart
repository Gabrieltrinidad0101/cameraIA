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
    {"name": "Domigo", "status": false},
    {"name": "Lunes", "status": false},
    {"name": "Marte", "status": false},
    {"name": "Miércoles", "status": false},
    {"name": "Jueve", "status": false},
    {"name": "Viernes", "status": false},
    {"name": "Sábado", "status": false},
  ];

  SelectDaysController selectDaysController = SelectDaysController();

  @override
  void didChangeDependencies() {
    var arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments == null) return;
    List selectDays = arguments as List;
    ListOfDay = selectDaysController.getSelectedDays(ListOfDay, selectDays);
    super.didChangeDependencies();
  }

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
                selectDaysController.goToBack(context, ListOfDay);
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
            title: Text(ListOfDay[index]["name"]),
            trailing: Checkbox(
              value: ListOfDay[index]["status"],
              onChanged: (value) {
                setState(
                  () {
                    ListOfDay[index]["status"] = value;
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
