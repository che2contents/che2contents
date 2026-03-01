import 'package:shared_preferences/shared_preferences.dart';

class ProgressStore {
  static String _key(String dateKey) => 'done:$dateKey';

  Future<bool> isDone(String dateKey) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_key(dateKey)) ?? false;
  }

  Future<void> setDone(String dateKey, bool done) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key(dateKey), done);
  }
}