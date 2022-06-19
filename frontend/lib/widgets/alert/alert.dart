import 'package:flutter/material.dart';
import 'package:frontend/widgets/text/text_language.dart';

alert({required context, required title, required Widget content}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: content,
        actions: <Widget>[
          TextButton(
            child: TextLanguage("accept"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
