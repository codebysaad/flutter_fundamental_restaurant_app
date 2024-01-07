import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluuter_interm_restaurant_app/themes/styles.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fluuter_interm_restaurant_app/models/model_restaurant_detail.dart';
import '../provider/restaurant_detail_provider.dart';
import 'pop_up_review.dart';

class ContentDetailRestaurant extends StatelessWidget {
  final RestaurantDetail restaurant;
  final RestaurantDetailProvider provider;

  const ContentDetailRestaurant({
    super.key,
    required this.restaurant,
    required this.provider,
  });

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
      backgroundColor: Colors.blueAccent,
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          restaurant.name,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      child: Material(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Hero(
                  tag: restaurant.pictureId,
                  child: Image.network(
                      'https://restaurant-api.dicoding.dev/images/large/${restaurant.pictureId}')),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(restaurant.name,
                                style: Styles.restaurantItemName),
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
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Padding(padding: EdgeInsets.only(top: 2)),
                            Row(
                              children: [
                                const Icon(
                                  CupertinoIcons.star_fill,
                                  size: 13,
                                  color: Colors.amber,
                                ),
                                const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 2)),
                                Text(
                                  '${restaurant.rating}',
                                  style: Styles.restaurantItemPreview,
                                )
                              ],
                            ),
                            const SizedBox(height: 4),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  backgroundColor: Colors.white,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(18),
                                      topRight: Radius.circular(18),
                                    ),
                                  ),
                                  builder: (context) {
                                    return PopUpReview(
                                      provider: provider,
                                      restaurant: restaurant,
                                    );
                                  },
                                );
                              },
                              child: Text(
                                'See Details',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        color: Colors.greenAccent,
                                        decoration: TextDecoration.underline),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 5),
                    const Divider(color: Colors.grey),
                    const Text(
                      "Categories",
                      style: Styles.restaurantTitleCategories,
                    ),
                    SizedBox(
                      height: 35,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: restaurant.categories.map((category) {
                          return Container(
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.cyan,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Text(
                                category.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 2)),
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
