import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smakowa/pages/profile/login_helper.dart';
import 'package:smakowa/pages/profile/login_page.dart';
import 'package:smakowa/pages/profile/profile_details.dart';
import 'package:smakowa/pages/profile/register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<void>? isLogin() async {
    // final Future<SharedPreferences> _userData = SharedPreferences.getInstance();
    // final SharedPreferences? userData = await _userData;

    final storage = const FlutterSecureStorage();

    var value = await storage.read(key: 'access');

    if (value == null) {
      setState(() {
        page = const ProfileHelpRoute();
      });
    } else {
      setState(() {
        page = ProfileDetail();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    isLogin();
  }

  Widget? page;
  // var isLogin = false.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: page);
  }
}