import 'package:flutter/material.dart';

class RouterController {
  go({context, name, arguments}) async {
    return await Navigator.of(context).pushNamed(name, arguments: arguments);
  }

  Future goToSelectDays(context, _alarmDays) async {
    List alarmDays =
        await go(context: context, name: "/selectDays", arguments: _alarmDays);
    return alarmDays;
  }

  Future<List> goToObjectToDetect(context) async {
    List selectedObjects = await go(context: context, name: "/objectToDetect");
    return selectedObjects;
  }
}
