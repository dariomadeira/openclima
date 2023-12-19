import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {

  factory AppPreferences() {
    return _thisInstance;
  }

  AppPreferences._internal();

  static final AppPreferences _thisInstance = AppPreferences._internal();

  late SharedPreferences _prefs;

  Future initPref() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void resetAll() {
    _prefs.clear();
  }

  void removePreference(String key) {
    _prefs.remove(key);
  }

  String readPreferenceString(String key) {
    return _prefs.getString(key) ?? "";
  }

  void savePreferenceString(String key, String value) {
    _prefs.setString(key, value);
  }

  bool readPreferenceBool(String key) {
    return _prefs.getBool(key) ?? false;
  }

  void savePreferenceBool(String key, bool value) {
    _prefs.setBool(key, value);
  }

  void saveListPreferenceString(String key, List<String> value) {
    _prefs.setStringList(key, value);
  }

  List readListPreferenceString(String key) {
    return _prefs.getStringList(key)!;
  }

  int readPreferenceInt(String key) {
    return _prefs.getInt(key) ?? 0;
  }

  void savePreferenceInt(String key, int value) {
    _prefs.setInt(key, value);
  }
}
