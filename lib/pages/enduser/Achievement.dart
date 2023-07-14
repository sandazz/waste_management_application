import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Achievement extends StatefulWidget {
  const Achievement({Key? key}) : super(key: key);

  @override
  State<Achievement> createState() => _AchievementState();
}

class _AchievementState extends State<Achievement> {

  final User currentUser = FirebaseAuth.instance.currentUser!;

  int plasticAmount = 0 ;
  String achievementPlasticURL = "assets/achievements/no.png";
  String achievementPlasticBadge = "No Badges";

  int caneAmount = 0 ;
  String achievementCaneURL = "assets/achievements/no.png";
  String achievementCaneBadge = "No Badges";

  int glassAmount = 0 ;
  String achievementGlassURL = "assets/achievements/no.png";
  String achievementGlassBadge = "No Badges";

  int binAmount = 0 ;
  String achievementBinURL = "assets/achievements/no.png";
  String achievementBinBadge = "No Badges";

  Future<void> getPoints() async {

    String uid = currentUser.uid;

    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection("recycledWasteEndUser")
        .doc(uid)
        .get();

    if (documentSnapshot.exists) {
      Map<String, dynamic> userData = documentSnapshot.data() as Map<String, dynamic>;
      setState(() {
        plasticAmount = int.parse(userData['plasticAmount']);
      });
    } else {
      print("User not found");
    }

    if(plasticAmount>=100){
      achievementPlasticURL = "assets/achievements/3.png";
      achievementPlasticBadge = "Eco-Warrior";
    }else if(plasticAmount>=10){
      achievementPlasticURL = "assets/achievements/2.png";
      achievementPlasticBadge = "Getting Started";
    } else if(plasticAmount >= 1){
      achievementPlasticURL = "assets/achievements/1.png";
      achievementPlasticBadge = "Baby Step";
    }
  }

  @override
  void initState() {
    super.initState();
    getPoints();
  }

