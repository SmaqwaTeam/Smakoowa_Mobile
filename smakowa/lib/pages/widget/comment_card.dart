import 'package:flutter/material.dart';

import 'icon_text_detail_recipe.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({super.key});

  @override
  Widget build(BuildContext context) {
    final String commentContent;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey)),
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'comments[index].content,',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.delete),
              ),
            ],
          ),
          subtitle: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconText(
                  icon: Icons.person,
                  text: 'person',
                ),
                IconText(
                  icon: Icons.favorite,
                  text: 'omments[index].likeCount.toString(),',
                ),
                IconText(
                  icon: Icons.date_range_rounded,
                  text: 'omments[index].createdAt',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
