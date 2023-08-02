import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';



class Rewards extends StatefulWidget {
  const Rewards({Key? key}) : super(key: key);

  @override
  State<Rewards> createState() => _RewardsState();
}

class _RewardsState extends State<Rewards> {

  final User currentUser = FirebaseAuth.instance.currentUser!;

  int totalSpinnableCount = 0;
  double costPerSpinning = 5.0;
  double spinnablePoints = 0;

  Future<void> getPoints() async {

    String uid = currentUser.uid;

    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection("recycledWasteEndUser")
        .doc(uid)
        .get();

    if (documentSnapshot.exists) {
      Map<String, dynamic> userData = documentSnapshot.data() as Map<String, dynamic>;
      setState(() {
        spinnablePoints = double.parse(userData['spinnablePoints']);
        totalSpinnableCount = (spinnablePoints/ costPerSpinning).toInt();
      });
    } else {
      print("User not found");
    }
  }

  Future<void> updatePoints() async {
    String uid = currentUser.uid;
    spinnablePoints = spinnablePoints - costPerSpinning;
    totalSpinnableCount--;

    FirebaseFirestore.instance.collection("recycledWasteEndUser").doc(uid).update(
        {"spinnablePoints": spinnablePoints.toString()});
  }


  final items = <String>[
    'TRY AGAIN',
    'REWARDS',
    'TRY AGAIN',
    'REWARDS',
    'TRY AGAIN',
    'REWARDS',
    'TRY AGAIN',
    'REWARDS',
    'TRY AGAIN',
    'REWARDS',

  ];

  StreamController<int> selected = StreamController<int>();

  void initState(){
    super.initState();
    getPoints();
  }

