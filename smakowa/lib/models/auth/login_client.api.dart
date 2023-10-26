import 'dart:io';
// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:smakowa/main.dart';
import 'package:smakowa/utils/endpoints.api.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../utils/customDialogs.dart';

class LoginApiClient extends GetxController {
  final Future<SharedPreferences> _userData = SharedPreferences.getInstance();

  final storage = new FlutterSecureStorage();

  Future<void> login(String name, String password) async {
    Map data = {
      'userName': name,
      'password': password,
    };
    // var body = json.encode(data);
    try {
      final response = await http.post(
        Uri.parse(ApiEndPoints.baseUrl + '/api/Account/Login'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'text/plain',
        },
        body: jsonEncode(data),
      );

      // print(responce.statusCode);
      if (response.statusCode == 200) {
        final decode = jsonDecode(response.body);
        var token = decode['content']['token'];

        await storage.write(key: 'access', value: token);
        await storage.write(
            key: 'userName', value: decode['content']['user']['username']);
        await storage.write(
            key: 'userId', value: decode['content']['user']['id'].toString());
        await storage.write(
            key: 'userEmail', value: decode['content']['user']['email']);

        // var value = await storage.read(key: 'userName');
        // print(value);
        showDialog(
            context: Get.context!,
            builder: (context) {
              return AlertDialog(
                title: Text("Success"),
                content: Text(decode['message'].toString()),
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
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      print(e.toString());

      CustomShowDialog('Error', e.toString());
    }
  }
}
