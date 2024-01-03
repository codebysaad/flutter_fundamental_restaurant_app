import 'package:flutter/material.dart';

class FavouriteTab extends StatefulWidget {
  const FavouriteTab({Key? key}) : super(key: key);

  @override
  _FavouriteTabState createState() => _FavouriteTabState();
}

class _FavouriteTabState extends State<FavouriteTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite Page'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/images/favourite.jpg', width: 200),
              const SizedBox(height: 24.0),
              Text(
                "Favourite Page",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}