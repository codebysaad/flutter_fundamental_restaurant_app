import 'package:flutter/material.dart';
import 'package:fluuter_interm_restaurant_app/data/database/db_helper.dart';
import 'package:fluuter_interm_restaurant_app/utils/const_state.dart';
import 'package:fluuter_interm_restaurant_app/models/model_restaurant_list.dart';

class DbProvider extends ChangeNotifier {
  final DbHelper databaseHelper;

  DbProvider({required this.databaseHelper}) {
    _getFavorites();
  }

  ConstState _state = ConstState.noData;
  ConstState get state => _state;

  String _message = '';
  String get message => _message;

  List<Restaurant> _favorites = [];
  List<Restaurant> get favorites => _favorites;

  void _getFavorites() async {
    _favorites = await databaseHelper.getFavorites();

    if (_favorites.isNotEmpty) {
      _state = ConstState.hasData;
    } else {
      _state = ConstState.noData;
      _message = 'Empty Favourite';
    }

    notifyListeners();
  }

  void insertFavourite(Restaurant restaurant) async {
    try {
      await databaseHelper.insertFavorite(restaurant);
      _getFavorites();
    } catch (e) {
      _state = ConstState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isFavourite(String id) async {
    final favouriteRestaurant = await databaseHelper.getFavoriteById(id);
    return favouriteRestaurant.isNotEmpty;
  }

  void deleteFavourite(String id) async {
    try {
      await databaseHelper.deleteFavorite(id);
      _getFavorites();
    } catch (e) {
      _state = ConstState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }
}
