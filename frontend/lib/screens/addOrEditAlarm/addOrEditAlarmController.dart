import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Navigator;

class AddOrEditAlarmController {
  go(context, name) {
    Navigator.of(context).pushNamed(name);
  }

  goToSelectDays(context) {
    go(context, "/selectDays");
  }

  goToObjectToDetect(context) {
    go(context, "/objectToDetect");
  }
}
