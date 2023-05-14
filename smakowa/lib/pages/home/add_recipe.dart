import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smakowa/models/recipe.api.dart';
import 'package:smakowa/models/recipe.dart';
import 'package:smakowa/models/tags.dart';

import '../../models/category.api.dart';
import '../../models/category.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../models/tags.api.dart';

class AddRecipe extends StatefulWidget {
  const AddRecipe({super.key});

  @override
  State<AddRecipe> createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  final _formKey = GlobalKey<FormState>();
  List<String> ingredintsList = [];
  List<String> instrictionsList = [];
  List<int> tagsConfirmList = [];
  late Future<List<Categories>> futureCategories;
  late Future<List<Tags>> futureTags;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController _ingrednitsController = TextEditingController();
  final TextEditingController _instructionsController = TextEditingController();
  final TextEditingController tagController = TextEditingController();

  int catergoryId = 1;

  double _currentServingsTierValue = 1;
  double _currentTimeToMake = 1;

  @override
  void initState() {
    super.initState();
    futureCategories = CategoryApiList().getCategory();
    futureTags = TagsApiList().getTags();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Recipe'),
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
            bottom: 15,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 30),
                CustomFormTextField(
                  textControler: nameController,
                  labelText: 'Title',
                  hintText: 'Enter title',
                ),
                const SizedBox(height: 15),
                CustomFormTextField(
                  textControler: descriptionController,
                  labelText: 'Description',
                  hintText: 'Describe your recipe',
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    const Text('Select Category'),
                    const SizedBox(width: 15),
                    SizedBox(
                      width: 350,
                      child: FutureBuilder<List<Categories>>(
                          future: futureCategories,
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              List<Categories> categoryDropDown = snapshot.data;
                              return DropdownButtonFormField(
                                value: categoryDropDown.first.id,
                                items: categoryDropDown
                                    .map((item) => DropdownMenuItem(
                                          value: item.id,
                                          child: Text(item.categoryName),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    catergoryId = value!;
                                  });
                                },
                              );
                            } else {
                              return const CircularProgressIndicator();
                            }
                          }),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    const Text(
                      'Select Tags  ',
                      style: TextStyle(fontSize: 15),
                    ),
                    const SizedBox(width: 20),
                    SizedBox(
                      width: 350,
                      child: FutureBuilder(
                        future: futureTags,
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            List<Tags> tagDropDown = snapshot.data;
                            return MultiSelectDialogField(
                              items: tagDropDown
                                  .map((item) => MultiSelectItem(
                                        item.id,
                                        item.tagName,
                                      ))
                                  .toList(),
                              listType: MultiSelectListType.CHIP,
                              onConfirm: (value) {
                                setState(() {
                                  tagsConfirmList = value;
                                });
                              },
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 15,
                    bottom: 5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Servings tier "),
                      SizedBox(
                        width: 200,
                        child: Slider(
                            //double type!!!
                            value: _currentServingsTierValue,
                            max: 4,
                            min: 0,
                            divisions: 4,
                            label: _currentServingsTierValue.round().toString(),
                            onChanged: (double value) {
                              setState(() {
                                _currentServingsTierValue = value;
                              });
                            }),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 15,
                    bottom: 5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Time to make "),
                      SizedBox(
                        width: 200,
                        child: Slider(
                            //double type!!!
                            value: _currentTimeToMake,
                            max: 4,
                            min: 0,
                            divisions: 4,
                            label: _currentTimeToMake.round().toString(),
                            onChanged: (double value) {
                              setState(() {
                                _currentTimeToMake = value;
                              });
                            }),
                      ),
                    ],
                  ),
                ),
                ingredintsList.isEmpty
                    ? Text('')
                    : const Text(
                        'Ingredients',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black87,
                        ),
                      ),
                SafeArea(
                  child: ingredientsPreviewList(ingredintsList),
                ),
                rowTextFormInput('Ingredient', 'Enter ingredient',
                    _ingrednitsController, ingredintsList),
                const SizedBox(height: 10),
                instrictionsList.isEmpty
                    ? Text('')
                    : const Text(
                        'Instructions',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black87,
                        ),
                      ),
                SafeArea(
                  child: ingredientsPreviewList(instrictionsList),
                ),
                rowTextFormInput(
                  'Instruction',
                  'Enter Instruction',
                  _instructionsController,
                  instrictionsList,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                      try {
                        print(tagsConfirmList[0]);
                        var newRecipe = createRecipeAddObject(
                          nameController.text,
                          descriptionController.text,
                          ingredintsList,
                          instrictionsList,
                          tagsConfirmList,
                          catergoryId,
                          _currentServingsTierValue,
                          _currentTimeToMake,
                        );
                        RecipeDetailsApi().postRecipe(newRecipe);
                      } catch (e) {
                        print(e);
                      }

                      // nameController.clear();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 60,
                      vertical: 20,
                    ),
                  ),
                  child: const Text(
                    'Create',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 22),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row rowTextFormInput(String label, hinit,
      TextEditingController inputControler, List<dynamic> list) {
    return Row(
      children: [
        Text(
          label,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
            bottom: 0,
          ),
          child: SizedBox(
            width: 300,
            height: 50,
            child: TextFormField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(50),
              ],
              controller: inputControler,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Input ',
                hintText: '',
              ),
            ),
          ),
        ),
        SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                list.add(inputControler.text);
                inputControler.text = "";
              });
            },
            child: Text(
              'Add',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  ListView ingredientsPreviewList(List<dynamic> list) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (_, index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0x33FF5C4D)),
                  child: Text(list[index]),
                ),
              ),
              SizedBox(
                height: 25,
                width: 30,
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        list.remove(list[index]);
                      });
                    },
                    child: Text('X')),
              ),
            ],
          );
        });
  }
}

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
