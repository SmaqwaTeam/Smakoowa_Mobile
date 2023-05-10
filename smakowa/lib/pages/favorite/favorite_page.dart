import 'package:flutter/material.dart';
import 'package:smakowa/models/auth/user_data.dart';
import 'package:smakowa/pages/favorite/favorite_recipe_list.dart';
import 'package:smakowa/pages/home/recipe_detail_page.dart';
import 'package:smakowa/pages/test_routing.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  Widget? page;
  Future<void> canAccces() async {
    bool? isLogin = await UserData.isLogin();
    if (isLogin) {
      setState(() {
        page = const FavoriteRecipeList();
      });
    } else {
      setState(() {
        page = const TestPage();
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    canAccces();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: page,
    );
  }
}
