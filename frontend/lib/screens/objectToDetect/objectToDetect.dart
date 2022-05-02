import 'package:flutter/material.dart';
import './objectToDetectController.dart';
import './listOfObjectToDetect.dart';

class ObjectToDetect extends StatelessWidget {
  ObjectToDetectController objectToDetectController =
      ObjectToDetectController();
  ObjectToDetect({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(listOfObjectToDetect);
    return Scaffold(
        appBar: AppBar(
          title: Text("OBJECTOS A DETECTAR"),
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () => objectToDetectController.goToBack(context),
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
          itemCount: listOfObjectToDetect.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(listOfObjectToDetect[index]),
              trailing: Checkbox(value: false, onChanged: (value) {}),
            );
          },
        ));
  }
}
