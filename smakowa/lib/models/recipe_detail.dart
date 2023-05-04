import 'package:http/http.dart';

class Recipe {
  final int id;
  final String name;
  // final String description;
  final int time;
  // final double rating;

  Recipe({
    required this.id,
    required this.name,
    // required this.description,
    required this.time,
    // required this.rating,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      name: json['name'],
      // description: json['description'],
      time: json['timeToMakeTier'],
      // rating: json['rating'],
    );
  }

  static List<Recipe> recipeFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Recipe.fromJson(data);
    }).toList();
  }
}
