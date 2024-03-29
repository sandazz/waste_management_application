import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  //showcase
  final GlobalKey _one = GlobalKey();
  final GlobalKey _two = GlobalKey();
  final GlobalKey _three = GlobalKey();


  final User currentUser = FirebaseAuth.instance.currentUser!;

  int plasticAmount = 0;
  int caneAmount = 0;
  int glassAmount = 0;
  int binAmount = 0;
  int bottleAmount = 0;

  int rewardPoints = 0;

  Future<void> getPoints() async {

    String uid = currentUser.uid;

    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection("recycledWasteEndUser")
        .doc(uid)
        .get();

     if (documentSnapshot.exists) {
       Map<String, dynamic> userData = documentSnapshot.data() as Map<String, dynamic>;
       setState(() {
         plasticAmount = userData['plasticAmount'];
         bottleAmount = userData['bottleAmount'];
         rewardPoints = userData['rewardPoints'];
       });
     } else {
       print("User not found");
     }
  }

  // Descriptions
  void showCaseCall()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Check if 'showedShowcase' is already stored in shared preferences.
    bool showedShowcaseHome = prefs.getBool('showedShowcaseHome') ?? false;

    if (!showedShowcaseHome) {
      // If not stored, this is the first time, so show the showcase.
      WidgetsBinding.instance.addPostFrameCallback((_) =>
          ShowCaseWidget.of(context).startShowCase([_one, _two, _three]),
      );

      // Now, set 'showedShowcase' to true, indicating the showcase has been shown.
      await prefs.setBool('showedShowcaseHome', true);
    }
  }


  @override
  void initState() {
    super.initState();
    getPoints();
    showCaseCall();
  }



  @override
  Widget build(BuildContext context) {
    return
        Scaffold(
          body: Stack(
              alignment: Alignment.bottomCenter,
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Showcase(
                      key: _one,
                      description: 'Points collected when you recycle',
                      child: Container(
                        width: 170.0, // Set the width of the container
                        padding: EdgeInsets.fromLTRB(16.0,30.0,16.0,30.0), // Set the padding within the container
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
                                'Reward Points',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 30.0,
                                    fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5.0),
                              Icon(
                                  Icons.recycling,
                                size: 50.0,
                              ),
                              SizedBox(height: 5.0),
                              Text(
                                "$rewardPoints",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 25.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    AspectRatio(
                      aspectRatio: 6/2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Showcase(
                            key: _two,
                            description: 'Bottle amount recycled',
                            child: Container(
                              width: 110.0, // Set the width of the container
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
                          ),
                          Showcase(
                            key: _three,
                            description: 'Plastic amount recycled',
                            child: Container(
                              width: 110.0, // Set the width of the container
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
                                      size: 32.0,
                                    ),
                                    SizedBox(height: 5.0),
                                    Text(
                                      '$plasticAmount',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // Container(
                          //   width: 110.0, // Set the width of the container
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
                          //           'Cane',
                          //           textAlign: TextAlign.center,
                          //           style: TextStyle(
                          //             fontSize: 22.0,
                          //             fontWeight: FontWeight.bold,
                          //           ),
                          //         ),
                          //         SizedBox(height: 5.0),
                          //         Icon(
                          //           Icons.ad_units_outlined,
                          //           size: 30.0,
                          //         ),
                          //         SizedBox(height: 5.0),
                          //         Text(
                          //           caneAmount,
                          //           textAlign: TextAlign.center,
                          //           style: TextStyle(
                          //             fontSize: 20.0,
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          // Container(
                          //   width: 110.0, // Set the width of the container
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
                          //           glassAmount,
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
                    ),
                    // Container(
                    //   width: 110.0, // Set the width of the container
                    //   padding: EdgeInsets.all(16.0), // Set the padding within the container
                    //   margin: EdgeInsets.all(8.0), // Set the margin around the container
                    //   decoration: BoxDecoration(
                    //     color: Colors.green[100], // Set the background color of the container
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
                    //           'Bins',
                    //           textAlign: TextAlign.center,
                    //           style: TextStyle(
                    //             fontSize: 22.0,
                    //             fontWeight: FontWeight.bold,
                    //           ),
                    //         ),
                    //         SizedBox(height: 5.0),
                    //         Icon(
                    //           Icons.delete_outline,
                    //           size: 30.0,
                    //         ),
                    //         SizedBox(height: 5.0),
                    //         Text(
                    //           binAmount,
                    //           textAlign: TextAlign.center,
                    //           style: TextStyle(
                    //             fontSize: 20.0,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: 60.0,)
                  ],
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.only(bottom: 16.0), // Add padding to adjust the button's position
              //   child: ElevatedButton(
              //     style: ElevatedButton.styleFrom(
              //       minimumSize: Size(150.0, 40.0),
              //       elevation: 4.0, // Set the elevation of the button
              //       backgroundColor: Colors.green[700], // Set the background color of the button
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(15.0), // Set the border radius of the button
              //       ),
              //     ),
              //     onPressed: () {
              //       // Handle button press
              //     },
              //     child: Text('Locations'),
              //   ),
              // ),
            ]
          ),
        )
      ;
  }
}
