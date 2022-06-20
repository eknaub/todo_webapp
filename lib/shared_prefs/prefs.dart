import 'package:shared_preferences/shared_preferences.dart';

final sharedPrefs = Preferences.prefs;

class Preferences {
  static final Preferences _prefs = Preferences();
  static Preferences get prefs => _prefs;
  late SharedPreferences instance;

  Future<void> init() async {
    instance = await SharedPreferences.getInstance();
  }
}
