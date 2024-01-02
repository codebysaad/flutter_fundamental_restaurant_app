import 'package:flutter/material.dart';
import 'package:fluuter_interm_restaurant_app/screens/home_page.dart';
import 'package:fluuter_interm_restaurant_app/screens/details_page.dart';
import 'package:fluuter_interm_restaurant_app/screens/splash_screen.dart';
import 'models/restaurant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      theme: ThemeData(visualDensity: VisualDensity.adaptivePlatformDensity),
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        HomePage.routeName: (context) => const HomePage(),
        RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
            restaurant:
            ModalRoute.of(context)?.settings.arguments as Restaurant),
      },
    );
  }
}