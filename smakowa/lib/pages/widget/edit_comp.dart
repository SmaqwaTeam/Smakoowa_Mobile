import 'package:flutter/material.dart';

import '../../models/recipe.dart';

RecipeAdd createRecipeAddObject(
  String title,
  descrption,
  List<String> ingredients,
  List<String> instructions,
  List<int> tags,
  int category,
  double servings,
  timeTomake,
) {
  List<Ingredients> ingredientsObjectList = [];
  List<Instructions> instructionObjectList = [];

  const int group = 1;
  int position = 1;

  for (var i = 0; i < ingredients.length; i++) {
    ingredientsObjectList.add(
        Ingredients(name: ingredients[i], group: group, position: position));
    position++;
  }

  for (var i = 0; i < instructions.length; i++) {
    instructionObjectList.add(Instructions(
      content: instructions[i],
      position: position,
    ));
    position++;
  }

  return RecipeAdd(
    name: title,
    description: descrption,
    servingsTier: servings.toInt(),
    time: timeTomake.toInt(),
    categoryId: category,
    tagIds: tags,
    ingredients: ingredientsObjectList,
    instructions: instructionObjectList,
  );
}

RecipeDeatil createEditObject(
  int id,
  String title,
  descrption,
  List<String> ingredients,
  List<String> instructions,
  List<int> tags,
  int category,
  double servings,
  timeTomake,
) {
  List<Ingredients> ingredientsObjectList = [];
  List<Instructions> instructionObjectList = [];

  const int group = 1;
  int position = 1;

  for (var i = 0; i < ingredients.length; i++) {
    ingredientsObjectList.add(
        Ingredients(name: ingredients[i], group: group, position: position));
    position++;
  }

  for (var i = 0; i < instructions.length; i++) {
    instructionObjectList.add(Instructions(
      content: instructions[i],
      position: position,
    ));
    position++;
  }

  return RecipeDeatil(
    id: id,
    name: title,
    description: descrption,
    servingsTier: servings.toInt(),
    time: timeTomake.toInt(),
    categoryId: category,
    tagIds: tags,
    ingredients: ingredientsObjectList,
    instructions: instructionObjectList,
  );
}

class CustomFormTextField extends StatelessWidget {
  const CustomFormTextField(
      {super.key,
      required TextEditingController textControler,
      required this.labelText,
      required this.hintText})
      : _inputController = textControler;

  final TextEditingController _inputController;
  final String labelText;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _inputController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter ${labelText}';
        }
        return null;
      },
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelText,
        hintText: hintText,
      ),
    );
  }
}
