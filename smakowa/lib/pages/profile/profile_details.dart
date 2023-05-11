import 'package:flutter/material.dart';
import 'package:smakowa/pages/profile/current_user_recipes.dart';
import 'package:get/get.dart';
import 'package:smakowa/main.dart';
import 'package:smakowa/models/auth/user_data.dart';
import 'package:smakowa/pages/widget/edit_recipe_card.dart';

import '../widget/profile_list_menu.dart';

class ProfileDetail extends StatefulWidget {
  ProfileDetail({super.key});

  @override
  State<ProfileDetail> createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> {
  String? username;
  String? email;

  @override
  void initState() {
    super.initState();
    readData();
  }

  Future readData() async {
    final username = await UserData.getUserName();
    final email = await UserData.getUserEmail();

    setState(() {
      this.username = username;
      this.email = email;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  // backgroundImage: AssetImage('assets/user.jpeg'),
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.grey[600],
                  ),

                  radius: 50,
                ),
              ),
              const Divider(
                height: 60,
              ),
              const Text(
                'Name',
                style: TextStyle(color: Colors.grey, letterSpacing: 2),
              ),
              const SizedBox(height: 10),
              Text(
                username ?? '',
                style: const TextStyle(
                    color: Colors.black,
                    letterSpacing: 2,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              const Text(
                'Email',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                email ?? '',
                style: const TextStyle(
                    // color: Colors.amberAccent[200],
                    letterSpacing: 2,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              ProfileListMenu(
                title: 'My recipes',
                icon: Icons.receipt_long_rounded,
                onPress: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const CurrentUserRecipes();
                      },
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 15,
              ),
              ProfileListMenu(
                title: 'Edit profile',
                icon: Icons.edit,
                onPress: () {},
              ),
              //test

              const SizedBox(
                height: 50,
              ),
              ProfileListMenu(
                title: 'Logout',
                icon: Icons.logout,
                onPress: () {
                  UserData.logOut();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Log out')),
                  );

                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const MyHomePage();
                      },
                    ),
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
