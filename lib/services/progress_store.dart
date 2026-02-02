import 'package:shared_preferences/shared_preferences.dart';

class ProgressStore {
  static const _prefix = "done_"; // done_2026-02-02

  Future<bool> isDone(String dateKey) async {
    final sp = await SharedPreferences.getInstance();
    return sp.getBool("$_prefix$dateKey") ?? false;
  }

  Future<void> setDone(String dateKey, bool value) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setBool("$_prefix$dateKey", value);
  }
}
