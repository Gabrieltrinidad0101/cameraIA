import 'package:flutter/material.dart';

class Alarms extends StatefulWidget {
  const Alarms({Key? key}) : super(key: key);

  @override
  State<Alarms> createState() => _AlarmsState();
}

class _AlarmsState extends State<Alarms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Alarms")),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: ListView.builder(
          itemCount: 13,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(bottom: getMargin(index)),
              child: Card(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 23),
                  child: ListTile(
                    title: Text(
                      "6:15 PM / 7:45 AM",
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
        ),
      ),
      floatingActionButton: SizedBox(
        child: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  double getMargin(index) {
    return index != 12 ? 5 : 90;
  }
}
