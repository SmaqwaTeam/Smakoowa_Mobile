import 'dart:io';

import 'package:flutter/material.dart';
import 'package:smakowa/pages/widget/category_list.dart';
import 'package:smakowa/pages/favorite/favorite_page.dart';
import 'package:smakowa/pages/home/home_page.dart';
import 'package:smakowa/pages/profile/profile_page.dart';
import 'package:smakowa/pages/settings_page.dart';
import 'package:smakowa/pages/tags_list.dart';
import 'package:smakowa/pages/widget/custom_list_tile.dart';
import 'package:smakowa/utils/search_bar.dart';
import 'package:get/get.dart';

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
        title: const Text('Smakoowa'),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: MySearchDelaegate(),
              );
            },
            icon: const Icon(
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

//DRAWER
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            child: Text(''),
          ),
          CustomDrawerListTile(
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
          CustomDrawerListTile(
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
        ],
      )),
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
