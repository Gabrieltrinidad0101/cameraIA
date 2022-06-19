import 'package:frontend/languages/english.dart';
import 'package:frontend/languages/spanish.dart';
import 'package:frontend/services/localStorage/language.dart'
    as local_db_language;

Map<String, Map<String, dynamic>> languages = {"en": english, "es": spanish};

String? languageCodeOldState;

class Languages {
  String? languageCode;
  Languages() {
    if (languageCodeOldState == null) {
      languageCode = languageCodeOldState;
    } else {
      languageCode = languageCodeOldState;
    }
  }

  Future<String?> getLanguageCode() async {
    languageCode = await local_db_language.get();
    languageCodeOldState = languageCode;
    return languageCode;
  }

  Future setLanguageCode(String language) async {
    await local_db_language.save(language);
    languageCodeOldState = language;
  }

  get(String key) {
    var a = languages[languageCode]?[key] ?? "Error in language code";
    return a;
  }
}
