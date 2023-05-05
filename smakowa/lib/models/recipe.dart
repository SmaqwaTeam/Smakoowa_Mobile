import 'package:flutter/material.dart';
import 'package:http/http.dart';

Map<int, dynamic> timeToServe = {
  0: 'up to 15 min',
  1: '15-30 min',
  2: '30-45 min',
  3: '45-60 min',
  4: 'over 60 min'
};

class Recipe {
  final int id;
  final String name;
  // final String description;
  final String time;
  final String? imageId;
  // final double rating;

  Recipe({
    required this.id,
    required this.name,
    // required this.description,
    required this.time,
    this.imageId,
    // required this.rating,
  });

  factory Recipe.fromJson(
    Map<String, dynamic> json,
  ) {
    int timeValue = json['timeToMakeTier'];

    return Recipe(
      id: json['id'],
      name: json['name'],
      // description: json['description'],
      time: timeToServe[timeValue],
      imageId: json['imageId'],
      // rating: json['rating'],
    );
  }

  // static List<Recipe> recipeFromSnapshot(List snapshot) {
  //   return snapshot.map((data) {
  //     return Recipe.fromJson(data,);
  //   }).toList();
  // }
}


// json['timeToMakeTier']