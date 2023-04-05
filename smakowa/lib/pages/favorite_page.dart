import 'package:flutter/material.dart';
import 'package:smakowa/pages/test_routing.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
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
                    return const TestPage();
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
