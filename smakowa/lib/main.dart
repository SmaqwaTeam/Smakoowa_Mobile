import 'dart:io';

import 'package:flutter/material.dart';
import 'package:smakowa/pages/home/add_recipe.dart';
import 'package:smakowa/pages/widget/category_list.dart';
import 'package:smakowa/pages/favorite/favorite_page.dart';
import 'package:smakowa/pages/home/home_page.dart';
import 'package:smakowa/pages/profile/profile_page.dart';
import 'package:smakowa/pages/settings_page.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:smakowa/pages/tags_list.dart';
import 'package:smakowa/utils/search_bar.dart';
import 'package:get/get.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  //android certificate fix not for deploy
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

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
        title: Text('Smakoowa'),
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
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const AddRecipe();
              },
            ),
          );
        },
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
            onPress: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const CategoryList();
                  },
                ),
              );
            },
          ),
          // Divider(
          //   color: Colors.grey,
          // ),
          DrawerListTile(
            title: 'Tags',
            icon: Icons.tag,
            onPress: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return TagsList();
                  },
                ),
              );
            },
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
      onTap: onPress,
      // Navigator.pop(context);
    );
  }
}

//certificate fix
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
