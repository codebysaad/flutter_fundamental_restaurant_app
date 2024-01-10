import 'dart:io';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluuter_interm_restaurant_app/data/database/db_helper.dart';
import 'package:fluuter_interm_restaurant_app/provider/preferences_provider.dart';
import 'package:fluuter_interm_restaurant_app/provider/restaurant_list_provider.dart';
import 'package:fluuter_interm_restaurant_app/provider/restaurant_search_provider.dart';
import 'package:fluuter_interm_restaurant_app/provider/scheduling_provider.dart';
import 'package:fluuter_interm_restaurant_app/screens/home_page.dart';
import 'package:fluuter_interm_restaurant_app/screens/details_page.dart';
import 'package:fluuter_interm_restaurant_app/screens/restaurant_search_page.dart';
import 'package:fluuter_interm_restaurant_app/screens/restaurant_tab.dart';
import 'package:fluuter_interm_restaurant_app/screens/splash_screen.dart';
import 'package:fluuter_interm_restaurant_app/utils/background_service.dart';
import 'package:fluuter_interm_restaurant_app/utils/notification_helper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/preferences/preferences_helper.dart';
import 'data/rest/api_services.dart';
import 'package:fluuter_interm_restaurant_app/themes/navigation.dart';
import 'package:http/http.dart' as http;
import 'package:fluuter_interm_restaurant_app/provider/db_provider.dart';
import 'models/model_restaurant_list.dart';

final FlutterLocalNotificationsPlugin localNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();

  service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }

  await notificationHelper.initialNotification(localNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DbProvider(databaseHelper: DbHelper()),
        ),
        ChangeNotifierProvider(
          create: (_) => RestaurantListProvider(
            apiService: ApiService(http.Client()),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => RestaurantSearchProvider(
            apiService: ApiService(http.Client()),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => SchedulingProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PreferencesProvider(
            preferencesHelper: SharedPrefHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        )
      ],
      child: MaterialApp(
        title: 'Restaurant App',
        theme: ThemeData(visualDensity: VisualDensity.adaptivePlatformDensity),
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        initialRoute: SplashScreen.routeName,
        routes: {
          SplashScreen.routeName: (context) => const SplashScreen(),
          HomePage.routeName: (_) => const HomePage(),
          RestaurantListTab.routeName: (_) => const RestaurantListTab(),
          RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
              restaurant:
              ModalRoute.of(context)?.settings.arguments as Restaurant),
          RestaurantSearchPage.routeName: (_) => const RestaurantSearchPage(),
        },
      ),
    );
  }
}