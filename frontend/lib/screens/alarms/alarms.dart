import 'package:flutter/material.dart';
import 'package:frontend/screens/alarms/alarms_controllers.dart';

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
      appBar: AppBar(title: const Text("Alarmas")),
      body: Container(child: main()),
      floatingActionButton: SizedBox(
        child: FloatingActionButton(
          onPressed: addAlarm,
          child: const Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget main() {
    return isLoader
        ? loader()
        : alarmsControllers.alarms != null
            ? listAlarm()
            : Container();
  }

  Widget loader() {
    return const Center(child: CircularProgressIndicator());
  }

  ListView listAlarm() {
    return ListView.builder(
      itemCount: alarmsControllers.alarms?.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: alarmsControllers.getMargin(index)),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 23),
              child: InkWell(
                onTap: () => editAlarm(index),
                onLongPress: () async => await deleteAlarm(context, index),
                child: ListTile(
                  title: Text(
                    alarmsControllers.getTitle(index),
                    style: const TextStyle(fontSize: 21),
                  ),
                  subtitle: Text(alarmsControllers.getDays(index)),
                  trailing: Switch(
                    value: alarmsControllers.alarms?[index]["status"],
                    onChanged: (value) => changeAlarmState(value, index),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  addAlarm() async {
    Map? newAlarm = await alarmsControllers.gotToAddAlarm(context);
    if (newAlarm == null) return;
    setState(() {
      alarmsControllers.alarms?.add(newAlarm);
    });
  }

  changeAlarmState(bool value, int index) async {
    bool isNotUpdate =
        await alarmsControllers.updateAlarm(context, _keyLoader, index);
    if (isNotUpdate) return;
    setState(() {
      alarmsControllers.alarms?[index]["status"] = value;
    });
  }

  editAlarm(int index) async {
    Map? editedAlarm = await alarmsControllers.gotToEditAlarm(context, index);
    if (editedAlarm == null) return;
    setState(() {
      alarmsControllers.alarms?[index] = editedAlarm;
    });
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
