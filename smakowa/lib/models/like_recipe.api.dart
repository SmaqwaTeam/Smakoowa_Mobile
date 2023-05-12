import '../utils/endpoints.api.dart';
import 'auth/user_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class LikeRecipe {
  Future<void> likeRecipe(int recipeId) async {
    bool isLogin = await UserData.isLogin();

    if (isLogin) {
      final token = await UserData.getUserToken();

      try {
        final response = await http.post(
          Uri.parse(
              ApiEndPoints.baseUrl + '/api/Likes/AddRecipeLike/$recipeId'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
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
    } else {
      showDialog(
          context: Get.context!,
          builder: (context) {
            return const SimpleDialog(
              title: Text('Error'),
              contentPadding: const EdgeInsets.all(20),
              children: [
                Text('To add favorite recipe login first'),
              ],
            );
          });
    }
  }
}
