import 'dart:io';
// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:smakowa/main.dart';
import 'package:smakowa/pages/profile/login_page.dart';
import 'package:smakowa/utils/endpoints.api.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../utils/customDialogs.dart';

class RegisterApiClient extends GetxController {
  final storage = new FlutterSecureStorage();

  Future<void> login(String name, String email, String password) async {
    Map data = {
      'userName': name,
      'email': email,
      'password': password,
    };
    // var body = json.encode(data);
    try {
      final responce = await http.post(
        Uri.parse(ApiEndPoints.baseUrl + '/api/Account/Register'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'text/plain',
        },
        body: jsonEncode(data),
      );

      // print(responce.statusCode);
      if (responce.statusCode == 200) {
        final decode = jsonDecode(responce.body);

       
        showDialog(
            context: Get.context!,
            builder: (context) {
              return AlertDialog(
                title: Text("Register complete"),
                content:
                    Text(decode['message'].toString() + ' \nGo to login page'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Get.to(const LoginPage());
                    },
                    child: Text('OK'),
                  )
                ],
              );
            });
      } else {
        throw jsonDecode(responce.body)['message'];
      }
    } catch (e) {
      print(e.toString());

      CustomShowDialog('Error', e.toString());
    }
  }
}
