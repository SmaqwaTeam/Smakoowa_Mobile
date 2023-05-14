import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smakowa/models/likes.api.dart';
import 'package:smakowa/models/recipe.dart';
import 'package:smakowa/pages/widget/elevation_button_custom.dart';

import '../widget/icon_text_detail_recipe.dart';
import 'comment_add.dart';

class CommentsPage extends StatelessWidget {
  const CommentsPage(
      {super.key, required this.comments, required this.recipeId});

  final List<Comment> comments;
  final int recipeId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              //!!!!!
              shrinkWrap: true,
              itemCount: comments.length,
              itemBuilder: (context, index) {
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
                          comments[index].content,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              LikeComment().likeCommnet(comments[index].id);
                            },
                            
                            icon: Icon(Icons.favorite_border),
                          ),
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
                              text: comments[index].likeCount.toString(),
                            ),
                            IconText(
                              icon: Icons.date_range_rounded,
                              text: comments[index].createdAt,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            CustomElevationButton(
                title: "Add comment",
                onPress: () {
                  Get.to(CommentAddForm(
                    recipeId: recipeId,
                  ));
                })
          ],
        ),
      ),
    );
  }
}