  @override
  Widget build(BuildContext context) {
    return
        Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Text(
                  'Achievement',
                  style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 85.0, // Set the width of the container
                    padding: EdgeInsets.fromLTRB(16.0,10.0,16.0,10.0),
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
                            'Bottle',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                          SizedBox(height: 2.0),
                          Container(
                            child: Image.asset(
                              achievementPlasticURL, // Replace "image.jpg" with the actual filename and extension of your image
                              fit: BoxFit.cover, // Choose the desired fit option (e.g., BoxFit.cover, BoxFit.fill)
                            ),
                          ),
                          SizedBox(height: 2.0),
                          Text(
                            achievementPlasticBadge,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 85.0, // Set the width of the container
                    padding: EdgeInsets.fromLTRB(16.0,10.0,16.0,10.0),
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
                            'Cane',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                          SizedBox(height: 2.0),
                          Container(
                            child: Image.asset(
                              achievementCaneURL, // Replace "image.jpg" with the actual filename and extension of your image
                              fit: BoxFit.cover, // Choose the desired fit option (e.g., BoxFit.cover, BoxFit.fill)
                            ),
                          ),
                          SizedBox(height: 2.0),
                          Text(
                            achievementCaneBadge,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 85.0, // Set the width of the container
                    padding: EdgeInsets.fromLTRB(16.0,10.0,16.0,10.0),
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
                            'Glass',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                          SizedBox(height: 2.0),
                          Container(
                            child: Image.asset(
                              achievementGlassURL, // Replace "image.jpg" with the actual filename and extension of your image
                              fit: BoxFit.cover, // Choose the desired fit option (e.g., BoxFit.cover, BoxFit.fill)
                            ),
                          ),
                          SizedBox(height: 2.0),
                          Text(
                            achievementGlassBadge,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 85.0, // Set the width of the container
                    padding: EdgeInsets.fromLTRB(16.0,10.0,16.0,10.0),
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
                            'Bin',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                          SizedBox(height: 2.0),
                          Container(
                            child: Image.asset(
                              achievementBinURL, // Replace "image.jpg" with the actual filename and extension of your image
                              fit: BoxFit.cover, // Choose the desired fit option (e.g., BoxFit.cover, BoxFit.fill)
                            ),
                          ),
                          SizedBox(height: 2.0),
                          Text(
                            achievementBinBadge,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  children: [
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(16.0), // Set the padding within the container
                          margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0), // Set the margin around the container
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
                          child: Column(
                            children: [
                              Container(
                                  width: 500.0, // Set the width of the container
                                  height: 40.0,// Set the height of the container
                                  margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 3.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white, // Set the background color of the container
                                    borderRadius: BorderRadius.circular(15.0), // Set the border radius of the container
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1.0,
                                        blurRadius: 2.0,
                                        offset: Offset(0, 3), // Adjust the shadow position as needed
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align the children at the start and end of the row
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 20.0),
                                        child: Text(
                                          "${plasticAmount >= 1 ? '1' : plasticAmount}/1",
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            'Baby step',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(right: 20.0),
                                        child: Image.asset(
                                          'assets/achievements/1.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                              ),
                              Container(
                                  width: 500.0, // Set the width of the container
                                  height: 40.0,// Set the height of the container
                                  margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 3.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white, // Set the background color of the container
                                    borderRadius: BorderRadius.circular(15.0), // Set the border radius of the container
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1.0,
                                        blurRadius: 2.0,
                                        offset: Offset(0, 3), // Adjust the shadow position as needed
                                      ),
                                    ],
                                  ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align the children at the start and end of the row
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        "${plasticAmount >= 10 ? '10' : plasticAmount}/10",
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          'Getting Started',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(right: 20.0),
                                      child: Image.asset(
                                        'assets/achievements/2.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                  width: 500.0, // Set the width of the container
                                  height: 40.0,// Set the height of the container
                                  margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 3.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white, // Set the background color of the container
                                    borderRadius: BorderRadius.circular(15.0), // Set the border radius of the container
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1.0,
                                        blurRadius: 2.0,
                                        offset: Offset(0, 3), // Adjust the shadow position as needed
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align the children at the start and end of the row
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 20.0),
                                        child: Text(
                                          "${plasticAmount >= 100 ? '100' : plasticAmount}/100",
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            'Eco-Warrior',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(right: 20.0),
                                        child: Image.asset(
                                          'assets/achievements/3.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(16.0), // Set the padding within the container
                          margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0), // Set the margin around the container
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
                          child: Column(
                            children: [
                              Container(
                                width: 500.0, // Set the width of the container
                                height: 40.0,// Set the height of the container
                                margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 3.0),
                                decoration: BoxDecoration(
                                  color: Colors.white, // Set the background color of the container
                                  borderRadius: BorderRadius.circular(15.0), // Set the border radius of the container
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1.0,
                                      blurRadius: 2.0,
                                      offset: Offset(0, 3), // Adjust the shadow position as needed
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align the children at the start and end of the row
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        "${plasticAmount >= 1 ? '1' : plasticAmount}/1",
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          'Curious',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(right: 20.0),
                                      child: Image.asset(
                                        'assets/achievements/4.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 500.0, // Set the width of the container
                                height: 40.0,// Set the height of the container
                                margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 3.0),
                                decoration: BoxDecoration(
                                  color: Colors.white, // Set the background color of the container
                                  borderRadius: BorderRadius.circular(15.0), // Set the border radius of the container
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1.0,
                                      blurRadius: 2.0,
                                      offset: Offset(0, 3), // Adjust the shadow position as needed
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align the children at the start and end of the row
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        "${plasticAmount >= 10 ? '10' : plasticAmount}/10",
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          'Lucky',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(right: 20.0),
                                      child: Image.asset(
                                        'assets/achievements/5.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 500.0, // Set the width of the container
                                height: 40.0,// Set the height of the container
                                margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 3.0),
                                decoration: BoxDecoration(
                                  color: Colors.white, // Set the background color of the container
                                  borderRadius: BorderRadius.circular(15.0), // Set the border radius of the container
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1.0,
                                      blurRadius: 2.0,
                                      offset: Offset(0, 3), // Adjust the shadow position as needed
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align the children at the start and end of the row
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        "${plasticAmount >= 100 ? '100' : plasticAmount}/100",
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          'Explorer',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(right: 20.0),
                                      child: Image.asset(
                                        'assets/achievements/6.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(16.0), // Set the padding within the container
                          margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0), // Set the margin around the container
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
                          child: Column(
                            children: [
                              Container(
                                width: 500.0, // Set the width of the container
                                height: 40.0,// Set the height of the container
                                margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 3.0),
                                decoration: BoxDecoration(
                                  color: Colors.white, // Set the background color of the container
                                  borderRadius: BorderRadius.circular(15.0), // Set the border radius of the container
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1.0,
                                      blurRadius: 2.0,
                                      offset: Offset(0, 3), // Adjust the shadow position as needed
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align the children at the start and end of the row
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        "${plasticAmount >= 1 ? '1' : plasticAmount}/1",
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          'Day 01',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(right: 20.0),
                                      child: Image.asset(
                                        'assets/achievements/7.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 500.0, // Set the width of the container
                                height: 40.0,// Set the height of the container
                                margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 3.0),
                                decoration: BoxDecoration(
                                  color: Colors.white, // Set the background color of the container
                                  borderRadius: BorderRadius.circular(15.0), // Set the border radius of the container
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1.0,
                                      blurRadius: 2.0,
                                      offset: Offset(0, 3), // Adjust the shadow position as needed
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align the children at the start and end of the row
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        "${plasticAmount >= 10 ? '10' : plasticAmount}/10",
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          'Behaviour',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(right: 20.0),
                                      child: Image.asset(
                                        'assets/achievements/8.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 500.0, // Set the width of the container
                                height: 40.0,// Set the height of the container
                                margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 3.0),
                                decoration: BoxDecoration(
                                  color: Colors.white, // Set the background color of the container
                                  borderRadius: BorderRadius.circular(15.0), // Set the border radius of the container
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1.0,
                                      blurRadius: 2.0,
                                      offset: Offset(0, 3), // Adjust the shadow position as needed
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align the children at the start and end of the row
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        "${plasticAmount >= 100 ? '100' : plasticAmount}/100",
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          'Habit',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(right: 20.0),
                                      child: Image.asset(
                                        'assets/achievements/9.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(16.0), // Set the padding within the container
                          margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0), // Set the margin around the container
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
                          child: Column(
                            children: [
                              Container(
                                width: 500.0, // Set the width of the container
                                height: 40.0,// Set the height of the container
                                margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 3.0),
                                decoration: BoxDecoration(
                                  color: Colors.white, // Set the background color of the container
                                  borderRadius: BorderRadius.circular(15.0), // Set the border radius of the container
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1.0,
                                      blurRadius: 2.0,
                                      offset: Offset(0, 3), // Adjust the shadow position as needed
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align the children at the start and end of the row
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        "${plasticAmount >= 1 ? '1' : plasticAmount}/1",
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          'Help',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(right: 20.0),
                                      child: Image.asset(
                                        'assets/achievements/10.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 500.0, // Set the width of the container
                                height: 40.0,// Set the height of the container
                                margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 3.0),
                                decoration: BoxDecoration(
                                  color: Colors.white, // Set the background color of the container
                                  borderRadius: BorderRadius.circular(15.0), // Set the border radius of the container
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1.0,
                                      blurRadius: 2.0,
                                      offset: Offset(0, 3), // Adjust the shadow position as needed
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align the children at the start and end of the row
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        "${plasticAmount >= 10 ? '10' : plasticAmount}/10",
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          'Hellp',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(right: 20.0),
                                      child: Image.asset(
                                        'assets/achievements/11.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 500.0, // Set the width of the container
                                height: 40.0,// Set the height of the container
                                margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 3.0),
                                decoration: BoxDecoration(
                                  color: Colors.white, // Set the background color of the container
                                  borderRadius: BorderRadius.circular(15.0), // Set the border radius of the container
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1.0,
                                      blurRadius: 2.0,
                                      offset: Offset(0, 3), // Adjust the shadow position as needed
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align the children at the start and end of the row
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        "${plasticAmount >= 100 ? '100' : plasticAmount}/100",
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          'Helllp',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(right: 20.0),
                                      child: Image.asset(
                                        'assets/achievements/12.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(16.0), // Set the padding within the container
                          margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0), // Set the margin around the container
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
                          child: Column(
                            children: [
                              Container(
                                width: 500.0, // Set the width of the container
                                height: 40.0,// Set the height of the container
                                margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 3.0),
                                decoration: BoxDecoration(
                                  color: Colors.white, // Set the background color of the container
                                  borderRadius: BorderRadius.circular(15.0), // Set the border radius of the container
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1.0,
                                      blurRadius: 2.0,
                                      offset: Offset(0, 3), // Adjust the shadow position as needed
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align the children at the start and end of the row
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        "${plasticAmount >= 1 ? '1' : plasticAmount}/1",
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          'Do You Know',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(right: 20.0),
                                      child: Image.asset(
                                        'assets/achievements/13.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 500.0, // Set the width of the container
                                height: 40.0,// Set the height of the container
                                margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 3.0),
                                decoration: BoxDecoration(
                                  color: Colors.white, // Set the background color of the container
                                  borderRadius: BorderRadius.circular(15.0), // Set the border radius of the container
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1.0,
                                      blurRadius: 2.0,
                                      offset: Offset(0, 3), // Adjust the shadow position as needed
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align the children at the start and end of the row
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        "${plasticAmount >= 10 ? '10' : plasticAmount}/10",
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          'Influencer',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(right: 20.0),
                                      child: Image.asset(
                                        'assets/achievements/14.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 500.0, // Set the width of the container
                                height: 40.0,// Set the height of the container
                                margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 3.0),
                                decoration: BoxDecoration(
                                  color: Colors.white, // Set the background color of the container
                                  borderRadius: BorderRadius.circular(15.0), // Set the border radius of the container
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1.0,
                                      blurRadius: 2.0,
                                      offset: Offset(0, 3), // Adjust the shadow position as needed
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align the children at the start and end of the row
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        "${plasticAmount >= 100 ? '100' : plasticAmount}/100",
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          'Social Media Star',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(right: 20.0),
                                      child: Image.asset(
                                        'assets/achievements/15.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(16.0), // Set the padding within the container
                          margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0), // Set the margin around the container
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
                          child: Column(
                            children: [
                              Container(
                                width: 500.0, // Set the width of the container
                                height: 40.0,// Set the height of the container
                                margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 3.0),
                                decoration: BoxDecoration(
                                  color: Colors.white, // Set the background color of the container
                                  borderRadius: BorderRadius.circular(15.0), // Set the border radius of the container
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1.0,
                                      blurRadius: 2.0,
                                      offset: Offset(0, 3), // Adjust the shadow position as needed
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align the children at the start and end of the row
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        "${plasticAmount >= 1 ? '1' : plasticAmount}/1",
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          'Friend',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(right: 20.0),
                                      child: Image.asset(
                                        'assets/achievements/16.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 500.0, // Set the width of the container
                                height: 40.0,// Set the height of the container
                                margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 3.0),
                                decoration: BoxDecoration(
                                  color: Colors.white, // Set the background color of the container
                                  borderRadius: BorderRadius.circular(15.0), // Set the border radius of the container
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1.0,
                                      blurRadius: 2.0,
                                      offset: Offset(0, 3), // Adjust the shadow position as needed
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align the children at the start and end of the row
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        "${plasticAmount >= 10 ? '10' : plasticAmount}/10",
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          'Best Friend',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(right: 20.0),
                                      child: Image.asset(
                                        'assets/achievements/17.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 500.0, // Set the width of the container
                                height: 40.0,// Set the height of the container
                                margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 3.0),
                                decoration: BoxDecoration(
                                  color: Colors.white, // Set the background color of the container
                                  borderRadius: BorderRadius.circular(15.0), // Set the border radius of the container
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1.0,
                                      blurRadius: 2.0,
                                      offset: Offset(0, 3), // Adjust the shadow position as needed
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align the children at the start and end of the row
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        "${plasticAmount >= 100 ? '100' : plasticAmount}/100",
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          'Friend in Need',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(right: 20.0),
                                      child: Image.asset(
                                        'assets/achievements/18.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
    ;
  }
}
