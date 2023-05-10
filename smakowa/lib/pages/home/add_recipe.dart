import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smakowa/models/recipe.api.dart';
import 'package:smakowa/models/recipe.dart';

class AddRecipe extends StatefulWidget {
  const AddRecipe({super.key});

  @override
  State<AddRecipe> createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  final _formKey = GlobalKey<FormState>();
  List<String> ingredints = [];
  List<String> instrictions = [];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController _ingrednitsController = TextEditingController();
  final TextEditingController _instructionsController = TextEditingController();
  final TextEditingController tagController = TextEditingController();
  final TextEditingController categoryControler = TextEditingController();

  double _currentServingsTierValue = 1;
  double _currentTimeToMake = 1;

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
                  ingrednitsController: nameController,
                  labelText: 'Title',
                  hintText: 'Enter title',
                ),
                const SizedBox(height: 15),
                CustomFormTextField(
                  ingrednitsController: descriptionController,
                  labelText: 'Description',
                  hintText: 'Describe your recipe',
                ),
                const SizedBox(height: 15),
                CustomFormTextField(
                  ingrednitsController: categoryControler,
                  labelText: 'Category',
                  hintText: 'tag',
                ),
                const SizedBox(height: 15),
                CustomFormTextField(
                  ingrednitsController: tagController,
                  labelText: 'Tags',
                  hintText: 'tag',
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                    bottom: 5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Serving tier"),
                      SizedBox(
                        width: 200,
                        child: Slider(
                            //double type!!!
                            value: _currentServingsTierValue,
                            max: 4,
                            min: 1,
                            divisions: 3,
                            label: _currentServingsTierValue.round().toString(),
                            onChanged: (double value) {
                              setState(() {
                                _currentServingsTierValue = value;
                                print('slider :' +
                                    _currentServingsTierValue.toString());
                              });
                            }),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
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
                            min: 1,
                            divisions: 3,
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
                ingredints.isEmpty
                    ? Text('')
                    : const Text(
                        'Ingredients',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black87,
                        ),
                      ),
                SafeArea(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: ingredints.length,
                      itemBuilder: (_, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 12),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: const Color(0x33FF5C4D)),
                                child: Text(ingredints[index]),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                              width: 30,
                              child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      ingredints.remove(ingredints[index]);
                                    });
                                  },
                                  child: Text('X')),
                            ),
                          ],
                        );
                      }),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        bottom: 0,
                      ),
                      child: SizedBox(
                        width: 200,
                        height: 50,
                        child: TextFormField(
                          controller: _ingrednitsController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Ingredient',
                            hintText: 'Enter ingredient',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            ingredints.add(_ingrednitsController.text);
                            _ingrednitsController.text = "";
                          });
                        },
                        child: Text('Add'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                instrictions.isEmpty
                    ? Text('')
                    : const Text(
                        'Instructions',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black87,
                        ),
                      ),
                SafeArea(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: instrictions.length,
                      itemBuilder: (_, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 12),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: const Color(0x33FF5C4D)),
                                child: Text(instrictions[index]),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                              width: 30,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    instrictions.remove(instrictions[index]);
                                  });
                                },
                                child: Text('X'),
                              ),
                            ),
                          ],
                        );
                      }),
                ),
                Row(
                  children: [
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
                          controller: _instructionsController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Instruction',
                            hintText: 'Enter Instruction',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            instrictions.add(_instructionsController.text);
                            _instructionsController.text = "";
                          });
                        },
                        child: Text('Add'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                      try {
                        var newRecipe = createRecipeAddObject(
                          nameController.text,
                          descriptionController.text,
                          ingredints,
                          instrictions,
                          tagController.text,
                          categoryControler.text,
                          _currentServingsTierValue,
                          _currentTimeToMake,
                        );
                        RecipeSendApi().postRecipe(newRecipe);
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
}

RecipeAdd createRecipeAddObject(
  String title,
  descrption,
  List<String> ingredients,
  List<String> instructions,
  String tag,
  category,
  double servings,
  timeTomake,
) {
  List<Ingredients> ingredientsObjectList = [];
  List<Instructions> instructionObjectList = [];
  List<int> tagList = [int.parse(tag)];
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
    categoryId: int.parse(category),
    tagIds: tagList,
    ingredients: ingredientsObjectList,
    instructions: instructionObjectList,
  );
}

class CustomFormTextField extends StatelessWidget {
  const CustomFormTextField(
      {super.key,
      required TextEditingController ingrednitsController,
      required this.labelText,
      required this.hintText})
      : _ingrednitsController = ingrednitsController;

  final TextEditingController _ingrednitsController;
  final String labelText;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _ingrednitsController,
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
