import 'package:flutter/material.dart' show Navigator;
import 'package:flutter/material.dart';

class ObjectToDetectController {
  goToBack(context, [listOfObjectToDetect]) {
    List selectedObjects = getSelectedObjects(listOfObjectToDetect);
    Navigator.pop(context, selectedObjects);
  }

  List getSelectedObjectsOfArguments(context, _alarmObjects) {
    var arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments == null) return _alarmObjects;
    List? selectObjects = arguments as List;
    List alarmObjects =
        setSeletedcObjectsInAlarmObject(_alarmObjects, selectObjects);
    return alarmObjects;
  }

  List setSeletedcObjectsInAlarmObject(List alarmObjects, List selectObjects) {
    List selectedObjectContainer = [];
    int index = 0;
    for (int i = 0; i < alarmObjects.length; i++) {
      var alarmObject = alarmObjects[i];
      for (var selectObject in selectObjects) {
        if (alarmObject["name"] == selectObject) {
          alarmObject["status"] = true;
          alarmObjects.removeAt(i);
          alarmObjects.insert(index, alarmObject);
          index++;
        }
      }
    }
    return alarmObjects;
  }

  List getSelectedObjects(
    List? listOfObjectToDetect,
  ) {
    List<String> objects = [];
    listOfObjectToDetect?.forEach((object) {
      if (object["status"]) {
        objects.add(object["name"]);
      }
    });
    return objects;
  }

  List searchObjectToDetect(String objectToSearch, List objects) {
    List searchResult = [];
    for (Map data in objects) {
      if (data["name"].toLowerCase().contains(objectToSearch.toLowerCase())) {
        searchResult.add(data);
      }
    }
    return searchResult;
  }
}
