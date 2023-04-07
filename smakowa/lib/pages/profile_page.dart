import 'package:flutter/material.dart';
import 'package:smakowa/pages/login_page.dart';
import 'package:smakowa/pages/profile_details.dart';
import 'package:smakowa/pages/register_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isLogin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const ProfileDetail(),
    );
  }
}
