import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smakowa/pages/home/recipe_detail_page.dart';
import 'package:smakowa/pages/widget/recipe_card.dart';

import '../../models/recipe.api.dart';
import '../../models/recipe.dart';
import '../../utils/endpoints.api.dart';

class FavoriteRecipeList extends StatefulWidget {
  const FavoriteRecipeList({super.key, required});

  @override
  State<FavoriteRecipeList> createState() => _FavoriteRecipeList();
}

class _FavoriteRecipeList extends State<FavoriteRecipeList> {
  late Future<List<Recipe>> futureRecipes;
  final String endpoint =
      '${ApiEndPoints.baseUrl}/api/Recipes/GetLikedRecipies';

  @override
  void initState() {
    super.initState();
    // loadRecipe();
    futureRecipes = RecipeApi().getCurrentUSerRecipe(endpoint);
  }

  reloadRecipes() async {
    var newRecipe = await RecipeApi().getCurrentUSerRecipe(endpoint);
    setState(() {
      futureRecipes = Future.value(newRecipe);
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: RefreshIndicator(
        onRefresh: () async {
          reloadRecipes();
        },
        child: FutureBuilder<List<Recipe>>(
          future: futureRecipes,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.length == 0) {
                return const Center(
                  child: Text('Dont have content'),
                );
              }
              return ListView.builder(
                itemBuilder: (context, index) {
                  Recipe recipe = snapshot.data?[index];
                  return GestureDetector(
                    onTap: () {
                      // Get.to(RecipeDetailsPage(recipeId: recipe.id,));
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return RecipeDetailsPage(
                              recipeId: recipe.id,
                            );
                          },
                        ),
                      );
                      print(recipe.id);
                    },
                    child: RecipeCard(
                      title: recipe.name,
                      cookTime: recipe.time.toString(),
                      thumbnailUrl: recipe.imageId,
                    ),
                  );
                },
                itemCount: snapshot.data!.length,
              );
            } else if (snapshot.hasError) {
              return Text('Error ${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    ));
  }
}
