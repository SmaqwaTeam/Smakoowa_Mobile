import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smakowa/models/recipe.api.dart';

import '../../models/recipe.dart';
import '../widget/icon_text_detail_recipe.dart';
import '../widget/recipe_details_list.dart';

class RecipeDetailsPage extends StatefulWidget {
  const RecipeDetailsPage({super.key, required this.recipeId});
  final int recipeId;

  @override
  State<RecipeDetailsPage> createState() => _RecipeDetailsPageState();
}

class _RecipeDetailsPageState extends State<RecipeDetailsPage> {
  late Future<RecipeDeatil> futureRecipeDetail;
  // late RecipeDeatil? recipeDetail;

  @override
  void initState() {
    futureRecipeDetail =
        RecipeDetailsApi(id: widget.recipeId).getRecipeDetail();

    super.initState();
    loadRecipeDetails();
  }

  loadRecipeDetails() async {
    final result =
        await RecipeDetailsApi(id: widget.recipeId).getRecipeDetail();
    // print(result is RecipeDeatil ? 'yes' : 'no');
    // print(result.description);

    setState(() {});
    // return result;
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
                              : 'https://smakoowaapi.azurewebsites.net/api/Images/GetRecipeImage/${recipe.imageId}',
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
                          Text('Tag'),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(recipe.name),
                              InkWell(
                                child: const Icon(
                                  Icons.favorite_border,
                                  color: Colors.black54,
                                ),
                                onTap: () {
                                  print('My fav');
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconText(
                                icon: Icons.access_time,
                                text: '${recipe.time}',
                              ),
                              IconText(
                                icon: Icons.room_service,
                                text: 'Serving tier  ${recipe.servingsTier}',
                              ),
                              IconText(
                                icon: Icons.person,
                                text: ' person',
                              ),
                              IconText(
                                icon: Icons.favorite,
                                text: recipe.likeCount.toString(),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            recipe.description,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
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
}
