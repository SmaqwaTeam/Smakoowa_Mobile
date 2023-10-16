import 'dart:io';

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
import 'package:image_picker/image_picker.dart';

import '../widget/edit_comp.dart';

class EditRecipe extends StatefulWidget {
  const EditRecipe({super.key, required this.editRecipeId});
  final int editRecipeId;
  @override
  State<EditRecipe> createState() => _EditRecipeState();
}

class _EditRecipeState extends State<EditRecipe> {
  final _formKey = GlobalKey<FormState>();
  List<String> ingredintsList = [];
  List<String> instrictionsList = [];
  List<int> tagsConfirmList = [];
  late Future<List<Categories>> futureCategories;
  late Future<List<Tags>> futureTags;
  late Future<RecipeDeatil> futureEditData;

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController _ingrednitsController = TextEditingController();
  TextEditingController _instructionsController = TextEditingController();

  int catergoryId = 1;

  double _currentServingsTierValue = 1;
  double _currentTimeToMake = 1;

  File? selectedImage;

  bool state = true;
  @override
  void initState() {
    super.initState();
    futureCategories = CategoryApiList().getCategory();
    futureTags = TagsApiList().getTags();
    // futureEditData = RecipeDetailsApi().getRecipeDetail(widget.editRecipeId);

    loadEditData(widget.editRecipeId);
  }

  loadEditData(int id) async {
    var temp = await RecipeDetailsApi().getRecipeDetail(id);
    setState(() {
      nameController.text = temp.name;
      descriptionController.text = temp.description;
      catergoryId = temp.categoryId;
      _currentServingsTierValue = temp.servingsTier.toDouble();
      ingredintsList = convertToStringList(temp.ingredients);
      instrictionsList = convertToStringList(temp.instructions);
      state = false;

      // tagsConfirmList = temp.tagIds;
    });
  }

  // Future getImage() async {
  //   var image = await ImagePicker().pickImage(source: ImageSource.gallery);

  //   setState(() {
  //     selectedImage = File(image!.path);
  //   });
  // }

  Future getFromGalery() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    File file = File(image!.path);
    setState(() {
      selectedImage = File(image.path);
    });
  }

  convertToStringList(List<dynamic> list) {
    List<String> tempLits = [];
    for (var i = 0; i < list.length; i++) {
      tempLits.add(list[i].getName());
    }
    return tempLits;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Recipe'),
      ),
      resizeToAvoidBottomInset: true,
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
                      width: 250,
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
                      width: 250,
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
                selectedImage == null
                    ? const Icon(Icons.add_photo_alternate)
                    : SizedBox(
                        width: 200,
                        height: 200,
                        child: Image.file(
                          selectedImage!,
                          fit: BoxFit.cover,
                        ),
                      ),
                ElevatedButton(
                    onPressed: () {
                      getFromGalery();
                      print(selectedImage);
                    },
                    child: Text('Upload img')),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                      try {
                        var newRecipe = createEditObject(
                          widget.editRecipeId,
                          nameController.text,
                          descriptionController.text,
                          ingredintsList,
                          instrictionsList,
                          tagsConfirmList,
                          catergoryId,
                          _currentServingsTierValue,
                          _currentTimeToMake,
                        );
                        RecipeDetailsApi().putRecipe(
                          newRecipe,
                          widget.editRecipeId,
                        );
                        if (selectedImage != null) {
                          RecipeDetailsApi().onUploadImage(
                              selectedImage!, widget.editRecipeId);
                        }
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
            width: 200,
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
