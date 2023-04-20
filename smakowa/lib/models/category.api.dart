import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:smakowa/models/category.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smakowa/utils/endpoints.api.dart';

class CategoryApiList {
  Future<List<Categories>> getCategory() async {
    final response = await http.get(
      Uri.parse(
        ApiEndPoints.baseUrl + '/api/Categories/GetAll',
      ),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final List<Categories> category = [];

      for (var i = 0; i < data['content'].length; i++) {
        final entry = data['content'][i];

        category.add(
          Categories.fromJson(entry),
        );
      }

      return category;
    } else {
      throw Exception('Failed to load category');
    }
  }
}
