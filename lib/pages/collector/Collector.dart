import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:waste_management_app/pages/collector/Camera.dart';
import 'package:waste_management_app/pages/collector/Home.dart';

class LayoutCollector extends StatefulWidget {
  @override
  _LayoutCollectorState createState() => _LayoutCollectorState();
}

class _LayoutCollectorState extends State<LayoutCollector> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    // Define your navigation items here
    Home(),
    Camera(),
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
            padding: EdgeInsets.all(15.0),
            child: IconButton(
              icon: Icon(
                Icons.manage_accounts,
                color: Colors.black,
                size: 30.0,
              ),
              onPressed: () {// Handle leading icon press
              },
            ),
          ),

          actions: [
            Padding(
              padding: EdgeInsets.all(15.0),
              child: IconButton(
                icon: Icon(Icons.notifications,
                  color: Colors.black,
                  size: 35.0,
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
              icon: Icon(Icons.add_box_outlined,),
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
