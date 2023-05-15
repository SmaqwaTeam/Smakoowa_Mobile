import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smakowa/models/auth/user_data.dart';
import 'package:smakowa/models/comments.api.dart';
import 'package:smakowa/models/likes.api.dart';
import 'package:smakowa/models/recipe.dart';
import 'package:smakowa/pages/widget/elevation_button_custom.dart';

import '../../utils/formatDate.dart';
import '../widget/icon_text_detail_recipe.dart';
import 'comment_add.dart';

class CommentsPage extends StatefulWidget {
  const CommentsPage(
      {super.key, required this.comments, required this.recipeId});

  final List<Comment> comments;
  final int recipeId;

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  late int? currentUserId = null;

  @override
  void initState() {
    super.initState();
    getLoginUserId();
  }

  Future getLoginUserId() async {
    final String? temp = await UserData.getUserId();

    setState(() {
      currentUserId = int.tryParse(temp ?? '0');
    });
  }

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
              itemCount: widget.comments.length,
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
                          widget.comments[index].content,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              LikeComment()
                                  .likeCommnet(widget.comments[index].id);
                            },
                            icon: Icon(Icons.favorite_border),
                          ),
                          currentUserId == widget.comments[index].creatorId
                              ? Row(
                                  children: [
                                    // IconButton(
                                    //   onPressed: () {},
                                    //   icon: const Icon(Icons.edit),
                                    // ),
                                    IconButton(
                                      onPressed: () {
                                        CommentRecipe().deleteComment(
                                            widget.comments[index].id);
                                      },
                                      icon: const Icon(Icons.delete),
                                    ),
                                  ],
                                )
                              : const Text(''),
                        ],
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconText(
                              icon: Icons.favorite,
                              text: widget.comments[index].likeCount.toString(),
                            ),
                            IconText(
                              icon: Icons.date_range_rounded,
                              text: getFormattedDate(
                                  widget.comments[index].createdAt),
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
                    recipeId: widget.recipeId,
                  ));
                })
          ],
        ),
      ),
    );
  }
}
