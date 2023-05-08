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
  final String time;
  final String? imageId;

  Recipe({
    required this.id,
    required this.name,
    required this.time,
    this.imageId,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    int timeValue = json['timeToMakeTier'];

    return Recipe(
      id: json['id'],
      name: json['name'],
      time: timeToServe[timeValue],
      imageId: json['imageId'],
    );
  }
}

class RecipeDeatil {
  final int id;
  final String name;
  final String time;
  final int sevingTier;
  final String? imageId;
  final String description;
  // final List<int> tagsId;
  final int categoryId;
  // final String creator;
  final List<Ingredients> ingredients;
  final List<Instructions> instructions;
  // final Data createdAt;
  // final int likeCount;

  RecipeDeatil({
    required this.id,
    required this.name,
    required this.time,
    required this.imageId,
    required this.sevingTier,
    required this.description,
    required this.categoryId,
    required this.ingredients,
    required this.instructions,
    // required this.likeCount,
  });

  factory RecipeDeatil.fromJson(Map<String, dynamic> json,
      List<Ingredients> ingredients, List<Instructions> instructions) {
    int timeValue = json['timeToMakeTier'];

    return RecipeDeatil(
      id: json['id'],
      name: json['name'],
      imageId: json['imageId'],
      sevingTier: json['servingsTier'],
      time: timeToServe[timeValue],
      description: json['description'],
      categoryId: json['categoryId'],
      ingredients: ingredients,
      instructions: instructions,
    );
  }
}

class Ingredients {
  final int id;
  final String name;
  final int position;
  final int group;

  Ingredients({
    required this.id,
    required this.name,
    required this.position,
    required this.group,
  });

  factory Ingredients.fromJson(Map<String, dynamic> json) {
    return Ingredients(
      id: json['id'],
      name: json['name'],
      position: json['position'],
      group: json['group'],
    );
  }
  String getName() {
    return name;
  }
}

class Instructions {
  final int id;
  final String content;
  final int position;
  final String? imgUrl;

  Instructions({
    required this.id,
    required this.content,
    required this.position,
    this.imgUrl,
  });

  factory Instructions.fromJson(Map<String, dynamic> json) {
    return Instructions(
      id: json['id'],
      content: json['content'],
      position: json['position'],
      imgUrl: json['imgUrl'],
    );
  }
  String getName() {
    return content;
  }
}
