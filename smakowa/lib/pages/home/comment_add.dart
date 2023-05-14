import 'package:flutter/material.dart';
import 'package:smakowa/models/auth/login_client.api.dart';
import 'package:smakowa/pages/profile/register_page.dart';
import 'package:smakowa/pages/widget/elevation_button_custom.dart';

import '../../models/comments.api.dart';
import '../../models/recipe.api.dart';

class CommentAddForm extends StatefulWidget {
  const CommentAddForm({super.key, required this.recipeId});
  final int recipeId;
  @override
  State<CommentAddForm> createState() => _CommentAddForm();
}

class _CommentAddForm extends State<CommentAddForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Center(
                  child: Container(
                    height: 100,
                    width: 180,
                    padding: EdgeInsets.only(top: 30),
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.circular(15),
                    // ),
                    child: const Text(
                      'Comment',
                      style: TextStyle(
                        fontSize: 35,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                  bottom: 15,
                ),
                child: TextFormField(
                  controller: contentController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Invalid comment';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Comment',
                    hintText: 'Enter comment',
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomElevationButton(
                  title: 'Comment',
                  onPress: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                      CommentRecipe()
                          .postComment(contentController.text, widget.recipeId);
                      contentController.clear();
                    }
                  }),
              const SizedBox(
                height: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
