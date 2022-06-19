import 'package:flutter/material.dart';
import 'package:frontend/widgets/text/text_language.dart';

Future<void> showLoadingDialog(BuildContext context, GlobalKey key) async {
  return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async => false,
            child: SimpleDialog(
                key: key,
                backgroundColor: Colors.black54,
                children: <Widget>[
                  Center(
                    child: Column(children: [
                      const CircularProgressIndicator(),
                      const SizedBox(
                        height: 10,
                      ),
                      TextLanguage(
                        "wait",
                        style: const TextStyle(color: Colors.blueAccent),
                      )
                    ]),
                  )
                ]));
      });
}
