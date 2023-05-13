import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smakowa/pages/home/recipe_detail_page.dart';
import 'package:smakowa/pages/widget/recipe_card.dart';

import '../../models/recipe.api.dart';
import '../../models/recipe.dart';
import '../../utils/endpoints.api.dart';

class SearchResultPage extends StatefulWidget {
  SearchResultPage({super.key, this.keyWord});

  String? keyWord;

  @override
  State<SearchResultPage> createState() => _SearchResultPage();
}

class _SearchResultPage extends State<SearchResultPage> {
  late Future<List<Recipe>> futureRecipes;

  int recipeCount = 20;

  late String endpoint =
      '${ApiEndPoints.baseUrl}/api/Recipes/SearchRecipesByName?querry=${widget.keyWord}';

  @override
  void initState() {
    super.initState();
    // loadRecipe();

    futureRecipes = RecipeApi().getRecipe(endpoint);
  }

  loadMoreRecipes() async {
    setState(() {
      recipeCount += 5;
      endpoint =
          '${ApiEndPoints.baseUrl}/api/Recipes/GetAll?recipeCount=$recipeCount';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: FutureBuilder<List<Recipe>>(
        future: futureRecipes,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
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
    ));
  }
}
