import 'package:flutter/material.dart';
import 'package:frontend/screens/alarms/alarmsControllers.dart';

class Alarms extends StatefulWidget {
  const Alarms({Key? key}) : super(key: key);

  @override
  State<Alarms> createState() => _AlarmsState();
}

class _AlarmsState extends State<Alarms> {
  AlarmsControllers alarmsControllers = AlarmsControllers();

  @override
  void initState() {
    super.initState();
    alarmsControllers.getAlarms().then((alarms) {
      setState(() {
        alarmsControllers.alarms = alarms;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Alarms")),
      body: Container(child: Main()),
      floatingActionButton: SizedBox(
        child: FloatingActionButton(
          onPressed: () async {
            Map newAlarm = await alarmsControllers.gotToAddAlarm(context);
            setState(() {
              alarmsControllers.alarms?.add(newAlarm);
            });
          },
          child: Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget Main() {
    return alarmsControllers.alarms == null ? Loader() : ListAlarm();
  }

  Widget Loader() {
    return Center(child: CircularProgressIndicator());
  }

  ListView ListAlarm() {
    return ListView.builder(
      itemCount: alarmsControllers.alarms?.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: alarmsControllers.getMargin(index)),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 23),
              child: InkWell(
                onTap: () async {
                  Map editedAlarm =
                      await alarmsControllers.gotToEditAlarm(context, index);
                  setState(() {
                    alarmsControllers.alarms?[index] = editedAlarm;
                  });
                },
                onLongPress: () async => await deleteAlarm(context, index),
                child: ListTile(
                  title: Text(
                    alarmsControllers.getTitle(index),
                    style: TextStyle(fontSize: 23),
                  ),
                  subtitle: Text(alarmsControllers.getDays(index)),
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

  deleteAlarm(BuildContext context, index) async {
    List? newAlarms =
        await alarmsControllers.deleteAlarm(context, index, (newAlarms) {
      setState(() {
        alarmsControllers.alarms = newAlarms;
      });
    });
  }
}
