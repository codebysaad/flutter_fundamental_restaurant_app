import 'package:flutter/cupertino.dart';
import 'package:fluuter_interm_restaurant_app/themes/styles.dart';
import 'package:fluuter_interm_restaurant_app/models/restaurant.dart';
import 'package:fluuter_interm_restaurant_app/models/helpers.dart';
import 'package:fluuter_interm_restaurant_app/components/restaurant_row_item.dart';
import 'package:fluuter_interm_restaurant_app/components/search_bar.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({Key? key}) : super(key: key);

  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  late final FocusNode _focusNode;
  String _query = '';
  List<Restaurant> _restaurant = [];

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    init();
  }

  Future init() async {
    final restaurants = await RestaurantSearch.getRestaurant(_query);
    setState(() => _restaurant = restaurants);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  Future searchData(String _query) async {
    final restaurant = await RestaurantSearch.getRestaurant(_query);

    if (!mounted) return;

    setState(() {
      this._query = _query;
      _restaurant = restaurant;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Styles.scaffoldBackground,
      ),
      child: SafeArea(
        child: Column(
          children: [_buildSearchBox(), _buildList(_restaurant)],
        ),
      ),
    );
  }

  Widget _buildSearchBox() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SearchBar(
        focusNode: _focusNode,
        onChanged: searchData,
      ),
    );
  }

  Widget _buildList(results) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) => RestaurantRowItem(
          restaurant: results[index],
          lastItem: index == results.length - 1,
        ),
        itemCount: results.length,
      ),
    );
  }
}