import 'package:flutter/material.dart';

class NoLoginUserPage extends StatelessWidget {
  const NoLoginUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'To see favorite recipes login first',
            style: TextStyle(fontSize: 20),
          ),
        ],
      )),
    );
  }
}
