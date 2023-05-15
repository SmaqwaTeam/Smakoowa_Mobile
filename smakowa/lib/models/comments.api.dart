import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:smakowa/models/auth/user_data.dart';
import 'dart:convert';

import '../main.dart';
import '../utils/endpoints.api.dart';

class CommentRecipe {
  Future<void> postComment(String content, int recipeId) async {
    Map<String, dynamic> data = {
      'content': content,
    };

    final token = await UserData.getUserToken();

    try {
      final response = await http.post(
        Uri.parse(
            ApiEndPoints.baseUrl + '/api/Comments/AddRecipeComment/$recipeId'),
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

  Future<void> deleteComment(int recipeId) async {
    final token = await UserData.getUserToken();

    try {
      final response = await http.delete(
        Uri.parse(ApiEndPoints.baseUrl +
            '/api/Comments/DeleteRecipeComment/$recipeId'),
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