  @override
  void dispose() {
    selected.close();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // heading
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                'Rewards',
                style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0
                ),
              ),
            ),
            AspectRatio(
              aspectRatio: 7/2,
                child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 110.0, // Set the width of the container
                    // height: 110.0, // Set the height of the container
                    padding: EdgeInsets.all(16.0),
                    margin: EdgeInsets.symmetric(horizontal: 5.0),// Set the padding within the container
                    decoration: BoxDecoration(
                      color: Colors.white, // Set the background color of the container
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
                            'Spinnable Points',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                          SizedBox(height: 15.0),
                          Text(
                            "$spinnablePoints",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 25.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 110.0, // Set the width of the container
                    // height: 110.0, // Set the height of the container
                    padding: EdgeInsets.all(16.0),
                    margin: EdgeInsets.symmetric(horizontal: 5.0),// Set the padding within the container
                    decoration: BoxDecoration(
                      color: Colors.white, // Set the background color of the container
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
                            'Cost Per Spinnig',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                          SizedBox(height: 15.0),
                          Text(
                            '$costPerSpinning',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 25.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 110.0, // Set the width of the container
                    // height: 110.0, // Set the height of the container
                    padding: EdgeInsets.all(16.0),
                    margin: EdgeInsets.symmetric(horizontal: 5.0),// Set the padding within the container
                    decoration: BoxDecoration(
                      color: Colors.white, // Set the background color of the container
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
                            'Total Spinning Count',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                          SizedBox(height: 15.0),
                          Text(
                            '$totalSpinnableCount',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 25.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 80.0,),
            //spinning wheeler
            // Stack(
            //   children: [
            //     //background rectangle
            //     Positioned(
            //       child: Transform.rotate(
            //         angle: 45 * 0.0174533 ,
            //         child: Center(
            //           child: Container(
            //             width: 300.0,
            //             height: 300.0,
            //             color: Colors.green[50],
            //           ),
            //         ),
            //       ),
            //     ),
            //     //first rectangle
            //     Positioned(
            //       top: 0,
            //       left: 157,
            //       child: Transform.rotate(
            //         angle: 45 * 0.0174533, // Convert 90 degrees to radians
            //         child: Container(
            //           width: 75.0,
            //           height: 75.0,
            //           color: Colors.green[200],
            //         ),
            //       ),
            //     ),
            //     //next two rectangles
            //     Positioned(
            //       top: 55.0,
            //       left: 102,
            //       child: Transform.rotate(
            //         angle: 45 * 0.0174533, // Convert 90 degrees to radians
            //         child: Container(
            //           width: 75.0,
            //           height: 75.0,
            //           color: Colors.green[200],
            //         ),
            //       ),
            //     ),
            //     Positioned(
            //       top: 55.0,
            //       right: 106,
            //       child: Transform.rotate(
            //         angle: 45 * 0.0174533, // Convert 90 degrees to radians
            //         child: Container(
            //           width: 75.0,
            //           height: 75.0,
            //           color: Colors.green[200],
            //         ),
            //       ),
            //     ),
            //     //middle two rectangles
            //     Positioned(
            //       top: 110.0,
            //       left: 47,
            //       child: Transform.rotate(
            //         angle: 45 * 0.0174533, // Convert 90 degrees to radians
            //         child: Container(
            //           width: 75.0,
            //           height: 75.0,
            //           color: Colors.green[200],
            //         ),
            //       ),
            //     ),
            //     Positioned(
            //       top: 110.0,
            //       right: 51,
            //       child: Transform.rotate(
            //         angle: 45 * 0.0174533, // Convert 90 degrees to radians
            //         child: Container(
            //           width: 75.0,
            //           height: 75.0,
            //           color: Colors.green[200],
            //         ),
            //       ),
            //     ),
            //     //last two rectangles
            //     Positioned(
            //       top: 165.0,
            //       left: 102,
            //       child: Transform.rotate(
            //         angle: 45 * 0.0174533, // Convert 90 degrees to radians
            //         child: Container(
            //           width: 75.0,
            //           height: 75.0,
            //           color: Colors.green[200],
            //         ),
            //       ),
            //     ),
            //     Positioned(
            //       top: 165.0,
            //       right: 106,
            //       child: Transform.rotate(
            //         angle: 45 * 0.0174533, // Convert 90 degrees to radians
            //         child: Container(
            //           width: 75.0,
            //           height: 75.0,
            //           color: Colors.green[200],
            //         ),
            //       ),
            //     ),
            //     //last rectangle
            //     Positioned(
            //       top: 165.0 + 55.0,
            //       left: 157,
            //       child: Transform.rotate(
            //         angle: 45 * 0.0174533, // Convert 90 degrees to radians
            //         child: Container(
            //           width: 75.0,
            //           height: 75.0,
            //           color: Colors.green[200],
            //         ),
            //       ),
            //     ),
            //   ],
            // ),

            SizedBox(
              height: 350.0,
              child: FortuneWheel(
                selected: selected.stream,
                items: [
                  for (var it in items) FortuneItem(
                    child: Text(it),
                    style: FortuneItemStyle(
                      color: items.indexOf(it) % 2 == 0 ? Colors.green.shade300:Colors.green.shade500, // <-- custom circle slice fill color
                      borderWidth: 0.0, // <-- custom circle slice stroke width
                    ),
                  ),
                ],
                indicators: <FortuneIndicator>[
                  FortuneIndicator(
                    alignment: Alignment.topCenter, // <-- changing the position of the indicator
                    child: TriangleIndicator(
                      color: Colors.green[700], // <-- changing the color of the indicator
                    ),
                  ),
                ],
              ),
            ),


            SizedBox(height: 30,),
            //spinning button at last
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(150.0, 40.0),
                  elevation: 4.0, // Set the elevation of the button
                  backgroundColor: Colors.green[700], // Set the background color of the button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0), // Set the border radius of the button
                  ),
                ),
                onPressed: totalSpinnableCount >= 1
                    ?() {
                      setState(() {
                        final selectedIndex = Fortune.randomInt(0, items.length);
                        selected.add(selectedIndex);
                        print('Selected Item: ${items[selectedIndex]}');
                        updatePoints();
                      });
                    }
                    : null,
                child: Text('Spinning'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
