class ParseDays {
  Map spanishToEnglish = {
    "Domigo": "Sunday",
    "Lunes": "Monday",
    "Marte": "Tuesday",
    "Miércoles": "Wednesday",
    "Jueve": "Thursday",
    "Viernes": "Friday",
    "Sábado": "Saturday",
  };

  Map englishToSpanish = {
    "Sunday": "Domigo",
    "Monday": "Lunes",
    "Tuesday": "Marte",
    "Wednesday": "Miércoles",
    "Thursday": "Jueve",
    "Friday": "Viernes",
    "Saturday": "Sábado",
  };

  daysEncode(List alarmDays) {
    List<String> englishDays = [];
    for (var dayByName in alarmDays) {
      String englishDay = spanishToEnglish[dayByName];
      englishDays.add(englishDay);
    }
    return englishDays;
  }

  daysDecode(List alarmDays) {
    List<String> spanishDays = [];
    for (var dayByName in alarmDays) {
      String englishDay = englishToSpanish[dayByName];
      spanishDays.add(englishDay);
    }
    return spanishDays;
  }
}
