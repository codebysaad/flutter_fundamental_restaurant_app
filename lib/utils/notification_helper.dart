import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';
import 'package:fluuter_interm_restaurant_app/themes/navigation.dart';
import 'package:fluuter_interm_restaurant_app/models/model_restaurant_list.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initialNotification(
    FlutterLocalNotificationsPlugin localNotificationsPlugin,
  ) async {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    const initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await localNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) async {
        final payload = details.payload;

        if (payload != null) debugPrint('payload notification: $payload');

        selectNotificationSubject.add(payload ?? 'empty payload');
      },
    );
  }

  Future<void> showNotification(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    RestaurantListResult restaurantList,
  ) async {
    const channelId = '1';
    const channelName = 'channel_01';
    const channelDescription = 'restaurant channel';

    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      styleInformation: DefaultStyleInformation(true, true),
    );

    const platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    const titleNotification = "<b>Restaurant Recommendation Today</b>";
    final index = Random().nextInt(restaurantList.restaurants.length);
    final restaurant = restaurantList.restaurants[index];
    debugPrint(json.encode(restaurant.toJson()));

    await flutterLocalNotificationsPlugin.show(
      0,
      titleNotification,
      restaurant.name,
      platformChannelSpecifics,
      payload: json.encode(restaurant.toJson()),
    );
  }

  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen((payload) async {
      final data = Restaurant.fromJson(json.decode(payload));
      Navigation.intentWithData(route, data);
    });
  }
}
