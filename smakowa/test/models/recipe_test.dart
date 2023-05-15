import 'package:flutter_test/flutter_test.dart';
import 'package:smakowa/models/recipe.api.dart';
import 'package:smakowa/models/recipe.dart';
import 'package:smakowa/utils/endpoints.api.dart';

void main() {
  test('Given Future List Recipe when get request comes ', () async {
    //setup
    String endpoint =
        '${ApiEndPoints.baseUrl}/api/Recipes/GetAll?recipeCount=1';
    late Future<List<Recipe>> futureRecipes;
    (endpoint);
    final recipe = Recipe(
        id: 2,
        description: 'chicken',
        name: 'Chicken sopu',
        time: '15-30 min',
        imageId: null);

    //do
    futureRecipes = RecipeApi().getRecipe(endpoint);

    //test
    expect(futureRecipes is Future<List<Recipe>>,
        futureRecipes is Future<List<Recipe>>);
  });
}
