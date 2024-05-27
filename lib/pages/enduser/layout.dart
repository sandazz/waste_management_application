import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:waste_management_app/pages/enduser/Account.dart';
import 'package:waste_management_app/pages/enduser/Achievement.dart';
import 'package:waste_management_app/pages/enduser/Camera.dart';
import 'package:waste_management_app/pages/enduser/Home.dart';
import 'package:waste_management_app/pages/enduser/LeaderBoard.dart';
import 'package:waste_management_app/pages/enduser/Rewards.dart';

class BottomNavigationExample extends StatefulWidget {
  const BottomNavigationExample({super.key});

  @override
  _BottomNavigationExampleState createState() => _BottomNavigationExampleState();
}

class _BottomNavigationExampleState extends State<BottomNavigationExample> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    // Define your navigation items here
    Home(),
    LeaderBoard(),
    Camera(),
    Achievement(),
    Rewards(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: Padding(
            padding: EdgeInsets.all(10.0),
            child: IconButton(
              icon: Icon(
                Icons.manage_accounts,
                color: Colors.black,
                size: 30.0,
              ),
              onPressed: () {// Handle leading icon press
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Account()), // Replace SecondPage with your desired destination page
                );
              },
            ),
          ),

          actions: [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: IconButton(
                icon: Icon(Icons.logout_outlined,
                  color: Colors.black,
                  size: 30.0,
                ),
                onPressed: ()=> showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0), // Set your desired border radius
                    ),
                    content:  Text('Are you sure you want to log out?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child:  Text('Cancel', style: TextStyle(color: Colors.green),),
                      ),
                      TextButton(
                        style: ButtonStyle(
                          textStyle: MaterialStateProperty.all<TextStyle>(
                            TextStyle(fontSize: 16.0), // Set your desired font size
                          ),
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Text color
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.red), // Button background color
                          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Set your desired padding
                          ),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0), // Set your desired border radius
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context, 'Log Out');
                          FirebaseAuth.instance.signOut();
                        },
                        child:  Text('Log Out'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),

        body: Center(child: _widgetOptions.elementAt(_selectedIndex)),


        bottomNavigationBar:BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.leaderboard_outlined),
              label: 'LeaderBoard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.camera_alt_outlined, size: 35.0,),
              label: 'Camera',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shield_outlined),
              label: 'Achievement',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.diamond_outlined),
              label: 'Reward',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
        )
    );
  }
}
