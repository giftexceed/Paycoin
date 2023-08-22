// ignore_for_file: constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

class Settings {
  static const String SHUFFLE_MODE_KEY = 'shuffleMode';
  static const String REPEAT_MODE_KEY = 'repeatMode';

  static Future<bool> getShuffleMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(SHUFFLE_MODE_KEY) ?? false;
  }

  static Future<void> setShuffleMode(bool shuffleMode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(SHUFFLE_MODE_KEY, shuffleMode);
  }
}
