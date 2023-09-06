import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:waste_management_app/pages/enduser/RewardGiveAway.dart';



class Rewards extends StatefulWidget {
  const Rewards({Key? key}) : super(key: key);

  @override
  State<Rewards> createState() => _RewardsState();
}

class _RewardsState extends State<Rewards> {

  final User currentUser = FirebaseAuth.instance.currentUser!;

  int totalSpinnableCount = 0;
  int costPerSpinning = 10;
  int RedeemablePoints = 0;
  int rewardPoints = 0;

  // show case keys
  final GlobalKey _redeemablePointsKey = GlobalKey();
  final GlobalKey _costPerSpinningKey = GlobalKey();
  final GlobalKey _spinCountKey = GlobalKey();
  final GlobalKey _spinningKey = GlobalKey();
  final GlobalKey _rewardPointKey = GlobalKey();

  Future<void> getPoints() async {

    String uid = currentUser.uid;

    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection("recycledWasteEndUser")
        .doc(uid)
        .get();

    if (documentSnapshot.exists) {
      Map<String, dynamic> userData = documentSnapshot.data() as Map<String, dynamic>;
      setState(() {
        RedeemablePoints = userData['spinnablePoints'];
        rewardPoints = userData['rewardPoints'];
        totalSpinnableCount = (RedeemablePoints/ costPerSpinning).toInt();
      });
    } else {
      print("User not found");
    }
  }

  Future<void> updatePoints() async {
    String uid = currentUser.uid;
    RedeemablePoints = RedeemablePoints - costPerSpinning;
    totalSpinnableCount--;

    FirebaseFirestore.instance.collection("recycledWasteEndUser").doc(uid).update(
        {"spinnablePoints": RedeemablePoints,"rewardPoints": rewardPoints.toString()});
  }


  final items = <String>[
    'TRY AGAIN',
    '0.1 POINTS',
    'TRY AGAIN',
    '0.2 POINTS',
    'TRY AGAIN',
    '0.5 POINTS',
    'TRY AGAIN',
    '0.7 POINTS',
    'TRY AGAIN',
    '1.0 POINTS',
  ];

  StreamController<int> selected = StreamController<int>();

