import 'package:flutter/material.dart';
import 'package:frontend/screens/alarms/alarmsControllers.dart';
import 'package:frontend/services/api/alarms.dart' as AlarmHttp;

class Alarms extends StatefulWidget {
  const Alarms({Key? key}) : super(key: key);

  @override
  State<Alarms> createState() => _AlarmsState();
}

class _AlarmsState extends State<Alarms> {
  AlarmsControllers alarmsControllers = AlarmsControllers();
  List alarms = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Alarms")),
      body: Container(child: Main()),
      floatingActionButton: SizedBox(
        child: FloatingActionButton(
          onPressed: () {
            alarmsControllers.gotToAddOrEditAlarm(context);
          },
          child: Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget Main() {
    return FutureBuilder(
      future: AlarmHttp.get(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Loader();
        }
        alarms = alarmsControllers.fromJson(alarms: snapshot.data);
        return ListAlarm();
      },
    );
  }

  Widget Loader() {
    return Center(child: CircularProgressIndicator());
  }

  ListView ListAlarm() {
    print(alarms);
    return ListView.builder(
      itemCount: alarms.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(
              bottom: alarmsControllers.getMargin(index, alarms)),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 23),
              child: InkWell(
                onLongPress: (() {
                  List newAlarms = alarmsControllers.deleteAlarm(index, alarms);
                  setState(() {
                    alarms = ["123", "123", "123"];
                  });
                }),
                child: ListTile(
                  title: Text(
                    "${alarmsControllers.getTitle(alarms[index])}",
                    style: TextStyle(fontSize: 23),
                  ),
                  subtitle: Text(alarmsControllers.getDays(alarms[index])),
                  trailing: Switch(
                    value: true,
                    onChanged: (value) {},
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
