import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

Future<dynamic> CustomShowDialog(String title, String content) {
  return showDialog(
      context: Get.context!,
      builder: (context) {
        return SimpleDialog(
          title: Text(title),
          contentPadding: const EdgeInsets.all(20),
          children: [
            Text(content),
          ],
        );
      });
}
