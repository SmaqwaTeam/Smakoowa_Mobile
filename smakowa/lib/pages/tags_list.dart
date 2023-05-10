import 'package:flutter/material.dart';
import 'package:smakowa/models/tags.dart';
import 'package:smakowa/pages/home/recipe_list_by_tag.dart';

import '../models/tags.api.dart';

class TagsList extends StatefulWidget {
  const TagsList({super.key});

  @override
  State<TagsList> createState() => _TagsListState();
}

class _TagsListState extends State<TagsList> {
  late Future<List<Tags>> futureTags;

  @override
  void initState() {
    super.initState();
    futureTags = TagsApiList().getTags();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tags'),
      ),
      body: Center(
        child: FutureBuilder<List<Tags>>(
          future: futureTags,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                  itemBuilder: ((context, index) {
                    Tags tag = snapshot.data?[index];
                    return ListTile(
                      title: Text(tag.tagName),
                      trailing: const Icon(Icons.chevron_right_outlined),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return TagCardList(
                                tagId: tag.id,
                                tagName: tag.tagName,
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
