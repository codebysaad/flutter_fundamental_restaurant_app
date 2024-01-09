import 'package:flutter/material.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:fluuter_interm_restaurant_app/utils/background_service.dart';
import 'package:fluuter_interm_restaurant_app/utils/date_time_helper.dart';

class SchedulingProvider extends ChangeNotifier {
  bool _isScheduled = false;
  bool get isScheduled => _isScheduled;

  Future<bool> scheduledReminder(bool value) async {
    _isScheduled = value;

    if (_isScheduled) {
      debugPrint('Scheduling Reminder Active');
      notifyListeners();

      return AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      debugPrint('Scheduling Restaurant Cancel');
      notifyListeners();

      return await AndroidAlarmManager.cancel(1);
    }
  }
}
