import 'dart:io';
import 'dart:js';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:smakowa/main.dart';
import 'package:smakowa/utils/endpoints.api.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginApiClient extends GetxController {
  final Future<SharedPreferences> _userData = SharedPreferences.getInstance();

  Future<void> login(String name, String password) async {
    Map data = {
      'userName': name,
      'password': password,
    };
    // var body = json.encode(data);
    try {
      final responce = await http.post(
        Uri.parse(ApiEndPoints.baseUrl + '/api/Account/Login'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'text/plain',
        },
        body: jsonEncode(data),
      );

      final decode = jsonDecode(responce.body);
      print(responce.statusCode);
      if (decode['statusCode'] == 200) {
        var token = decode['content']['token'];

        final SharedPreferences? userData = await _userData;
        Get.defaultDialog(
          title: 'Sucessfull Login',
          middleText: decode['message'].toString(),
        );

        await userData?.setString('token', token);
        // final String? action = userData!.getString('token');
        // Navigator.pop(data);

        Get.to(const MyHomePage());
        //redirekt
      } else {
        throw jsonDecode(responce.body)['message'];
      }
    } catch (e) {
      print(e.toString());

      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: Text('Error'),
              contentPadding: EdgeInsets.all(20),
              children: [Text(e.toString())],
            );
          });
    }
  }
}
