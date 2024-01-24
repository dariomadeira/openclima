import 'package:flutter/material.dart';
import 'package:openclima/config/constants.dart';
import 'package:openclima/services/shared_preferences_service.dart';

class ThemeProvider with ChangeNotifier {
  factory ThemeProvider() {
    return _thisInstance;
  }

  ThemeProvider._internal();

  static final ThemeProvider _thisInstance = ThemeProvider._internal();

  final _prefs = AppPreferences();
  bool _darkTheme = false;

  void initTheme() async {
    final bool isDark = _prefs.readPreferenceBool('darkMode');
    if (isDark == false) {
      _darkTheme = false;
    } else if (isDark == true) {
      _darkTheme = true;
    }
  }

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    _prefs.savePreferenceBool(kDarkModePref, value);
    notifyListeners();
  }

}
