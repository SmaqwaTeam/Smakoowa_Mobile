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
  late Future<RecipeDeatil> futureRecipeDetail;

  final String endpoint = ApiEndPoints.baseUrl + '/api/Recipes/GetAll';

  @override
  void initState() {
    super.initState();
    // loadRecipe();
    // loadRecipeDetails();
    futureRecipes = RecipeApi().getRecipe(endpoint);
  }

  loadRecipe() async {
    final result = await RecipeApi().getRecipe(endpoint);
    result.forEach((element) {
      print(element.name);
    });
  }

  loadRecipeDetails() async {
    final result = await RecipeDetailsApi(id: 1).getRecipeDetail();
    print(result.instructions);
  }

  // Future<void> fetchRecipes() async {
  //  final recipes = await RecipeApi().getRecipe();

  // }

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
                    // final recipeDetails =
                    //     RecipeDetailsApi(id: recipe.id).getRecipeDetail();
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


    // return RecipeCard(
    //                 title: recipe.name, cookTime: recipe.time.toString());