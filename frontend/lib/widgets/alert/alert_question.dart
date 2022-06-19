import 'package:flutter/material.dart';
import 'package:frontend/widgets/text/text_language.dart';

alertQuestion(
    {required context,
    required title,
    required Widget content,
    required Function callBack}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: TextLanguage(title),
        content: content,
        actions: <Widget>[
          TextButton(
            child: TextLanguage("cancel"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: TextLanguage("accept"),
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
