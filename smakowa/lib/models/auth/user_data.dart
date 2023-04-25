import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smakowa/main.dart';
import 'package:get/get.dart';

class UserData {
  static final storage = new FlutterSecureStorage();

  static const _keyUsername = 'userName';
  static const _keyUserEmail = 'userEmail';
  static const _keyUserId = 'userId';

  static Future<String?> getUserName() async =>
      await storage.read(key: _keyUsername);

  static Future<String?> getUserEmail() async =>
      await storage.read(key: _keyUserEmail);

  static Future<String?> getUserId() async =>
      await storage.read(key: _keyUserId);

  static Future<void> logOut() async {
    await storage.deleteAll();
  }
}
