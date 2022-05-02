import 'package:flutter/material.dart';
import 'package:frontend/screens/alarms/alarmsControllers.dart';
import 'package:frontend/services/api/alarms.dart' as AlarmHttp;

class Alarms extends StatefulWidget {
  const Alarms({Key? key}) : super(key: key);

  @override
  State<Alarms> createState() => _AlarmsState();
}

class _AlarmsState extends State<Alarms> {
  AlarmsControllers? alarmsControllers;
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Alarms")),
      body: Container(child: Main()),
      floatingActionButton: SizedBox(
        child: FloatingActionButton(
          onPressed: () {
            alarmsControllers?.gotToAddOrEditAlarm(context);
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
        alarmsControllers = AlarmsControllers(alarms: snapshot.data);
        return ListAlarm();
      },
    );
  }

  Widget Loader() {
    return Center(child: CircularProgressIndicator());
  }

  ListView ListAlarm() {
    return ListView.builder(
      itemCount:
          alarmsControllers != null ? alarmsControllers?.alarms.length : 0,
      itemBuilder: (context, index) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: alarmsControllers?.getMargin(index) ?? 0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 23),
              child: ListTile(
                title: Text(
                  "${alarmsControllers?.parseTitle(index)}",
                  style: TextStyle(fontSize: 23),
                ),
                subtitle: Text("Lun Martes Vierne"),
                trailing: Switch(
                  value: true,
                  onChanged: (value) {},
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
