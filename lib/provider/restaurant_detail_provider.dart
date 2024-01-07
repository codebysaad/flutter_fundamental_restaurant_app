import 'package:flutter/material.dart';

import 'package:fluuter_interm_restaurant_app/data/rest/api_services.dart';
import 'package:fluuter_interm_restaurant_app/models/model_restaurant_detail.dart';
import 'package:fluuter_interm_restaurant_app/utils/const_state.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String restaurantId;

  RestaurantDetailProvider({
    required this.apiService,
    required this.restaurantId,
  }) {
    fetchDetailRestaurant(restaurantId);
  }

  late RestaurantDetailResult _restaurantDetailResult;
  RestaurantDetailResult get result => _restaurantDetailResult;

  late ConstState _state;
  ConstState get state => _state;

  String _message = '';
  String get message => _message;

  Future<dynamic> fetchDetailRestaurant(String restaurantId) async {
    try {
      _state = ConstState.loading;
      notifyListeners();

      final restaurantDetail =
          await apiService.getRestaurantDetail(restaurantId);
      _state = ConstState.hasData;
      notifyListeners();

      return _restaurantDetailResult = restaurantDetail;
    } catch (e) {
      _state = ConstState.error;
      notifyListeners();

      return _message = 'Error --> $e';
    }
  }

  Future<dynamic> postReview({
    required String id,
    required String name,
    required String review,
  }) async {
    try {
      final postReviewResult = await apiService.postReview(
        id: id,
        name: name,
        review: review,
      );
      if (postReviewResult.error == false &&
          postReviewResult.message == 'success') {
        fetchDetailRestaurant(id);

        return ConstState.success;
      }
    } catch (e) {
      _state = ConstState.error;
      notifyListeners();

      return _message = 'Error --> $e';
    }
  }
}
