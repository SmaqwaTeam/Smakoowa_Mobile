import 'package:flutter/material.dart';
import 'package:smakowa/pages/favorite_page.dart';
import 'package:smakowa/pages/home_page.dart';
import 'package:smakowa/pages/profile_page.dart';
import 'package:smakowa/pages/settings_page.dart';
import 'package:easy_search_bar/easy_search_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smakoowa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.grey[20],
            ),
            foregroundColor: Colors.amber,
            centerTitle: true,
            backgroundColor: Colors.grey[50],
            elevation: 0.00,
          ),
          primarySwatch: Colors.orange,
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(
            color: Colors.white,
          )))),
      home: const MyHomePage(title: 'Smakoowa'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  List<Widget> body = const [
    HomePage(),
    FavoritePage(),
    ProfilePage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: MySearchDelaegate(),
              );
            },
            icon: Icon(
              Icons.search,
            ),
          )
        ],
      ),
      body: Center(
        child: body[_currentIndex],
      ),
//NAV BAR
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.orange,
        currentIndex: _currentIndex,
        onTap: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
//ADD BUTTON
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add',
        child: const Icon(
          Icons.add,
          color: Colors.white70,
        ),
      ),
//DRAWER
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            child: Text(''),
          ),
          DrawerListTile(
            title: 'Categories',
            icon: Icons.category_outlined,
            onPress: () {},
          ),
          // Divider(
          //   color: Colors.grey,
          // ),
          DrawerListTile(
            title: 'Tags',
            icon: Icons.tag,
            onPress: () {},
          ),
          DrawerListTile(
              title: 'Notifications',
              icon: Icons.notifications_none_sharp,
              onPress: () {}),
        ],
      )), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onPress,
  });
  final String title;
  final IconData icon;
  final VoidCallback onPress;
  //onPress not implement!

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.orange,
        size: 25,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}

//SEARCH BAR
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
