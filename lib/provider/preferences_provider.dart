import 'package:flutter/material.dart';

import '../data/preferences/preferences_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  SharedPrefHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper}) {
    _getDailyReminderPref();
  }

  bool _isDailyReminderActive = false;
  bool get isDailyReminderActive => _isDailyReminderActive;

  void _getDailyReminderPref() async {
    _isDailyReminderActive = await preferencesHelper.isDailyReminderActive;
    notifyListeners();
  }

  void enableDailyReminder(bool value) {
    preferencesHelper.setDailyReminder(value);
    _getDailyReminderPref();
  }
}
