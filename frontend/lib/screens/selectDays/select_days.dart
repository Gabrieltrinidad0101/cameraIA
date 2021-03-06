import 'package:flutter/material.dart';
import 'package:frontend/screens/selectDays/select_days_controller.dart';
import 'package:frontend/screens/selectDays/utils/get_days.dart';
import 'package:frontend/widgets/text/text_language.dart';

class SelectDays extends StatefulWidget {
  const SelectDays({Key? key}) : super(key: key);

  @override
  State<SelectDays> createState() => _SelectDaysState();
}

class _SelectDaysState extends State<SelectDays> {
  Map makeDay(day, bool status) => {"day": day, "status": status};

  List<Map> alarmDays = listOfDays();

  SelectDaysController selectDaysController = SelectDaysController();

  @override
  void didChangeDependencies() {
    alarmDays =
        selectDaysController.getSelectedDaysOfArguments(context, alarmDays);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return appMain(context);
  }

  Scaffold appMain(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextLanguage("dayAlarms"),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => selectDaysController.goToBack(context),
        ),
        actions: [
          FractionallySizedBox(
            heightFactor: 0.7,
            child: ElevatedButton(
              onPressed: () {
                selectDaysController.goToBack(context, alarmDays);
              },
              child: TextLanguage("save"),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.orangeAccent),
              ),
            ),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: alarmDays.length,
        itemBuilder: (context, index) {
          return InkWell(
            child: ListTile(
              title: Text(alarmDays[index]["name"]),
              trailing: Checkbox(
                value: alarmDays[index]["status"],
                onChanged: (value) {
                  setState(
                    () {
                      alarmDays[index]["status"] = value;
                    },
                  );
                },
              ),
            ),
            onTap: () {
              setState(
                () {
                  alarmDays[index]["status"] = !alarmDays[index]["status"];
                },
              );
            },
          );
        },
      ),
    );
  }
}