  // Showcase call
  void showCaseCall(){
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ShowCaseWidget.of(context).startShowCase([_redeemablePointsKey, _costPerSpinningKey, _spinCountKey, _spinningKey, _rewardPointKey]);
    });
  }

  void initState(){
    super.initState();
    getPoints();
    showCaseCall();
  }

  @override
  void dispose() {
    selected.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: SingleChildScrollView(
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         // heading
    //         Padding(
    //           padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    //           child: Text(
    //             'Rewards',
    //             style: TextStyle(
    //                 fontSize: 40.0,
    //                 fontWeight: FontWeight.bold,
    //                 letterSpacing: 1.0
    //             ),
    //           ),
    //         ),
    //         AspectRatio(
    //           aspectRatio: 10/3,
    //             child: Row(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               Showcase(
    //                 key: _redeemablePointsKey,
    //                 description: 'Points collected from recycle, can use for spinning the wheel and get reward points',
    //                 child: Container(
    //                   width: 110.0, // Set the width of the container
    //                   // height: 110.0, // Set the height of the container
    //                   padding: EdgeInsets.all(16.0),
    //                   margin: EdgeInsets.symmetric(horizontal: 5.0),// Set the padding within the container
    //                   decoration: BoxDecoration(
    //                     color: Colors.white, // Set the background color of the container
    //                     borderRadius: BorderRadius.circular(20.0), // Set the border radius of the container
    //                     boxShadow: [
    //                       BoxShadow(
    //                         color: Colors.grey.withOpacity(0.5),
    //                         spreadRadius: 2.0,
    //                         blurRadius: 5.0,
    //                         offset: Offset(0, 3), // Adjust the shadow position as needed
    //                       ),
    //                     ],
    //                   ),
    //                   child: Center(
    //                     child: Column(
    //                       children: [
    //                         Text(
    //                           'Redeemable Points',
    //                           textAlign: TextAlign.center,
    //                           style: TextStyle(
    //                             fontSize: 15.0,
    //                           ),
    //                         ),
    //                         SizedBox(height: 15.0),
    //                         Text(
    //                           "$RedeemablePoints",
    //                           textAlign: TextAlign.center,
    //                           style: TextStyle(
    //                             fontSize: 25.0,
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               Showcase(
    //                 key: _costPerSpinningKey,
    //                 description: 'Points that need for a single spin from the spinning wheel',
    //                 child: Container(
    //                   width: 110.0, // Set the width of the container
    //                   // height: 110.0, // Set the height of the container
    //                   padding: EdgeInsets.all(16.0),
    //                   margin: EdgeInsets.symmetric(horizontal: 5.0),// Set the padding within the container
    //                   decoration: BoxDecoration(
    //                     color: Colors.white, // Set the background color of the container
    //                     borderRadius: BorderRadius.circular(20.0), // Set the border radius of the container
    //                     boxShadow: [
    //                       BoxShadow(
    //                         color: Colors.grey.withOpacity(0.5),
    //                         spreadRadius: 2.0,
    //                         blurRadius: 5.0,
    //                         offset: Offset(0, 3), // Adjust the shadow position as needed
    //                       ),
    //                     ],
    //                   ),
    //                   child: Center(
    //                     child: Column(
    //                       children: [
    //                         Text(
    //                           'Cost Per Spinnig',
    //                           textAlign: TextAlign.center,
    //                           style: TextStyle(
    //                             fontSize: 15.0,
    //                           ),
    //                         ),
    //                         SizedBox(height: 15.0),
    //                         Text(
    //                           '$costPerSpinning',
    //                           textAlign: TextAlign.center,
    //                           style: TextStyle(
    //                             fontSize: 25.0,
    //                           ),
    //                         ),
    //                         SizedBox(height: 10.0),
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               Showcase(
    //                 key: _spinCountKey,
    //                 description: 'How many spins available to spin the spinning wheel',
    //                 child: Container(
    //                   width: 110.0, // Set the width of the container
    //                   // height: 110.0, // Set the height of the container
    //                   padding: EdgeInsets.all(16.0),
    //                   margin: EdgeInsets.symmetric(horizontal: 5.0),// Set the padding within the container
    //                   decoration: BoxDecoration(
    //                     color: Colors.white, // Set the background color of the container
    //                     borderRadius: BorderRadius.circular(20.0), // Set the border radius of the container
    //                     boxShadow: [
    //                       BoxShadow(
    //                         color: Colors.grey.withOpacity(0.5),
    //                         spreadRadius: 2.0,
    //                         blurRadius: 5.0,
    //                         offset: Offset(0, 3), // Adjust the shadow position as needed
    //                       ),
    //                     ],
    //                   ),
    //                   child: Center(
    //                     child: Column(
    //                       children: [
    //                         Text(
    //                           'Number of Spinnes Available',
    //                           textAlign: TextAlign.center,
    //                           style: TextStyle(
    //                             fontSize: 15.0,
    //                           ),
    //                         ),
    //                         SizedBox(height: 15.0),
    //                         Text(
    //                           '$totalSpinnableCount',
    //                           textAlign: TextAlign.center,
    //                           style: TextStyle(
    //                             fontSize: 25.0,
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //
    //         SizedBox(height: 30.0,),
    //         SizedBox(
    //           height: 350.0,
    //           child: FortuneWheel(
    //             selected: selected.stream,
    //             items: [
    //               for (var it in items) FortuneItem(
    //                 child: Text(it),
    //                 style: FortuneItemStyle(
    //                   color: items.indexOf(it) % 2 == 0 ? Colors.green.shade300:Colors.green.shade500, // <-- custom circle slice fill color
    //                   borderWidth: 0.0, // <-- custom circle slice stroke width
    //                 ),
    //               ),
    //             ],
    //             indicators: <FortuneIndicator>[
    //               FortuneIndicator(
    //                 alignment: Alignment.topCenter, // <-- changing the position of the indicator
    //                 child: TriangleIndicator(
    //                   color: Colors.green[700], // <-- changing the color of the indicator
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //
    //
    //         SizedBox(height: 10,),
    //         //spinning button at last
    //         Center(
    //           child: Showcase(
    //             key: _spinningKey,
    //             description: 'Spinning Button for the Spinning wheel. Only active for Redeemable Points is greater than 10.0',
    //             child: ElevatedButton(
    //               style: ElevatedButton.styleFrom(
    //                 minimumSize: Size(150.0, 40.0),
    //                 elevation: 4.0, // Set the elevation of the button
    //                 backgroundColor: Colors.green[500], // Set the background color of the button
    //                 shape: RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(15.0), // Set the border radius of the button
    //                 ),
    //               ),
    //               onPressed: totalSpinnableCount >= 1
    //                   ? () async {
    //                 final selectedIndex = Fortune.randomInt(0, items.length);
    //                 selected.add(selectedIndex);
    //                 print('Selected Item: ${items[selectedIndex]}');
    //
    //                 // Wait for wheel to finish spinning before updating rewardPoints and showing selected item
    //                 await Future.delayed(Duration(seconds: 5), () {
    //                   setState(() {
    //                     if (items[selectedIndex] == 'TRY AGAIN') {
    //                       // No changes to rewardPoints
    //                       ScaffoldMessenger.of(context).showSnackBar(
    //                         SnackBar(
    //                           content: Text('TRY AGAIN !'),
    //                           backgroundColor: Colors.redAccent, // Change color of SnackBar
    //                           behavior: SnackBarBehavior.floating, // Make SnackBar floating
    //                           shape: RoundedRectangleBorder( // Change shape of SnackBar
    //                             borderRadius: BorderRadius.circular(24),
    //                           ),
    //                         ),
    //                       );
    //                     } else if (items[selectedIndex] == '0.1 POINTS') {
    //                       ScaffoldMessenger.of(context).showSnackBar(
    //                         SnackBar(
    //                           content: Text('YOU GOT 0.1 POINTS !'),
    //                           backgroundColor: Colors.green, // Change color of SnackBar
    //                           behavior: SnackBarBehavior.floating, // Make SnackBar floating
    //                           shape: RoundedRectangleBorder( // Change shape of SnackBar
    //                             borderRadius: BorderRadius.circular(24),
    //                           ),
    //                         ),
    //                       );
    //                       rewardPoints = rewardPoints + 0.1;
    //                     } else if (items[selectedIndex] == '0.2 POINTS') {
    //                       ScaffoldMessenger.of(context).showSnackBar(
    //                         SnackBar(
    //                           content: Text('YOU GOT 0.2 POINTS !'),
    //                           backgroundColor: Colors.green, // Change color of SnackBar
    //                           behavior: SnackBarBehavior.floating, // Make SnackBar floating
    //                           shape: RoundedRectangleBorder( // Change shape of SnackBar
    //                             borderRadius: BorderRadius.circular(24),
    //                           ),
    //                         ),
    //                       );
    //                       rewardPoints = rewardPoints + 0.2;
    //                     } else if (items[selectedIndex] == '0.5 POINTS') {
    //                       ScaffoldMessenger.of(context).showSnackBar(
    //                         SnackBar(
    //                           content: Text('YOU GOT 0.5 POINTS !'),
    //                           backgroundColor: Colors.green, // Change color of SnackBar
    //                           behavior: SnackBarBehavior.floating, // Make SnackBar floating
    //                           shape: RoundedRectangleBorder( // Change shape of SnackBar
    //                             borderRadius: BorderRadius.circular(24),
    //                           ),
    //                         ),
    //                       );
    //                       rewardPoints = rewardPoints + 0.5;
    //                     } else if (items[selectedIndex] == '0.7 POINTS') {
    //                       ScaffoldMessenger.of(context).showSnackBar(
    //                         SnackBar(
    //                           content: Text('YOU GOT 0.7 POINTS !'),
    //                           backgroundColor: Colors.green, // Change color of SnackBar
    //                           behavior: SnackBarBehavior.floating, // Make SnackBar floating
    //                           shape: RoundedRectangleBorder( // Change shape of SnackBar
    //                             borderRadius: BorderRadius.circular(24),
    //                           ),
    //                         ),
    //                       );
    //                       rewardPoints = rewardPoints + 0.7;
    //                     } else if (items[selectedIndex] == '1.0 POINTS') {
    //                       ScaffoldMessenger.of(context).showSnackBar(
    //                         SnackBar(
    //                           content: Text('YOU GOT 1.0 POINTS !'),
    //                           backgroundColor: Colors.green, // Change color of SnackBar
    //                           behavior: SnackBarBehavior.floating, // Make SnackBar floating
    //                           shape: RoundedRectangleBorder( // Change shape of SnackBar
    //                             borderRadius: BorderRadius.circular(24),
    //                           ),
    //                         ),
    //                       );
    //                       rewardPoints = rewardPoints + 1.0;
    //                     }
    //
    //                     updatePoints();
    //                   });
    //                 });
    //               }
    //                   : null,
    //
    //               child: Text('Spinning'),
    //             ),
    //           ),
    //         ),
    //         SizedBox(height: 20,),
    //         Center(
    //           child: Showcase(
    //             key: _rewardPointKey,
    //             description: 'Reward Button to get the rewards from the Reward points. Only active for reward points is greater than 50.0',
    //             child: ElevatedButton(
    //               style: ElevatedButton.styleFrom(
    //                 minimumSize: Size(200.0, 60.0),
    //                 elevation: 4.0, // Set the elevation of the button
    //                 backgroundColor: rewardPoints >= 50 ? Colors.green[800] : Colors.grey, // Set the background color of the button
    //                 shape: RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(15.0), // Set the border radius of the button
    //                 ),
    //               ),
    //               onPressed: () {
    //                 if (rewardPoints >= 50) {
    //                   // Your code to get rewards
    //                   Navigator.push(
    //                     context,
    //                     MaterialPageRoute(builder: (context) => RewardGiveAway()), // Replace SecondPage with your desired destination page
    //                   );
    //                 } else {
    //                   ScaffoldMessenger.of(context).showSnackBar(
    //                     SnackBar(content: Text('Reward point need 50 or more to activate this button')),
    //                   );
    //                 }
    //               },
    //               child: Text(rewardPoints >= 50 ? 'Get Reward' : 'Reward Points \n$rewardPoints',
    //                 textAlign: TextAlign.center,
    //                 style: TextStyle(
    //                   fontSize: 20, // Adjust the font size as needed
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200.0, 60.0),
                elevation: 4.0, // Set the elevation of the button
                backgroundColor: rewardPoints >= 50 ? Colors.green[800] : Colors.grey, // Set the background color of the button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0), // Set the border radius of the button
                ),
              ),
              onPressed: () {
                if (rewardPoints >= 50) {
                  // Your code to get rewards
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RewardGiveAway()), // Replace SecondPage with your desired destination page
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Reward point need 50 or more to activate this button')),
                  );
                }
              },
              child: Text(rewardPoints >= 50 ? 'Get Reward' : 'Reward Points \n$rewardPoints',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20, // Adjust the font size as needed
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
