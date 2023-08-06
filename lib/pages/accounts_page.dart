import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../server/auth.dart';

class AccountPage extends StatelessWidget {
  AccountPage({Key? key}) : super(key: key);

  final User? user = Auth().currentUser;
  Future<void> signOut() async {
    await Auth().signOut();
  }

  String _userUid() {
    return user?.email ?? 'User email not found';
  }

  @override
  Widget build(BuildContext context) {
    const colorizeColors = [
      Colors.purple,
      Colors.blue,
      Colors.yellow,
      Colors.red,
    ];

    const colorizeTextStyle = TextStyle(
      fontSize: 30.0,
      fontWeight: FontWeight.w900,
      fontFamily: 'Horizon',
    );
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(32),
            color: Color.fromARGB(255, 13, 125, 54),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimatedTextKit(animatedTexts: [
                  ColorizeAnimatedText(
                    'EcoWarrior',
                    textStyle: colorizeTextStyle,
                    colors: colorizeColors,
                  )
                ]),
                SizedBox(height: 16),
                CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage(
                      'assets/Screen Shot 2023-07-14 at 6.34.43 PM.png'),
                ),
                SizedBox(height: 16),
                Text(
                  'Sumanth Pallamreddy',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  _userUid().toString(),
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildCircularButton(
                      context,
                      Icons.add,
                      'Add Vendor',
                      () {
                        // Handle add vendor button click
                      },
                    ),
                    _buildCircularButton(
                      context,
                      Icons.receipt,
                      'Scan Receipt',
                      () {
                        // Handle scan receipt button click
                      },
                    ),
                    _buildCircularButton(
                      context,
                      Icons.help,
                      'Help Center',
                      () {
                        // Handle help center button click
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(height: 16),
                    _buildSettingsItem(
                      context,
                      'Log out',
                      Icons.logout,
                    ),
                    Divider(),
                    _buildSettingsItem(
                      context,
                      'Profile Settings',
                      Icons.person,
                    ),
                    Divider(),
                    _buildSettingsItem(
                      context,
                      'Language and Location',
                      Icons.language,
                    ),
                    Divider(),
                    _buildSettingsItem(
                      context,
                      'Currency',
                      Icons.attach_money,
                    ),
                    Divider(),
                    _buildSettingsItem(
                      context,
                      'Appearance',
                      Icons.color_lens,
                    ),
                    Divider(),
                    _buildSettingsItem(
                      context,
                      'Notification Settings',
                      Icons.notifications,
                    ),
                    Divider(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircularButton(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback onPressed,
  ) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Container(
            color: Color.fromARGB(255, 224, 202, 76),
            child: IconButton(
              icon: Icon(icon, color: Colors.white),
              onPressed: onPressed,
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildSettingsItem(
    BuildContext context,
    String title,
    IconData icon,
  ) {
    if (title == "Log out") {
      return ListTile(
        leading: Icon(icon, color: Colors.black),
        title: Text(
          title,
          style: TextStyle(color: Colors.black),
        ),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          color: Colors.black,
        ),
        onTap: () {
          signOut(); // Handle settings item click
        },
      );
    }
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(
        title,
        style: TextStyle(color: Colors.black),
      ),
      trailing: Icon(
        Icons.keyboard_arrow_right,
        color: Colors.black,
      ),
      onTap: () {
        // Handle settings item click
      },
    );
  }
}
