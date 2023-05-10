// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserData {
  static final storage = new FlutterSecureStorage();

  static const _keyUsername = 'userName';
  static const _keyUserEmail = 'userEmail';
  static const _keyUserId = 'userId';
  static const _keyUserToken = 'access';

  static Future<String?> getUserToken() async =>
      await storage.read(key: _keyUserToken);

  static Future<String?> getUserName() async =>
      await storage.read(key: _keyUsername);

  static Future<String?> getUserEmail() async =>
      await storage.read(key: _keyUserEmail);

  static Future<String?> getUserId() async =>
      await storage.read(key: _keyUserId);

  static Future<void> logOut() async {
    await storage.deleteAll();
  }

  static Future<bool> isLogin() async {
    // final Future<SharedPreferences> _userData = SharedPreferences.getInstance();
    // final SharedPreferences? userData = await _userData;

    final storage = const FlutterSecureStorage();

    var value = await storage.read(key: 'access');

    if (value == null) {
      return false;
    } else {
      return true;
    }
  }
}
