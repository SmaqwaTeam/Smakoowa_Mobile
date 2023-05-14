import 'package:flutter/material.dart';

class CustomElevationButton extends StatelessWidget {
  const CustomElevationButton({
    super.key,
    required this.title,
    required this.onPress,
    this.customBackgroundColor,
  });
  final String title;
  final VoidCallback onPress;
  final Color? customBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: customBackgroundColor,
        padding: const EdgeInsets.symmetric(
          horizontal: 26,
          vertical: 20,
        ),
      ),
      onPressed: onPress,
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
    );
  }
}
