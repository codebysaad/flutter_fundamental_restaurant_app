import 'package:fluuter_interm_restaurant_app/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'automation/detail_restaurant_robot.dart';
import 'automation/home_robot.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  HomeRobot homeRobot;
  DetailRestaurantRobot detailRestaurantRobot;

  group('end-to-end test', () {
    testWidgets(
      'whole app',
      (WidgetTester tester) async {
        app.main();

        await tester.pumpAndSettle();

        homeRobot = HomeRobot(tester);
        detailRestaurantRobot = DetailRestaurantRobot(tester);

        await homeRobot.scrollRestaurant();
        await homeRobot.clickRestaurantDetail();
        await detailRestaurantRobot.scrollThePage();
        await detailRestaurantRobot.goBack();
      },
    );
  });
}
