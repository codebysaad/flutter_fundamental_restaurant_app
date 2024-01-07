import 'package:flutter/material.dart';

import 'package:fluuter_interm_restaurant_app/data/rest/api_services.dart';
import 'package:fluuter_interm_restaurant_app/models/model_restaurant_search.dart';
import 'package:fluuter_interm_restaurant_app/utils/const_state.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantSearchProvider({required this.apiService});

  late RestaurantSearchResult _restaurantSearchResult;
  RestaurantSearchResult get result => _restaurantSearchResult;

  ConstState? _state;
  ConstState? get state => _state;

  String _message = '';
  String get message => _message;

  Future<dynamic> fetchSearchRestaurant(String query) async {
    try {
      _state = ConstState.loading;
      notifyListeners();

      final restaurantSearch = await apiService.getRestaurantSearch(query);
      if (restaurantSearch.founded == 0 &&
          restaurantSearch.restaurants.isEmpty) {
        _state = ConstState.noData;
        notifyListeners();

        return _message = 'Data Not Found';
      } else {
        _state = ConstState.hasData;
        notifyListeners();

        return _restaurantSearchResult = restaurantSearch;
      }
    } catch (e) {
      _state = ConstState.error;
      notifyListeners();

      return _message = 'Error --> $e';
    }
  }
}
