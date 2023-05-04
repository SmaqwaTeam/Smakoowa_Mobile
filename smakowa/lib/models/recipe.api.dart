import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:smakowa/models/recipe.dart';

import '../utils/endpoints.api.dart';

 enum TimeToServe {
        t15min,
        from15To30Min,
        from30To45Min,
        from45To60Min,
        over60Min
    }
    
class RecipeApi {
 
  Future<List<Recipe>> getRecipe() async {
    final response = await http.get(
      Uri.parse(
        ApiEndPoints.baseUrl + '/api/Recipes/GetAll',
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
