import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:smakowa/models/recipe.dart';

import '../utils/endpoints.api.dart';

class RecipeApi {
  Future<List<Recipe>> getRecipe(String url) async {
    final response = await http.get(
      Uri.parse(
        url,
      ),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final List<Recipe> recipe = [];

      for (var i = 0; i < data['content'].length; i++) {
        final entry = data['content'][i];

        recipe.add(
          Recipe.fromJson(entry),
        );
      }

      return recipe;
    } else {
      throw Exception('Failed to load recipes');
    }
  }
}

class RecipeDetailsApi {
  final int id;

  RecipeDetailsApi({
    required this.id,
  });

  Future<RecipeDeatil> getRecipeDetail() async {
    final response = await http.get(
      Uri.parse(
        ApiEndPoints.baseUrl + '/api/Recipes/GetByIdDetailed/${id}',
      ),
    );
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      List<String> ingList = [];

      final entry = json['content'];
      // List<String> ing = [];

      // albo dać List<String> i  tylko name

      final ingrediendts = (json['content']['ingredients'] as List)
          .map((e) => Ingredients.fromJson(e))
          .toList();

      // for (var i = 0; i < json['content']['ingredients'].length; i++) {
      //   final temp = json['content']['ingredients'][i]['name'];

      //   ingList.add(
      //     temp,
      //   );
      // }

      final instructions = (json['content']['instructions'] as List)
          .map((e) => Instructions.fromJson(e))
          .toList();

      final recipeDetail =
          RecipeDeatil.fromJson(entry, ingrediendts, instructions);

      // print(entry);
      return recipeDetail;
    } else {
      throw Exception('Fail to load recipe');
    }
  }
}
