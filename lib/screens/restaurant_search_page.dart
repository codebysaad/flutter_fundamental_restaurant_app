import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluuter_interm_restaurant_app/utils/const_state.dart';
import 'package:fluuter_interm_restaurant_app/components/restaurant_item.dart';
import 'package:fluuter_interm_restaurant_app/provider/restaurant_search_provider.dart';
import 'package:fluuter_interm_restaurant_app/components/loading_progress.dart';
import 'package:fluuter_interm_restaurant_app/components/text_message.dart';

class RestaurantSearchPage extends StatelessWidget {
  static const String routeName = '/restaurant_search';

  const RestaurantSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Searching', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: TextField(
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.search,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(16),
                border: InputBorder.none,
                hintText: 'Search based restaurant name',
                suffixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
              ),
              onSubmitted: (query) {
                if (query != '') {
                  Provider.of<RestaurantSearchProvider>(
                    context,
                    listen: false,
                  ).fetchSearchRestaurant(query);
                }
              },
            ),
          ),
          Expanded(
            child: Consumer<RestaurantSearchProvider>(
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
                      itemCount: provider.result.restaurants.length,
                      itemBuilder: (_, index) {
                        final restaurant = provider.result.restaurants[index];
                        return RestaurantItem(restaurant: restaurant);
                      },
                    );
                  case ConstState.noData:
                    return const TextMessage(
                      image: 'assets/images/not-found.png',
                      message: 'Data not found',
                    );
                  case ConstState.error:
                    return const TextMessage(
                      image: 'assets/images/no-internet.png',
                      message: 'Lost Connection',
                    );
                  default:
                    return const TextMessage(
                      image: 'assets/images/search-restaurant.png',
                      message: 'Please searching...',
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
