

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final User currentUser = FirebaseAuth.instance.currentUser!;
  int plasticAmount = 0;
  int bottleAmount = 0;

  Future<void> getPoints() async {

    String uid = currentUser.uid;

    DocumentSnapshot documentSnapshot1 = await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .get();

    if (documentSnapshot1.exists) {
      Map<String, dynamic> userData1 = documentSnapshot1.data() as Map<String, dynamic>;
      setState(() {
        print(userData1);
      });
    } else {
      print("User not found");
    }

    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection("recycledWasteCollector")
        .doc(uid)
        .get();

    if (documentSnapshot.exists) {
      Map<String, dynamic> userData = documentSnapshot.data() as Map<String, dynamic>;
      setState(() {
        plasticAmount = int.parse(userData['plasticAmount']);
        bottleAmount = int.parse(userData['bottleAmount']);
      });
    } else {
      print("User not found");
    }
  }

  @override
  void initState() {
    super.initState();
    getPoints();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 120.0, // Set the width of the container
                  height: 120.0, // Set the height of the container
                  padding: EdgeInsets.all(16.0), // Set the padding within the container
                  margin: EdgeInsets.all(8.0), // Set the margin around the container
                  decoration: BoxDecoration(
                    color: Colors.green, // Set the background color of the container
                    borderRadius: BorderRadius.circular(20.0), // Set the border radius of the container
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2.0,
                        blurRadius: 5.0,
                        offset: Offset(0, 3), // Adjust the shadow position as needed
                      ),
                    ],
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          'Plastic',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Icon(
                          LineIcons.shoppingBag,
                          size: 35.0,
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          "$plasticAmount",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100.0, // Set the width of the container
                      padding: EdgeInsets.all(16.0), // Set the padding within the container
                      margin: EdgeInsets.all(8.0), // Set the margin around the container
                      decoration: BoxDecoration(
                        color: Colors.green[300], // Set the background color of the container
                        borderRadius: BorderRadius.circular(20.0), // Set the border radius of the container
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2.0,
                            blurRadius: 5.0,
                            offset: Offset(0, 3), // Adjust the shadow position as needed
                          ),
                        ],
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              'Bottle',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Icon(
                              LineIcons.prescriptionBottle,
                              size: 30.0,
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              '$bottleAmount',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Container(
                    //   width: 100.0, // Set the width of the container
                    //   padding: EdgeInsets.all(16.0), // Set the padding within the container
                    //   margin: EdgeInsets.all(8.0), // Set the margin around the container
                    //   decoration: BoxDecoration(
                    //     color: Colors.green[300], // Set the background color of the container
                    //     borderRadius: BorderRadius.circular(20.0), // Set the border radius of the container
                    //     boxShadow: [
                    //       BoxShadow(
                    //         color: Colors.grey.withOpacity(0.5),
                    //         spreadRadius: 2.0,
                    //         blurRadius: 5.0,
                    //         offset: Offset(0, 3), // Adjust the shadow position as needed
                    //       ),
                    //     ],
                    //   ),
                    //   child: Center(
                    //     child: Column(
                    //       children: [
                    //         Text(
                    //           'Glass',
                    //           textAlign: TextAlign.center,
                    //           style: TextStyle(
                    //             fontSize: 22.0,
                    //             fontWeight: FontWeight.bold,
                    //           ),
                    //         ),
                    //         SizedBox(height: 5.0),
                    //         Icon(
                    //           LineIcons.martiniGlass,
                    //           size: 30.0,
                    //         ),
                    //         SizedBox(height: 5.0),
                    //         Text(
                    //           '$glassAmount',
                    //           textAlign: TextAlign.center,
                    //           style: TextStyle(
                    //             fontSize: 20.0,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          )
      ),
    );
  }
}
