class ParseDays {
  Map SpanishToEnglish = {
    "Domigo": "Sunday",
    "Lunes": "Monday",
    "Marte": "Tuesday",
    "Miércoles": "Wednesday",
    "Jueve": "Thursday",
    "Viernes": "Friday",
    "Sábado": "Saturday",
  };

  Map EnglishToSpanish = {
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
    alarmDays.forEach((dayByName) {
      String englishDay = SpanishToEnglish[dayByName];
      englishDays.add(englishDay);
    });
    return englishDays;
  }

  daysDecode(List alarmDays) {
    List<String> spanishDays = [];
    alarmDays.forEach((dayByName) {
      String englishDay = EnglishToSpanish[dayByName];
      spanishDays.add(englishDay);
    });
    return spanishDays;
  }
}
