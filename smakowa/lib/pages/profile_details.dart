import 'package:flutter/material.dart';
import 'package:smakowa/pages/test_routing.dart';

class ProfileDetail extends StatelessWidget {
  const ProfileDetail({super.key});

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
              Divider(
                height: 60,
              ),
              const Text(
                'Name',
                style: TextStyle(color: Colors.grey, letterSpacing: 2),
              ),
              SizedBox(height: 10),
              Text(
                'James Cameron',
                style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 2,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              const Text(
                'Email',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'amber@gmail.com',
                style: TextStyle(
                    // color: Colors.amberAccent[200],
                    letterSpacing: 2,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              ProfileListMenu(
                title: 'My recipes',
                icon: Icons.receipt_long_rounded,
                onPress: () {},
              ),
              SizedBox(
                height: 15,
              ),
              ProfileListMenu(
                title: 'Edit profile',
                icon: Icons.edit,
                onPress: () {},
              ),
              SizedBox(
                height: 50,
              ),
              ProfileListMenu(
                title: 'Logout',
                icon: Icons.logout,
                onPress: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileListMenu extends StatelessWidget {
  const ProfileListMenu({
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
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.grey[200],
        ),
        child: Icon(
          icon,
          color: Colors.amber,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }
}
