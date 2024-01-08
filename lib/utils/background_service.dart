import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluuter_interm_restaurant_app/data/rest/api_services.dart';
import 'package:fluuter_interm_restaurant_app/main.dart';
import 'notification_helper.dart';

final ReceivePort receivePort = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate_name';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(receivePort.sendPort, _isolateName);
  }

  static Future<void> callback() async {
    debugPrint('Alarm on!');

    final NotificationHelper notificationHelper = NotificationHelper();
    final result = await ApiService(http.Client()).getRestaurantList();

    await notificationHelper.showNotification(
      localNotificationsPlugin,
      result,
    );

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
