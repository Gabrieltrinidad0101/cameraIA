import 'package:flutter/material.dart';

alertQuestion(
    {required context,
    required title,
    required Widget content,
    required Function callBack}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: content,
        actions: <Widget>[
          TextButton(
            child: const Text("cancelar"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text("aceptar"),
            onPressed: () {
              Navigator.of(context).pop();
              callBack();
            },
          ),
        ],
      );
    },
  );
}
