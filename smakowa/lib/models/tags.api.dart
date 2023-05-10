import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:smakowa/models/category.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smakowa/models/tags.dart';
import 'package:smakowa/utils/endpoints.api.dart';

class TagsApiList {
  Future<List<Tags>> getTags() async {
    final response = await http.get(
      Uri.parse(
        ApiEndPoints.baseUrl + '/api/Tags/GetAll',
      ),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final List<Tags> tags = [];

      for (var i = 0; i < data['content'].length; i++) {
        final entry = data['content'][i];

        tags.add(
          Tags.fromJson(entry),
        );
      }

      return tags;
    } else {
      throw Exception('Failed to load tags');
    }
  }
}
