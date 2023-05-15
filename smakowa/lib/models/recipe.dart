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
  final String description;

  Recipe({
    required this.id,
    required this.name,
    required this.time,
    required this.description,
    this.imageId,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    int timeValue = json['timeToMakeTier'];

    return Recipe(
        id: json['id'],
        name: json['name'],
        time: timeToServe[timeValue],
        imageId: json['imageId'],
        description: json['description']);
  }
}

class RecipeDeatil {
  final int id;
  final String name;
  final int time; //zmiaina
  final int servingsTier;
  final String? imageId;
  final String description;
  final int categoryId;
  final String? creator;
  final List<Ingredients> ingredients;
  final List<Instructions> instructions;
  final List<Comment>? comments;
  final List<dynamic> tagIds;
  // final Data createdAt;
  final int? likeCount;

  RecipeDeatil({
    required this.id,
    required this.name,
    required this.time,
    this.imageId,
    required this.servingsTier,
    required this.description,
    required this.categoryId,
    required this.ingredients,
    required this.instructions,
    this.likeCount,
    this.creator,
    this.comments,
    required this.tagIds,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "servingsTier": servingsTier,
        "timeToMakeTier": time,
        "categoryId": categoryId,
        "tagIds": List<dynamic>.from(tagIds.map((x) => x)),
        "ingredients": List<dynamic>.from(ingredients.map((x) => x.toJson())),
        "instructions": List<dynamic>.from(instructions.map((x) => x.toJson())),
      };

  factory RecipeDeatil.fromJson(
    Map<String, dynamic> json,
    List<Ingredients> ingredients,
    List<Instructions> instructions,
    int likeCount,
    List<Comment> comments,
    List<dynamic> tags,
  ) {
    int timeValue = json['timeToMakeTier'];

    return RecipeDeatil(
      id: json['id'],
      name: json['name'],
      imageId: json['imageId'],
      servingsTier: json['servingsTier'],
      time: json['timeToMakeTier'],
      description: json['description'],
      categoryId: json['categoryId'],
      likeCount: likeCount,
      ingredients: ingredients,
      instructions: instructions,
      creator: json['creatorUsername'],
      comments: comments,
      tagIds: tags,
    );
  }
}

class RecipeAdd {
  final String name;
  final int time;
  final int servingsTier;
  final String? imageId;
  final String description;
  final List<int> tagIds;
  final int categoryId;
  final List<Ingredients> ingredients;
  final List<Instructions> instructions;

  RecipeAdd({
    required this.name,
    required this.time,
    this.imageId,
    required this.servingsTier,
    required this.description,
    required this.categoryId,
    required this.ingredients,
    required this.instructions,
    required this.tagIds,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "servingsTier": servingsTier,
        "timeToMakeTier": time,
        "categoryId": categoryId,
        "tagIds": List<dynamic>.from(tagIds.map((x) => x)),
        "ingredients": List<dynamic>.from(ingredients.map((x) => x.toJson())),
        "instructions": List<dynamic>.from(instructions.map((x) => x.toJson())),
      };
}

class Ingredients {
  final int? id;
  final String name;
  final int position;
  final int group;

  Ingredients({
    this.id,
    required this.name,
    required this.position,
    required this.group,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "position": position,
        "group": group,
      };

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
  final int? id;
  final String content;
  final int position;
  final String? imgUrl;

  Instructions({
    this.id,
    required this.content,
    required this.position,
    this.imgUrl,
  });

  Map<String, dynamic> toJson() => {
        "content": content,
        "position": position,
      };

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

class Comment {
  final int id;
  final String content;
  final int likeCount;
  final String createdAt;
  final int creatorId;

  Comment({
    required this.id,
    required this.content,
    required this.likeCount,
    required this.createdAt,
    required this.creatorId,
  });

  Map<String, dynamic> toJson() => {
        "content": content,
      };

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      content: json['content'],
      likeCount: json['likeCount'],
      createdAt: json['createdAt'],
      creatorId: json['creatorId'],
    );
  }
}
