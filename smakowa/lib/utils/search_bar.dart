//SEARCH BAR
import 'package:flutter/material.dart';

class MySearchDelaegate extends SearchDelegate {
  List<String> suggestions = [
    'chicken',
    'rice',
    'packcake',
    'meat',
  ];

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null); // close tab
      },
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          }
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = [
      'chicken',
      'rice',
      'packcake',
      'meat',
    ];

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];

        return ListTile(
          title: Text(suggestion),
          onTap: () {
            query = suggestion;
            showResults(context);
          },
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) => Center(
        child: Text(
          query,
        ),
      );
}
