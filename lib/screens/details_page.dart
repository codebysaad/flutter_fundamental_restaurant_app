import 'package:flutter/material.dart';
import 'package:fluuter_interm_restaurant_app/utils/const_state.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:fluuter_interm_restaurant_app/components/loading_progress.dart';
import 'package:fluuter_interm_restaurant_app/components/text_message.dart';
import 'package:fluuter_interm_restaurant_app/components/content_detail_restaurant.dart';
import '../data/rest/api_services.dart';
import '../models/model_restaurant_list.dart';
import '../provider/restaurant_detail_provider.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final Restaurant restaurant;

  const RestaurantDetailPage({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantDetailProvider>(
      create: (_) => RestaurantDetailProvider(
        apiService: ApiService(http.Client()),
        restaurantId: restaurant.id,
      ),
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<RestaurantDetailProvider>(
          builder: (_, provider, __) {
            switch (provider.state) {
              case ConstState.loading:
                return const LoadingAnimation();
              case ConstState.hasData:
                return ContentDetailRestaurant(
                  provider: provider,
                  restaurant: provider.result.restaurant,
                );
              case ConstState.error:
                return TextMessage(
                  image: 'assets/images/no-internet.png',
                  message: 'Lost Connection',
                  onPressed: () =>
                      provider.fetchDetailRestaurant(restaurant.id),
                );
              default:
                return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
