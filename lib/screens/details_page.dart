import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluuter_interm_restaurant_app/themes/styles.dart';
import 'package:fluuter_interm_restaurant_app/models/restaurant.dart';
import 'package:carousel_slider/carousel_slider.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final Restaurant restaurant;
  const RestaurantDetailPage({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> foodsSliders = restaurant.menus.foods
        .map((item) => Container(
      margin: const EdgeInsets.all(1.0),
      child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
          child: Stack(
            children: <Widget>[
              Image.asset('assets/images/food.jpg',
                  fit: BoxFit.cover, width: 1000.0),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(200, 0, 0, 0),
                        Color.fromARGB(0, 0, 0, 0)
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  child: Text(
                    item.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              TextButton(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                  ),
                  onPressed: () {}),
            ],
          )),
    ))
        .toList();

    final List<Widget> drinksSliders = restaurant.menus.drinks
        .map((item) => Container(
      margin: const EdgeInsets.all(1.0),
      child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
          child: Stack(
            children: <Widget>[
              Image.asset('assets/images/beverage.png',
                  fit: BoxFit.cover, width: 1000.0),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(200, 0, 0, 0),
                        Color.fromARGB(0, 0, 0, 0)
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  child: Text(
                    item.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              TextButton(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                  ),
                  onPressed: () {}),
            ],
          )),
    ))
        .toList();

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(restaurant.name),
      ),
      child: Material(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              Hero(
                  tag: restaurant.pictureId,
                  child: Image.network(restaurant.pictureId)),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(restaurant.name, style: Styles.restaurantItemName),
                    const Padding(padding: EdgeInsets.only(top: 2)),
                    Row(children: [
                      const Icon(
                        CupertinoIcons.location_solid,
                        size: 13,
                        color: Colors.red,
                      ),
                      const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2)),
                      Text(
                        restaurant.city,
                        style: Styles.restaurantItemPreview,
                      ),
                    ]),
                    const Padding(padding: EdgeInsets.only(top: 2)),
                    Row(
                      children: [
                        const Icon(
                          CupertinoIcons.star_fill,
                          size: 13,
                          color: Colors.amber,
                        ),
                        const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2)),
                        Text(
                          '${restaurant.rating}',
                          style: Styles.restaurantItemPreview,
                        )
                      ],
                    ),
                    const SizedBox(height: 5),
                    const Divider(color: Colors.grey),
                    const Text(
                      "Description",
                      style: Styles.restaurantItemTitleDescription,
                    ),
                    const Padding(padding: EdgeInsets.only(top: 2)),
                    Text(
                      restaurant.description,
                      textAlign: TextAlign.justify,
                      style: Styles.restaurantItemDescription,
                    ),
                    const SizedBox(height: 5),
                    const Divider(color: Colors.grey),
                    const Text(
                      "Menus",
                      style: Styles.restaurantItemTitleDescription,
                    ),
                    const Padding(padding: EdgeInsets.only(top: 5)),
                    const Text(
                      "Foods",
                      style: Styles.restaurantItemDescription,
                    ),
                    const Padding(padding: EdgeInsets.only(top: 5)),
                    CarouselSlider(
                      options: CarouselOptions(
                        aspectRatio: 2.0,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: false,
                        initialPage: 2,
                        autoPlay: true,
                      ),
                      items: foodsSliders,
                    ),
                    const Padding(padding: EdgeInsets.only(top: 5)),
                    const Text(
                      "Beverages",
                      style: Styles.restaurantItemDescription,
                    ),
                    const Padding(padding: EdgeInsets.only(top: 5)),
                    CarouselSlider(
                      options: CarouselOptions(
                        aspectRatio: 2.0,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: false,
                        initialPage: 2,
                        autoPlay: true,
                      ),
                      items: drinksSliders,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}