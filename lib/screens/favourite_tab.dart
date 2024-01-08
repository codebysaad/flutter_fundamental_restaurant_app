import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:fluuter_interm_restaurant_app/utils/const_state.dart';
import 'package:fluuter_interm_restaurant_app/provider/db_provider.dart';
import 'package:fluuter_interm_restaurant_app/components/restaurant_item.dart';
import 'package:fluuter_interm_restaurant_app/components/text_message.dart';

class FavouriteTab extends StatelessWidget {

  const FavouriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildList(),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Favourite Page', style: TextStyle(color: Colors.white),),
      backgroundColor: Colors.blueAccent,
    );
  }

  Widget _buildList() {
    return Consumer<DbProvider>(
      builder: (_, provider, __) {
        if (provider.state == ConstState.hasData) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            itemCount: provider.favorites.length,
            itemBuilder: (_, index) {
              final restaurant = provider.favorites[index];
              return RestaurantItem(restaurant: restaurant);
            },
          );
        } else {
          return TextMessage(
            image: 'assets/images/empty-data.png',
            message: provider.message,
          );
        }
      },
    );
  }
}
