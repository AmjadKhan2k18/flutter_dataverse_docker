import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtils {
  static SharedPreferences? _prefsInstance;

  static Future<SharedPreferences> get _instance async =>
      _prefsInstance ??= await SharedPreferences.getInstance();

  static Future<void> init() async {
    _prefsInstance = await _instance;
  }

  static Future<String?> getString(String prefKey) async {
    try {
      return (await _instance).getString(prefKey);
    } catch (e) {
      return null;
    }
  }

  static Future<void> setString(String prefKey, String value) async {
    (await _instance).setString(prefKey, value);
  }
}
