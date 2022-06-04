import 'package:flutter/material.dart';

FractionallySizedBox timeButton(
    {required String name, required String time, required Function onPressed}) {
  return FractionallySizedBox(
    widthFactor: .98,
    child: ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
        ),
      ),
      onPressed: () {
        onPressed();
      },
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(name), Text(time)]),
    ),
  );
}
