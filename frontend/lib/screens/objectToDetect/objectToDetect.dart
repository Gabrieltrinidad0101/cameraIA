import 'package:flutter/material.dart';
import './objectToDetectController.dart';
// import './listOfObjectToDetect.dart' show getListOfObjectToDetect;

class ObjectToDetect extends StatefulWidget {
  ObjectToDetect({Key? key}) : super(key: key);

  @override
  State<ObjectToDetect> createState() => _ObjectToDetectState();
}

class _ObjectToDetectState extends State<ObjectToDetect> {
  ObjectToDetectController objectToDetectController =
      ObjectToDetectController();
  final searchController = TextEditingController();
  List searchResult = [];
  List listOfObjectToDetect = [
    {"name": "person", "status": false},
    {"name": "bicycle", "status": false},
    {"name": "car", "status": false},
    {"name": "motorbike", "status": false},
    {"name": "aeroplane", "status": false},
    {"name": "bus", "status": false},
    {"name": "train", "status": false},
    {"name": "truck", "status": false},
    {"name": "boat", "status": false},
    {"name": "traffic light", "status": false},
    {"name": "fire hydrant", "status": false},
    {"name": "stop sign", "status": false},
    {"name": "parking meter", "status": false},
    {"name": "bench", "status": false},
    {"name": "bird", "status": false},
    {"name": "cat", "status": false},
    {"name": "dog", "status": false},
    {"name": "horse", "status": false},
    {"name": "sheep", "status": false},
    {"name": "cow", "status": false},
    {"name": "elephant", "status": false},
    {"name": "bear", "status": false},
    {"name": "zebra", "status": false},
    {"name": "giraffe", "status": false},
    {"name": "backpack", "status": false},
    {"name": "umbrella", "status": false},
    {"name": "handbag", "status": false},
    {"name": "tie", "status": false},
    {"name": "suitcase", "status": false},
    {"name": "frisbee", "status": false},
    {"name": "skis", "status": false},
    {"name": "snowboard", "status": false},
    {"name": "sports ball", "status": false},
    {"name": "kite", "status": false},
    {"name": "baseball bat", "status": false},
    {"name": "baseball glove", "status": false},
    {"name": "skateboard", "status": false},
    {"name": "surfboard", "status": false},
    {"name": "tennis racket", "status": false},
    {"name": "bottle", "status": false},
    {"name": "wine glass", "status": false},
    {"name": "cup", "status": false},
    {"name": "fork", "status": false},
    {"name": "knife", "status": false},
    {"name": "spoon", "status": false},
    {"name": "bowl", "status": false},
    {"name": "banana", "status": false},
    {"name": "apple", "status": false},
    {"name": "sandwich", "status": false},
    {"name": "orange", "status": false},
    {"name": "broccoli", "status": false},
    {"name": "carrot", "status": false},
    {"name": "hot dog", "status": false},
    {"name": "pizza", "status": false},
    {"name": "donut", "status": false},
    {"name": "cake", "status": false},
    {"name": "chair", "status": false},
    {"name": "sofa", "status": false},
    {"name": "pottedplant", "status": false},
    {"name": "bed", "status": false},
    {"name": "diningtable", "status": false},
    {"name": "toilet", "status": false},
    {"name": "tvmonitor", "status": false},
    {"name": "laptop", "status": false},
    {"name": "mouse", "status": false},
    {"name": "remote", "status": false},
    {"name": "keyboard", "status": false},
    {"name": "cell phone", "status": false},
    {"name": "microwave", "status": false},
    {"name": "oven", "status": false},
    {"name": "toaster", "status": false},
    {"name": "sink", "status": false},
    {"name": "refrigerator", "status": false},
    {"name": "book", "status": false},
    {"name": "clock", "status": false},
    {"name": "vase", "status": false},
    {"name": "scissors", "status": false},
    {"name": "teddy bear", "status": false},
    {"name": "hair drier", "status": false},
    {"name": "toothbrush", "status": false},
  ];

  @override
  Widget build(BuildContext context) {
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
                objectToDetectController.goToBack(
                    context, listOfObjectToDetect);
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
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      hintText: 'Enter a message',
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.search),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchResult.clear();
                        searchResult = objectToDetectController
                            .searchObjectToDetect(value, listOfObjectToDetect);
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: searchResult.isNotEmpty ? SearhResult() : DefaultObjects(),
          ),
        ],
      ),
    );
  }

  ListView DefaultObjects() {
    return ListView.builder(
      itemCount: listOfObjectToDetect.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(listOfObjectToDetect[index]["name"]),
          trailing: Checkbox(
              value: listOfObjectToDetect[index]["status"],
              onChanged: (value) {
                setState(() {
                  listOfObjectToDetect[index]["status"] = value;
                });
              }),
        );
      },
    );
  }

  ListView SearhResult() {
    return ListView.builder(
      itemCount: searchResult.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(searchResult[index]["name"]),
          trailing: Checkbox(
              value: searchResult[index]["status"],
              onChanged: (value) {
                setState(() {
                  searchResult[index]["status"] = value;
                });
              }),
        );
      },
    );
  }
}
