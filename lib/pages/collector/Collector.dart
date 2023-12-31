import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:waste_management_app/pages/collector/Account.dart';
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
          toolbarHeight: 80.0,
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
