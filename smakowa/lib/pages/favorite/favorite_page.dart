import 'package:flutter/material.dart';
import 'package:smakowa/pages/home/recipe_detail_page.dart';
import 'package:smakowa/pages/test_routing.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final Future<SharedPreferences> _userData = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const Text("All what you like"),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return TestPage();
                  },
                ),
              );
            },
            child: const Text('Testing page '),
          ),
        ],
      ),
    );
  }
}
