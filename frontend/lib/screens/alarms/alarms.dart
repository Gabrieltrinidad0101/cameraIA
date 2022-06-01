import 'package:flutter/material.dart';
import 'package:frontend/screens/alarms/alarmsControllers.dart';
import 'package:frontend/widgets/modals/loadingDialog.dart';

class Alarms extends StatefulWidget {
  const Alarms({Key? key}) : super(key: key);

  @override
  State<Alarms> createState() => _AlarmsState();
}

class _AlarmsState extends State<Alarms> {
  AlarmsControllers alarmsControllers = AlarmsControllers();
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  bool isLoader = true;
  @override
  void initState() {
    super.initState();
    alarmsControllers.getAlarms(context).then((alarms) {
      setState(() {
        alarmsControllers.alarms = alarms;
        isLoader = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Alarmas")),
      body: Container(child: main()),
      floatingActionButton: SizedBox(
        child: FloatingActionButton(
          onPressed: () async {
            Map? newAlarm = await alarmsControllers.gotToAddAlarm(context);
            if (newAlarm == null) return;
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

  Widget main() {
    return isLoader
        ? Loader()
        : alarmsControllers.alarms != null
            ? ListAlarm()
            : Container();
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
                  Map? editedAlarm =
                      await alarmsControllers.gotToEditAlarm(context, index);
                  if (editedAlarm == null) return;
                  setState(() {
                    alarmsControllers.alarms?[index] = editedAlarm;
                  });
                },
                onLongPress: () async => await deleteAlarm(context, index),
                child: ListTile(
                  title: Text(
                    alarmsControllers.getTitle(index),
                    style: TextStyle(fontSize: 21),
                  ),
                  subtitle: Text(alarmsControllers.getDays(index)),
                  trailing: Switch(
                    value: alarmsControllers.alarms?[index]["status"],
                    onChanged: (value) async {
                      bool isNotUpdate = await alarmsControllers.updateAlarm(
                          context, _keyLoader, index);
                      if (isNotUpdate) return;
                      setState(() {
                        alarmsControllers.alarms?[index]["status"] = value;
                      });
                    },
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
    await alarmsControllers.deleteAlarm(context, index, _keyLoader,
        (newAlarms) {
      setState(() {
        alarmsControllers.alarms = newAlarms;
      });
    });
  }
}
