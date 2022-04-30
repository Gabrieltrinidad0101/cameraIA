import 'package:flutter/material.dart';

alert_info({required context, required title, required description}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text(title),
        content: new Text(description),
        actions: <Widget>[
          new FlatButton(
            child: new Text("accept"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
