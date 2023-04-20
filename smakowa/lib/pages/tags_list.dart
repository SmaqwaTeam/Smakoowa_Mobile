import 'package:flutter/material.dart';
import 'package:smakowa/models/tags.dart';

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
    futureTags = getTags();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: FutureBuilder<List<Tags>>(
          future: futureTags,
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: [],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          }),
        ),
      ),
    );
  }
}
