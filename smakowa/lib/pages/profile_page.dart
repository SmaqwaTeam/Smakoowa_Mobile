import 'package:flutter/material.dart';
import 'package:smakowa/pages/login_page.dart';
import 'package:smakowa/pages/register_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const LoginPage(),
    );
  }
}
