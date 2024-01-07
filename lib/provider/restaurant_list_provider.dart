import 'package:flutter/material.dart';

import 'package:fluuter_interm_restaurant_app/data/rest/api_services.dart';
import 'package:fluuter_interm_restaurant_app/models/model_restaurant_list.dart';
import 'package:fluuter_interm_restaurant_app/utils/const_state.dart';

class RestaurantListProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantListProvider({required this.apiService}) {
    fetchAllRestaurant();
  }

  late RestaurantListResult _restaurantListResult;
  RestaurantListResult get result => _restaurantListResult;

  late ConstState _state;
  ConstState get state => _state;

  String _message = '';
  String get message => _message;

  Future<dynamic> fetchAllRestaurant() async {
    try {
      _state = ConstState.loading;
      notifyListeners();

      final restaurantList = await apiService.getRestaurantList();
      if (restaurantList.count == 0 && restaurantList.restaurants.isEmpty) {
        _state = ConstState.noData;
        notifyListeners();

        return _message = 'Empty Data';
      } else {
        _state = ConstState.hasData;
        notifyListeners();

        return _restaurantListResult = restaurantList;
      }
    } catch (e) {
      _state = ConstState.error;
      notifyListeners();

      return _message = 'Error --> $e';
    }
  }
}
