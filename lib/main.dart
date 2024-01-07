import 'package:flutter/material.dart';
import 'package:fluuter_interm_restaurant_app/provider/restaurant_list_provider.dart';
import 'package:fluuter_interm_restaurant_app/provider/restaurant_search_provider.dart';
import 'package:fluuter_interm_restaurant_app/screens/home_page.dart';
import 'package:fluuter_interm_restaurant_app/screens/details_page.dart';
import 'package:fluuter_interm_restaurant_app/screens/restaurant_search_page.dart';
import 'package:fluuter_interm_restaurant_app/screens/restaurant_tab.dart';
import 'package:fluuter_interm_restaurant_app/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'data/rest/api_services.dart';
import 'package:fluuter_interm_restaurant_app/themes/navigation.dart';
import 'package:http/http.dart' as http;

import 'models/model_restaurant_list.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
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