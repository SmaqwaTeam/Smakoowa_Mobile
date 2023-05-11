import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smakowa/pages/profile/login_helper.dart';
import 'package:smakowa/pages/profile/profile_details.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../models/auth/user_data.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Widget? page;

  Future<void> canAccces() async {
    bool? isLogin = await UserData.isLogin();
    if (isLogin) {
      setState(() {
        page = ProfileDetail();
      });
    } else {
      setState(() {
        page = const ProfileHelpRoute();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    canAccces();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: page);
  }
}
