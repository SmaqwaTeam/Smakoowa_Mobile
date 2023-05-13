import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smakowa/pages/home/recipe_detail_page.dart';
import 'package:smakowa/pages/widget/edit_recipe_card.dart';
import 'package:smakowa/pages/widget/recipe_card.dart';

import '../../models/recipe.api.dart';
import '../../models/recipe.dart';
import '../../utils/endpoints.api.dart';

class CurrentUserRecipes extends StatefulWidget {
  const CurrentUserRecipes({super.key, required});

  @override
  State<CurrentUserRecipes> createState() => _CurrentUserRecipes();
}

class _CurrentUserRecipes extends State<CurrentUserRecipes> {
  late Future<List<Recipe>> futureRecipes;
  final String endpoint =
      '${ApiEndPoints.baseUrl}/api/Recipes/GetCurrentUsersRecipes';

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
      print(futureRecipes);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My recipes'),
        ),
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
                      return EditRecipeCard(
                        title: recipe.name,
                        description: recipe.description,
                        // cookTime: recipe.time.toString(),
                        thumbnailUrl: recipe.imageId,
                        editOnPress: () {},
                        onPress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                final userLogged = true;
                                return RecipeDetailsPage(
                                  recipeId: recipe.id,
                                  isLogin: userLogged,
                                );
                              },
                            ),
                          );
                        },
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
