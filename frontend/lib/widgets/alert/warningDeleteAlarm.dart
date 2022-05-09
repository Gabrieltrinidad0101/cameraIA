import 'package:flutter/material.dart';

alertWarning(
    {required context,
    required title,
    required description,
    required Function callBack}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(description),
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
              callBack();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
