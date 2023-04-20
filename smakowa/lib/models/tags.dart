import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Tags {
  final int id;
  final String tagName;
  final int tagType;

  Tags({
    required this.id,
    required this.tagName,
    required this.tagType,
  });

  factory Tags.fromJson(Map<String, dynamic> json) {
    return Tags(
      id: json['id'],
      tagName: json['name'],
      tagType: json['tagType'],
    );
  }
}

Future<List<Tags>> getTags() async {
  final response =
      await http.get(Uri.parse('https://localhost:7188/api/Tags/GetAll'));
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
    throw Exception('Failed to load album');
  }
}
