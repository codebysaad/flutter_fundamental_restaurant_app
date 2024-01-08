import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class HomeRobot {
  final WidgetTester tester;

  HomeRobot(this.tester);

  Future<void> scrollRestaurant({bool scrollUp = false}) async {
    final scrollViewFinder = find.byKey(const Key('restaurantScrollView'));

    if (scrollUp) {
      await tester.fling(scrollViewFinder, const Offset(0, 500), 10000);
      await tester.pumpAndSettle();
    } else {
      await tester.fling(scrollViewFinder, const Offset(0, -500), 10000);
      await tester.pumpAndSettle();
    }
  }

  Future<void> clickRestaurantDetail() async {
    final restaurantDetailFinder =
        find.byKey(const Key('openRestaurantDetail'));

    await tester.ensureVisible(restaurantDetailFinder);
    await tester.tap(restaurantDetailFinder);

    await tester.pumpAndSettle();
  }
}
