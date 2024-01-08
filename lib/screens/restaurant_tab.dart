import 'package:flutter/material.dart';
import 'package:fluuter_interm_restaurant_app/components/loading_progress.dart';
import 'package:fluuter_interm_restaurant_app/components/text_message.dart';
import 'package:fluuter_interm_restaurant_app/screens/restaurant_search_page.dart';
import 'package:fluuter_interm_restaurant_app/utils/const_state.dart';
import 'package:provider/provider.dart';
import 'package:fluuter_interm_restaurant_app/provider/restaurant_list_provider.dart';
import 'package:fluuter_interm_restaurant_app/components/restaurant_item.dart';

class RestaurantListTab extends StatelessWidget {
  static const routeName = '/restaurant_tab';

  const RestaurantListTab({super.key});

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text(
        'Restaurant App',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.blueAccent,
      actions: [
        IconButton(
          icon: const Icon(
            Icons.search,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushNamed(context, RestaurantSearchPage.routeName);
          },
        ),
      ],
    );
  }

  Widget _buildList() {
    return Consumer<RestaurantListProvider>(
      builder: (_, provider, __) {
        switch (provider.state) {
          case ConstState.loading:
            return const LoadingAnimation();
          case ConstState.hasData:
            return ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              itemCount: provider.result.count,
              itemBuilder: (_, index) {
                final restaurant = provider.result.restaurants[index];
                return RestaurantItem(restaurant: restaurant);
              },
            );
          case ConstState.noData:
            return const TextMessage(
              image: 'assets/images/empty-data.png',
              message: 'Empty Data',
            );
          case ConstState.error:
            return TextMessage(
              image: 'assets/images/no-internet.png',
              message: 'Lost Connection',
              onPressed: () => provider.fetchAllRestaurant(),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildList(),
      key: const Key('restaurantScrollView'),
    );
  }
}
