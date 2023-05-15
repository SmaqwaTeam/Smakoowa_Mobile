import 'package:flutter/material.dart';

import '../../utils/endpoints.api.dart';

class EditRecipeCard extends StatelessWidget {
  final String title;
  final String description;
  // final String cookTime;
  final String? thumbnailUrl;
  final VoidCallback onPress;
  final VoidCallback editOnPress;

  const EditRecipeCard({
    super.key,
    required this.description,
    required this.onPress,
    required this.editOnPress,
    required this.title,
    this.thumbnailUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
      ),
      subtitle: Text(description),
      leading: Container(
        height: 120,
        width: 120,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.6),
              offset: const Offset(
                0.0,
                10.0,
              ),
              blurRadius: 10.0,
              spreadRadius: -6.0,
            ),
          ],
          image: DecorationImage(
            fit: BoxFit.cover,
            image: thumbnailUrl != null
                ? NetworkImage(
                    '${ApiEndPoints.baseUrl}/api/Images/GetRecipeImage/$thumbnailUrl')
                : const NetworkImage(
                    'https://cdn.discordapp.com/attachments/1027658629886791752/1107630008526180392/dish_1.png'),
          ),
        ),
      ),
      trailing: IconButton(
        icon: const Icon(
          Icons.edit_square,
          size: 22,
        ),
        onPressed: editOnPress,
      ),
      onTap: onPress,
      onLongPress: () {},
    );
  }
}
