import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smakowa/pages/home/recipe_detail_page.dart';
import 'package:smakowa/pages/widget/recipe_card.dart';

import '../../models/recipe.api.dart';
import '../../models/recipe.dart';
import '../../utils/endpoints.api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Recipe>> futureRecipes;
  int recipeCount = 20;

  late String endpoint =
      '${ApiEndPoints.baseUrl}/api/Recipes/GetAll?recipeCount=$recipeCount';

  @override
  void initState() {
    super.initState();
    // loadRecipe();

    futureRecipes = RecipeApi().getRecipe(endpoint);
  }

  reloadRecipes() async {
    var newRecipe = await await RecipeApi().getRecipe(endpoint);
    setState(() {
      futureRecipes = Future.value(newRecipe);
    });
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
        body: RefreshIndicator(
      onRefresh: () async {
        reloadRecipes();
      },
      child: Center(
        child: FutureBuilder<List<Recipe>>(
          future: futureRecipes,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  Recipe recipe = snapshot.data?[index];
                  return GestureDetector(
                    onTap: () {
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
