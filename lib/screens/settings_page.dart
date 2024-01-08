import 'package:flutter/material.dart';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'package:fluuter_interm_restaurant_app/provider/preferences_provider.dart';
import 'package:fluuter_interm_restaurant_app/provider/scheduling_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  void showDialogPermissionIsPermanentlyDenied(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Allow this app to show notification'),
        content: const Text(
            'You need to grant this permission from system settings.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              openAppSettings();
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings Page', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blueAccent,
      ),
      body: Consumer<PreferencesProvider>(
        builder: (_, preferences, __) {
          return Consumer<SchedulingProvider>(
            builder: (_, scheduled, __) {
              void setReminder(bool value) {
                scheduled.scheduledReminder(value);
                preferences.enableDailyReminder(value);
              }
              return SwitchListTile(
                title: const Text('Daily Reminder'),
                value: preferences.isDailyReminderActive,
                onChanged: (value) async {
                  if (value == true) {
                    final androidInfo = await DeviceInfoPlugin().androidInfo;

                    if (androidInfo.version.sdkInt > 32) {
                      final status = await Permission.notification.status;

                      if (status == PermissionStatus.granted) {
                        setReminder(value);
                      } else if (status == PermissionStatus.denied) {
                        final result = await Permission.notification.request();

                        if (result == PermissionStatus.granted) {
                          setReminder(value);
                        } else if (result ==
                            PermissionStatus.permanentlyDenied) {
                          if (context.mounted) {
                            showDialogPermissionIsPermanentlyDenied(context);
                          }
                        }
                      }
                    }
                  } else {
                    setReminder(value);
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
