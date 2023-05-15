import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:smakowa/models/auth/user_data.dart';
import 'dart:convert';

import 'package:smakowa/models/recipe.dart';

import '../main.dart';
import '../utils/endpoints.api.dart';
import 'package:dio/dio.dart' as dioo;
import 'package:dio_http2_adapter/dio_http2_adapter.dart' as dioHttp;

class RecipeApi {
  Future<List<Recipe>> getRecipe(String url) async {
    final token = await UserData.getUserToken();
    final response = await http.get(
      Uri.parse(url),
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
      print(jsonDecode(response.body)['message']);
      throw Exception('Failed to load recipes');
    }
  }

  Future<List<Recipe>> getCurrentUSerRecipe(String url) async {
    final token = await UserData.getUserToken();
    final response = await http.get(
      Uri.parse(url),
      headers: {
        //is save to send token i get?
        HttpHeaders.acceptHeader: 'text/plain',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
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
      print(jsonDecode(response.body)['message']);
      throw Exception('Failed to load recipes');
    }
  }

  Future<void> deleteRecipe(int recipeId) async {
    final token = await UserData.getUserToken();

    try {
      final response = await http.delete(
        Uri.parse(ApiEndPoints.baseUrl + '/api/Recipes/Delete/$recipeId'),
        headers: {
          HttpHeaders.acceptHeader: 'text/plain',
          HttpHeaders.authorizationHeader: 'Bearer ${token}',
        },
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        showDialog(
            context: Get.context!,
            builder: (context) {
              return AlertDialog(
                title: Text("Success"),
                content: Text(json['message'].toString()),
                actions: [
                  TextButton(
                    onPressed: () {
                      Get.off(const MyHomePage());
                    },
                    child: const Text('OK'),
                  )
                ],
              );
            });

        // print(entry);
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      print(e);
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: Text('Error'),
              contentPadding: const EdgeInsets.all(20),
              children: [Text(e.toString())],
            );
          });
    }
  }
}

class RecipeDetailsApi {
  Future<RecipeDeatil> getRecipeDetail(int id) async {
    final response = await http.get(
      Uri.parse(
        ApiEndPoints.baseUrl + '/api/Recipes/GetByIdDetailed/${id}',
      ),
    );
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      // List<int> tagsList = [];

      final entry = json['content'];
      final likeCount = json['content']['likes'].length;

      final ingrediendts = (json['content']['ingredients'] as List)
          .map((e) => Ingredients.fromJson(e))
          .toList();

      final instructions = (json['content']['instructions'] as List)
          .map((e) => Instructions.fromJson(e))
          .toList();

      final comments = (json['content']['recipeComments'] as List)
          .map((e) => Comment.fromJson(e))
          .toList();
      final tags = json['content']['tagIds'].toList();

      final recipeDetail = RecipeDeatil.fromJson(
          entry, ingrediendts, instructions, likeCount, comments, tags);

      return recipeDetail;
    } else {
      throw Exception('Failed to load recipe');
    }
  }

  Future<void> postRecipe(RecipeAdd recipe) async {
    Map data = recipe.toJson();

    final token = await UserData.getUserToken();

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

        showDialog(
            context: Get.context!,
            builder: (context) {
              return AlertDialog(
                title: Text("Success"),
                content: Text(json['message'].toString()),
                actions: [
                  TextButton(
                    onPressed: () {
                      Get.off(const MyHomePage());
                    },
                    child: const Text('OK'),
                  )
                ],
              );
            });

        // print(entry);
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      print(e);
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: Text('Error'),
              contentPadding: const EdgeInsets.all(20),
              children: [Text(e.toString())],
            );
          });
    }
  }

  Future<void> putRecipe(RecipeDeatil recipe, int recipeid) async {
    Map data = recipe.toJson();

    final token = await UserData.getUserToken();

    try {
      final response = await http.put(
        Uri.parse('${ApiEndPoints.baseUrl}/api/Recipes/Edit/${recipeid}'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'text/plain',
          HttpHeaders.authorizationHeader: 'Bearer ${token}',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        showDialog(
            context: Get.context!,
            builder: (context) {
              return AlertDialog(
                title: Text("Success"),
                content: Text(json['message'].toString()),
                actions: [
                  TextButton(
                    onPressed: () {
                      Get.off(const MyHomePage());
                    },
                    child: const Text('OK'),
                  )
                ],
              );
            });

        // print(entry);
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      print(e);
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: Text('Error'),
              contentPadding: const EdgeInsets.all(20),
              children: [Text(e.toString())],
            );
          });
    }
  }

  onUploadImage(File img, int id) async {
    final token = await UserData.getUserToken();
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(ApiEndPoints.baseUrl + '/api/Images/AddImageToRecipe/$id'),
    );
    Map<String, String> headers = {
      "Content-type": "multipart/form-data",
      "accept": "text/plain",
      "Authorization": "Bearer ${token}",
    };
    request.files.add(
      http.MultipartFile(
        'image',
        img.readAsBytes().asStream(),
        img.lengthSync(),
        filename: img.path.split('/').last,
      ),
    );
    request.headers.addAll(headers);
    print("request: " + request.toString());
    var res = await request.send();
    http.Response response = await http.Response.fromStream(res);
  }
}
  // uploadImage(File img, int id) async {
  //   final token = await UserData.getUserToken();
  //   var formData = dioo.FormData.fromMap(
  //     {
  //       "image": await dioo.MultipartFile.fromFile(img.path),
  //     },
  //   );
  //   var responce = dioo.Dio()
  //       .post(ApiEndPoints.baseUrl + '/api/Images/AddImageToRecipe/$id',
  //           options: dioo.Options(headers: {
  //             HttpHeaders.acceptHeader: 'text/plain',
  //             HttpHeaders.authorizationHeader: 'Bearer ${token}',
  //           }),
  //           data: formData);

  //   debugPrint(responce.toString());
  // }