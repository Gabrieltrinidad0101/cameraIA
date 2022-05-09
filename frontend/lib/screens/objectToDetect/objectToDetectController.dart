import 'package:flutter/material.dart' show Navigator;

class ObjectToDetectController {
  goToBack(context, [listOfObjectToDetect]) {
    List selectedObjects = getSelectedObjects(listOfObjectToDetect);
    Navigator.pop(context, selectedObjects);
  }

  List getSelectedObjects(List? listOfObjectToDetect) {
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
      if (data["object"].toLowerCase().contains(objectToSearch.toLowerCase())) {
        searchResult.add(data);
      }
    }
    return searchResult;
  }
}
