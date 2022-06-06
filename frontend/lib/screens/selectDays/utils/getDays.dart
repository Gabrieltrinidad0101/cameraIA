import 'package:frontend/languages/laguages.dart';

List<Map> ListOfDays() {
  Languages languages = Languages();
  List<Map> alarmDays = [];
  for (Map alarmDay in languages.get("alarmDays")) {
    alarmDays.add({...alarmDay});
  }
  return alarmDays;
}
