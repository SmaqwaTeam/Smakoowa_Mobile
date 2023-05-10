import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smakowa/models/auth/user_data.dart';
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
      // for (var i = 0; i < json['content']['ingredients'].length; i++) {
      //   final temp = json['content']['ingredients'][i]['name'];

      //   ingList.add(
      //     temp,
      //   );
      // }

      final ingrediendts = (json['content']['ingredients'] as List)
          .map((e) => Ingredients.fromJson(e))
          .toList();

      final instructions = (json['content']['instructions'] as List)
          .map((e) => Instructions.fromJson(e))
          .toList();

      final recipeDetail =
          RecipeDeatil.fromJson(entry, ingrediendts, instructions);

      // print(entry);
      return recipeDetail;
    } else {
      throw Exception('Failed to load recipe');
    }
  }
}

class RecipeSendApi {
  Future<void> postRecipe(RecipeAdd recipe) async {
    Map data = recipe.toJson();

    final token = await UserData.getUserToken();
    print('Bearer ${token}');
    try {
      final response = await http.post(
        Uri.parse(ApiEndPoints.baseUrl + '/api/Recipes/Create'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'text/plain',
          HttpHeaders.authorizationHeader: 'Bearer ${token}',
        },
        body: jsonEncode(data),
      );
      print(recipe);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        print(json['message']);

        // print(entry);
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      print(e);
    }
  }
}
