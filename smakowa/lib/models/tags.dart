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
