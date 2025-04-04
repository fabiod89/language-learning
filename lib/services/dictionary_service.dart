import 'package:shared_preferences/shared_preferences.dart';

class DictionaryService {
  static const _key = 'saved_words';

  static Future<void> saveWord(String language, String word) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '${language}_$_key';
    final words = await getWords(language);
    if (!words.contains(word)) {
      words.add(word);
      await prefs.setStringList(key, words);
    }
  }

  static Future<List<String>> getWords(String language) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '${language}_$_key';
    return prefs.getStringList(key) ?? [];
  }

  static Future<void> removeWord(String language, String word) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '${language}_$_key';
    final words = await getWords(language);
    words.remove(word);
    await prefs.setStringList(key, words);
  }
}