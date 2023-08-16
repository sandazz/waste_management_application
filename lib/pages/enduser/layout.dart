import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:waste_management_app/pages/enduser/Account.dart';
import 'package:waste_management_app/pages/enduser/Achievement.dart';
import 'package:waste_management_app/pages/enduser/Camera.dart';
import 'package:waste_management_app/pages/enduser/Home.dart';
import 'package:waste_management_app/pages/enduser/LeaderBoard.dart';
import 'package:waste_management_app/pages/enduser/Rewards.dart';

class BottomNavigationExample extends StatefulWidget {
  @override
  _BottomNavigationExampleState createState() => _BottomNavigationExampleState();
}

class _BottomNavigationExampleState extends State<BottomNavigationExample> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    // Define your navigation items here
    Home(),
    LeaderBoard(),
    // Camera(),
    Achievement(),
    Rewards(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

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
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
              ),
            ),
          ],
        ),

        body: Center(child: _widgetOptions.elementAt(_selectedIndex)),


        bottomNavigationBar:BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.leaderboard_outlined),
              label: '',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.camera_alt_outlined, size: 35.0,),
            //   label: '',
            // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shield_outlined),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.diamond_outlined),
              label: '',
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
