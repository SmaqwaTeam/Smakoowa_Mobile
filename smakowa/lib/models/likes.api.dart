import '../utils/customDialogs.dart';
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
        CustomShowDialog('Error', e.toString());
      }
    } else {
      CustomShowDialog('Error', 'To add favorite recipe login first');
    }
  }
}

class LikeComment {
  Future<void> likeCommnet(int commentId) async {
    bool isLogin = await UserData.isLogin();

    if (isLogin) {
      final token = await UserData.getUserToken();

      try {
        final response = await http.post(
          Uri.parse(ApiEndPoints.baseUrl +
              '/api/Likes/AddRecipeCommentLike/$commentId'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.acceptHeader: 'text/plain',
            HttpHeaders.authorizationHeader: 'Bearer ${token}',
          },
        );

        if (response.statusCode == 200) {
          final json = jsonDecode(response.body);

          CustomShowDialog('Success', json['message'].toString());
          // print(entry);
        } else {
          throw jsonDecode(response.body)['message'];
        }
      } catch (e) {
        print(e);
        CustomShowDialog('Error', e.toString());
      }
    } else {
      CustomShowDialog('Error', 'To like this comment login first');
    }
  }

  Future<void> disLikeComment(int commentId) async {
    bool isLogin = await UserData.isLogin();

    if (isLogin) {
      final token = await UserData.getUserToken();

      try {
        final response = await http.delete(
          Uri.parse(ApiEndPoints.baseUrl +
              '/api/Likes/RemoveRecipeCommentLike/$commentId'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.acceptHeader: 'text/plain',
            HttpHeaders.authorizationHeader: 'Bearer ${token}',
          },
        );

        if (response.statusCode == 200) {
          final json = jsonDecode(response.body);

          CustomShowDialog('Success', json['message'].toString());

          // print(entry);
        } else {
          throw jsonDecode(response.body)['message'];
        }
      } catch (e) {
        print(e);
        CustomShowDialog('Error', e.toString());
      }
    } else {
      CustomShowDialog('Error', 'To like this comment login first');
    }
  }
}


