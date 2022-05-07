class ParseDays {
  List spanishDays = [
    "Domigo",
    "Lunes",
    "Marte",
    "miércoles",
    "Jueve",
    "Viernes",
    "Sábado",
  ];

  List englishDays = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
  ];

  List spanishToEnglish(_spanishDays) {
    List _englishDays = [];
    Map _spanishToEnglish = {};

    for (var i = 0; i < spanishDays.length; i++) {
      _spanishToEnglish[spanishDays[i]] = englishDays[i];
    }
    for (var day in spanishDays) {
      print(day);
    }
    return _englishDays;
  }

  Map SpanishToEnglish = {
    "Domigo": "Sunday",
    "Lunes": "Monday",
    "Marte": "Tuesday",
    "miércoles": "Wednesday",
    "Jueve": "Thursday",
    "Viernes": "Friday",
    "Sábado": "Saturday",
  };

  daysEncode(List alarmDays) {
    List<String> englishDays = [];
    alarmDays.forEach((dayByName) {
      String englishDay = SpanishToEnglish[dayByName];
      englishDays.add(englishDay);
    });
    return englishDays;
  }

  daysDecode() {}
}
