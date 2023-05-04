import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smakowa/pages/profile/login_page.dart';
import 'package:smakowa/pages/profile/profile_page.dart';
import 'package:smakowa/pages/profile/register_page.dart';

class ProfileHelpRoute extends StatelessWidget {
  const ProfileHelpRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 40,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // const Text('Profile Page',
              //     style: TextStyle(
              //       fontSize: 40,
              //     )),
              const SizedBox(height: 50),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.only(
                    top: 22,
                    bottom: 22,
                    left: 50,
                    right: 50,
                  ),
                ),
                onPressed: () {
                  Get.to(const LoginPage());
                },
                child: const Text(
                  'Go to Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Get.to(const RegisterPage());
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(22),
                ),
                child: const Text(
                  'Go to Registration',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
