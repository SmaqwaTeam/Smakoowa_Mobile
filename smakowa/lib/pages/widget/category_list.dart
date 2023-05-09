import 'package:flutter/material.dart';
import 'package:smakowa/models/category.api.dart';
import 'package:smakowa/models/category.dart';

import '../home/recipe_listy_by_category.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  late Future<List<Categories>> futureCategories;

  @override
  void initState() {
    super.initState();
    futureCategories = CategoryApiList().getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: FutureBuilder<List<Categories>>(
          future: futureCategories,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                  itemBuilder: ((context, index) {
                    Categories category = snapshot.data?[index];
                    return ListTile(
                      title: Text(category.categoryName),
                      trailing: const Icon(Icons.chevron_right_outlined),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return CategoryCardList(
                                categoryId: category.id,
                              );
                            },
                          ),
                        );
                      },
                    );
                  }),
                  separatorBuilder: ((context, index) {
                    return const Divider(
                      height: 2,
                    );
                  }),
                  itemCount: snapshot.data!.length);
            } else if (snapshot.hasError) {
              return Text('Error ${snapshot.error}');
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
