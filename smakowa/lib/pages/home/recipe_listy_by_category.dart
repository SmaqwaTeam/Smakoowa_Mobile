import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smakowa/pages/home/recipe_detail_page.dart';
import 'package:smakowa/pages/widget/recipe_card.dart';

import '../../models/recipe.api.dart';
import '../../models/recipe.dart';
import '../../utils/endpoints.api.dart';

class CategoryCardList extends StatefulWidget {
  const CategoryCardList(
      {super.key, required this.categoryId, required this.categoryName});
  final int categoryId;
  final String categoryName;

  @override
  State<CategoryCardList> createState() => _CategoryCardList();
}

class _CategoryCardList extends State<CategoryCardList> {
  late Future<List<Recipe>> futureRecipes;

  @override
  void initState() {
    super.initState();
    // loadRecipe();
    final String endpoint =
        '${ApiEndPoints.baseUrl}/api/Recipes/GetRecipesByCategoryId?categoryId=${widget.categoryId}';
    futureRecipes = RecipeApi().getRecipe(endpoint);
  }

  // loadRecipe() async {
  //   final result = await RecipeApi().getRecipe(endpoint);
  //   result.forEach((element) {
  //     print(element.name);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.categoryName),
        ),
        body: Center(
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
        ));
  }
}
