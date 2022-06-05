import 'package:frontend/services/localStorage/language.dart'
    as local_db_language;

const Map<String, Map<String, dynamic>> languages = {
  "en": {
    "home": "Home",
    "languages": "languages",
    "chooseYourLanguage": "Choose your language",
    "logout": "Log out ",
    "alarmDays": [
      {"name": "Sunday", "status": false},
      {"name": "Monday", "status": false},
      {"name": "Tuesday", "status": false},
      {"name": "Wednesday", "status": false},
      {"name": "Thursday", "status": false},
      {"name": "Friday", "status": false},
      {"name": "Satuday", "status": false},
    ]
  },
  "es": {
    "home": "inicio",
    "languages": "lenguajes",
    "chooseYourLanguage": "Elige tú idioma",
    "logout": "cerrar sesión ",
    "alarmDays": [
      {"name": "Domigo", "status": false},
      {"name": "Lunes", "status": false},
      {"name": "Marte", "status": false},
      {"name": "Miércoles", "status": false},
      {"name": "Jueve", "status": false},
      {"name": "Viernes", "status": false},
      {"name": "Sábado", "status": false},
    ]
  }
};

class Languages {
  String? languageCode;

  Future<String?> getLanguageCode() async {
    languageCode = await local_db_language.get();
    return languageCode;
  }

  setLanguageCode(String language) async {
    await local_db_language.save(language);
    languageCode = language;
  }

  get(String key) {
    var a = languages[languageCode]?[key] ?? "Error in language code";
    return a;
  }
}
