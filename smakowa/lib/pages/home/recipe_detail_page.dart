import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smakowa/models/likes.api.dart';
import 'package:smakowa/models/recipe.api.dart';
import 'package:smakowa/pages/home/comments_page.dart';

import '../../models/recipe.dart';
import '../../utils/endpoints.api.dart';
import '../widget/elevation_button_custom.dart';
import '../widget/icon_text_detail_recipe.dart';
import '../widget/ingerdiens_instr_list.dart';

class RecipeDetailsPage extends StatefulWidget {
  const RecipeDetailsPage(
      {super.key, required this.recipeId, this.deleteViewAccess});
  final int recipeId;
  final bool? deleteViewAccess;

  @override
  State<RecipeDetailsPage> createState() => _RecipeDetailsPageState();
}

class _RecipeDetailsPageState extends State<RecipeDetailsPage> {
  late Future<RecipeDeatil> futureRecipeDetail;
  // late RecipeDeatil? recipeDetail;

  @override
  void initState() {
    futureRecipeDetail = RecipeDetailsApi().getRecipeDetail(widget.recipeId);

    super.initState();
    loadRecipeDetails();
  }

  loadRecipeDetails() async {
    final result = await RecipeDetailsApi().getRecipeDetail(widget.recipeId);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder<RecipeDeatil>(
            future: futureRecipeDetail,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                RecipeDeatil recipe = snapshot.data;
                return Column(
                  children: [
                    Stack(
                      children: [
                        Image.network(
                          recipe.imageId == null
                              ? 'https://images.immediate.co.uk/production/volatile/sites/30/2020/08/chorizo-mozarella-gnocchi-bake-cropped-9ab73a3.jpg?quality=90&resize=556,505'
                              : '${ApiEndPoints.baseUrl}/api/Images/GetRecipeImage/${recipe.imageId}',
                          height: 250.0,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          top: 15,
                          left: 15,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 4,
                                    )
                                  ]),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.arrow_back,
                                    color: Colors.white.withOpacity(0.8),
                                    size: 30,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -1.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            height: 15.0,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.0),
                                topRight: Radius.circular(30.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 0.0,
                        bottom: 15.0,
                        left: 15.0,
                        right: 15.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                recipe.name,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w700),
                              ),
                              InkWell(
                                child: const Icon(
                                  Icons.favorite_border,
                                  color: Colors.black54,
                                ),
                                onTap: () {
                                  LikeRecipe().likeRecipe(recipe.id);
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 15.0),
                          Text(
                            recipe.description,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconText(
                                icon: Icons.access_time,
                                text: '${mapTimeToServe(recipe.time)}',
                              ),
                              IconText(
                                icon: Icons.room_service,
                                text: 'Serving tier  ${recipe.servingsTier}',
                              ),
                              IconText(
                                icon: Icons.person,
                                text: recipe.creator!,
                              ),
                              IconText(
                                icon: Icons.favorite,
                                text: recipe.likeCount.toString(),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10.0),
                          const Divider(
                            thickness: 0.3,
                            color: Colors.black54,
                          ),
                          RecipeIngredientsList(
                            recipeInfo: recipe.ingredients,
                          ),
                          RecipeInstructionList(
                            recipeInfo: recipe.instructions,
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomElevationButton(
                                title: 'Comments (${recipe.comments!.length})',
                                onPress: () {
                                  Get.to(CommentsPage(
                                    comments: recipe.comments!,
                                    recipeId: recipe.id,
                                  ));
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          widget.deleteViewAccess != null
                              ? Center(
                                  child: CustomElevationButton(
                                    title: 'Delete',
                                    customBackgroundColor: Colors.red,
                                    onPress: () {
                                      DeleteDialog(recipe);
                                    },
                                  ),
                                )
                              : Text(''),
                        ],
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('Error ${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }

  Future<dynamic> DeleteDialog(RecipeDeatil recipe) {
    return showDialog(
        context: Get.context!,
        builder: (context) {
          return AlertDialog(
            title: Text("Warring"),
            content: Text('Are you sure to delete this recipe?'),
            actions: [
              TextButton(
                onPressed: () {
                  RecipeApi().deleteRecipe(recipe.id);
                },
                child: const Text('Yes'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('No'),
              )
            ],
          );
        });
  }
}

mapTimeToServe(int timeId) {
  int timeValue = timeId;
  return timeToServe[timeValue];
}

Map<int, dynamic> timeToServe = {
  0: 'up to 15 min',
  1: '15-30 min',
  2: '30-45 min',
  3: '45-60 min',
  4: 'over 60 min'
};
