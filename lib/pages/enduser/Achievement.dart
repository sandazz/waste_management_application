import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

class Achievement extends StatefulWidget {
  const Achievement({Key? key}) : super(key: key);

  @override
  State<Achievement> createState() => _AchievementState();
}

class _AchievementState extends State<Achievement> {

  final User currentUser = FirebaseAuth.instance.currentUser!;

  // Show case labels
  final GlobalKey _bottleShowCaseKey = GlobalKey();
  final GlobalKey _plasticShowCaseKey = GlobalKey();
  final GlobalKey _bottleAchievementShowCaseKey = GlobalKey();
  final GlobalKey _plasticAchievementShowCaseKey = GlobalKey();


  int plasticAmount = 0 ;
  String achievementPlasticURL = "assets/achievements/no.png";
  String achievementPlasticBadge = "No Badges";

  int bottleAmount = 0 ;
  String achievementBottleURL = "assets/achievements/no.png";
  String achievementBottleBadge = "No Badges";

  int caneAmount = 0 ;
  String achievementCaneURL = "assets/achievements/no.png";
  String achievementCaneBadge = "No Badges";

  int glassAmount = 0 ;
  String achievementGlassURL = "assets/achievements/no.png";
  String achievementGlassBadge = "No Badges";

  int usageAmount = 0 ;
  String achievementUsageURL = "assets/achievements/no.png";
  String achievementUsageBadge = "No Badges";

  int socialAmount = 0 ;
  String achievementSocialURL = "assets/achievements/no.png";
  String achievementSocialBadge = "No Badges";

  int binAmount = 0 ;
  String achievementBinURL = "assets/achievements/no.png";
  String achievementBinBadge = "No Badges";

  int MediaAmount = 0 ;
  String achievementMediaURL = "assets/achievements/no.png";
  String achievementMediaBadge = "No Badges";

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
        // usageAmount = 4;
        // MediaAmount = 5;
        // socialAmount = 11;

      });
    } else {
      print("User not found");
    }

    //plastic badges
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

    //bottle badges
    if(bottleAmount>=1000){
      achievementBottleURL = "assets/achievements/3.png";
      achievementBottleBadge = "Eco-Warrior";
    }else if(bottleAmount>=100){
      achievementBottleURL = "assets/achievements/2.png";
      achievementBottleBadge = "Getting Started";
    } else if(bottleAmount >= 1){
      achievementBottleURL = "assets/achievements/1.png";
      achievementBottleBadge = "Baby Step";
    }

    //cane badges
    if(caneAmount>=100){
      achievementCaneURL = "assets/achievements/3.png";
      achievementCaneBadge = "Eco-Warrior";
    }else if(caneAmount>=10){
      achievementCaneURL = "assets/achievements/2.png";
      achievementCaneBadge = "Getting Started";
    } else if(caneAmount >= 1){
      achievementCaneURL = "assets/achievements/1.png";
      achievementCaneBadge = "Baby Step";
    }

    //glass badges
    if(glassAmount>=100){
      achievementGlassURL = "assets/achievements/3.png";
      achievementGlassBadge = "Eco-Warrior";
    }else if(glassAmount>=10){
      achievementGlassURL = "assets/achievements/2.png";
      achievementGlassBadge = "Getting Started";
    } else if(glassAmount >= 1){
      achievementGlassURL = "assets/achievements/1.png";
      achievementGlassBadge = "Baby Step";
    }

    //bin Badges
    if(binAmount>=100){
      achievementBinURL = "assets/achievements/6.png";
      achievementBinBadge = "Explorer";
    }else if(binAmount>=10){
      achievementBinURL = "assets/achievements/5.png";
      achievementBinBadge = "Lucky";
    } else if(binAmount >= 1){
      achievementBinURL = "assets/achievements/4.png";
      achievementBinBadge = "Curious";
    }

    //usage Badges
    if(usageAmount>=100){
      achievementUsageURL = "assets/achievements/9.png";
      achievementUsageBadge = "Habit";
    }else if(usageAmount>=10){
      achievementUsageURL = "assets/achievements/8.png";
      achievementUsageBadge = "Behavior";
    } else if(usageAmount >= 1){
      achievementUsageURL = "assets/achievements/7.png";
      achievementUsageBadge = "Day 01";
    }

    //media Badges
    if(MediaAmount>=100){
      achievementMediaURL = "assets/achievements/15.png";
      achievementMediaBadge = "Social Media Star";
    }else if(MediaAmount>=10){
      achievementMediaURL = "assets/achievements/14.png";
      achievementMediaBadge = "Influencer";
    } else if(MediaAmount >= 1){
      achievementMediaURL = "assets/achievements/13.png";
      achievementMediaBadge = "Do You Know";
    }

    //social Badges
    if(socialAmount>=100){
      achievementSocialURL = "assets/achievements/18.png";
      achievementSocialBadge = "Friend in Need";
    }else if(socialAmount>=10){
      achievementSocialURL = "assets/achievements/17.png";
      achievementSocialBadge = "Best Friend";
    } else if(socialAmount >= 1){
      achievementSocialURL = "assets/achievements/16.png";
      achievementSocialBadge = "Friend";
    }
  }

  Future<void> showCaseCall() async {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   ShowCaseWidget.of(context).startShowCase([_bottleShowCaseKey, _plasticShowCaseKey, _bottleAchievementShowCaseKey, _plasticAchievementShowCaseKey]);
    // });

    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Check if 'showedShowcase' is already stored in shared preferences.
    bool showedShowcaseAchievement = prefs.getBool('showedShowcaseAchievement') ?? false;

    if (!showedShowcaseAchievement) {
      // If not stored, this is the first time, so show the showcase.
      WidgetsBinding.instance.addPostFrameCallback((_) =>
          ShowCaseWidget.of(context).startShowCase([_bottleShowCaseKey, _plasticShowCaseKey, _bottleAchievementShowCaseKey, _plasticAchievementShowCaseKey])
      );

      // Now, set 'showedShowcase' to true, indicating the showcase has been shown.
      await prefs.setBool('showedShowcaseAchievement', true);
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
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Showcase(
                      key: _bottleShowCaseKey,
                      description: 'Bottle achievements User achieved',
                      child: Container(
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
                                  achievementBottleURL, // Replace "image.jpg" with the actual filename and extension of your image
                                  fit: BoxFit.cover, // Choose the desired fit option (e.g., BoxFit.cover, BoxFit.fill)
                                ),
                              ),
                              SizedBox(height: 2.0),
                              Text(
                                achievementBottleBadge,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Showcase(
                      key: _plasticShowCaseKey,
                      description: 'Plastic achievement User achieved',
                      child: Container(
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
                                'Plastic',
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
                    ),

                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    Column(
                      children: [
                        Showcase(
                          key: _bottleAchievementShowCaseKey,
                          description: 'Bottle Achievements User can Achieve',
                          child: Container(
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
                                  margin: EdgeInsets.only(bottom: 10.0),
                                  child: Text(
                                    "Bottle",
                                    textAlign: TextAlign.left, // This is for text alignment.
                                    style: TextStyle(
                                      fontSize: 20.0,     // Change the font size.// Change the font family.
                                      fontWeight: FontWeight.bold,  // Change the font weight.
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 500.0, // Set the width of the container
                                  height: 40.0,// Set the height of the container
                                  margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 3.0),
                                  decoration: BoxDecoration(
                                    color: bottleAmount >= 1 ? Colors.white38 : Colors.white, // Set the background color of the container
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
                                          "${bottleAmount >= 1 ? '1' : bottleAmount}/1",
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            'Baby step',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              decoration:  bottleAmount > 1 ? TextDecoration.lineThrough : null,
                                            ),
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
                                    color: bottleAmount >= 100 ? Colors.white38 : Colors.white, // Set the background color of the container
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
                                          "${bottleAmount >= 100 ? '100' : bottleAmount}/100",
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            'Getting Started',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              decoration:  bottleAmount > 100 ? TextDecoration.lineThrough : null,
                                            ),
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
                                    color: bottleAmount >= 1000 ? Colors.white38 : Colors.white, // Set the background color of the container
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
                                          "${bottleAmount >= 1000 ? '1000' : bottleAmount}/1000",
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            'Eco-Warrior',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              decoration:  bottleAmount > 1000 ? TextDecoration.lineThrough : null,
                                            ),
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
                        ),
                        Showcase(
                          key: _plasticAchievementShowCaseKey,
                          description: 'Plastic Achievements User can Achieve',
                          child: Container(
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
                                  margin: EdgeInsets.only(bottom: 10.0),
                                  child: Text(
                                    "Plastic",
                                    textAlign: TextAlign.left, // This is for text alignment.
                                    style: TextStyle(
                                      fontSize: 20.0,     // Change the font size.// Change the font family.
                                      fontWeight: FontWeight.bold,  // Change the font weight.
                                    ),
                                  ),
                                ),
                                Container(
                                    width: 500.0, // Set the width of the container
                                    height: 40.0,// Set the height of the container
                                    margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 3.0),
                                    decoration: BoxDecoration(
                                      color: plasticAmount >= 1 ? Colors.white38 : Colors.white, // Set the background color of the container
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
                                              style: TextStyle(
                                                decoration:  plasticAmount > 1 ? TextDecoration.lineThrough : null,
                                              ),
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
                                      color: plasticAmount >= 10 ? Colors.white38 : Colors.white, // Set the background color of the container
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
                                            style: TextStyle(
                                              decoration:  plasticAmount > 10 ? TextDecoration.lineThrough : null,
                                            ),
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
                                      color: plasticAmount >= 100 ? Colors.white38 : Colors.white, // Set the background color of the container
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
                                              style: TextStyle(
                                                decoration:  plasticAmount > 100 ? TextDecoration.lineThrough : null,
                                              ),
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
                        ),
                        // Container(
                        //   padding: EdgeInsets.all(16.0), // Set the padding within the container
                        //   margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0), // Set the margin around the container
                        //   decoration: BoxDecoration(
                        //     color: Colors.green, // Set the background color of the container
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
                        //   child: Column(
                        //     children: [
                        //       Container(
                        //         margin: EdgeInsets.only(bottom: 10.0),
                        //         child: Text(
                        //           "Cane",
                        //           textAlign: TextAlign.left, // This is for text alignment.
                        //           style: TextStyle(
                        //             fontSize: 20.0,     // Change the font size.// Change the font family.
                        //             fontWeight: FontWeight.bold,  // Change the font weight.
                        //           ),
                        //         ),
                        //       ),
                        //       Container(
                        //         width: 500.0, // Set the width of the container
                        //         height: 40.0,// Set the height of the container
                        //         margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 3.0),
                        //         decoration: BoxDecoration(
                        //           color: Colors.white, // Set the background color of the container
                        //           borderRadius: BorderRadius.circular(15.0), // Set the border radius of the container
                        //           boxShadow: [
                        //             BoxShadow(
                        //               color: Colors.grey.withOpacity(0.5),
                        //               spreadRadius: 1.0,
                        //               blurRadius: 2.0,
                        //               offset: Offset(0, 3), // Adjust the shadow position as needed
                        //             ),
                        //           ],
                        //         ),
                        //         child: Row(
                        //           mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align the children at the start and end of the row
                        //           children: [
                        //             Padding(
                        //               padding: EdgeInsets.only(left: 20.0),
                        //               child: Text(
                        //                 "${caneAmount >= 1 ? '1' : caneAmount}/1",
                        //                 textAlign: TextAlign.left,
                        //               ),
                        //             ),
                        //             Expanded(
                        //               child: Center(
                        //                 child: Text(
                        //                   'Baby step',
                        //                   textAlign: TextAlign.center,
                        //                 ),
                        //               ),
                        //             ),
                        //             Container(
                        //               padding: EdgeInsets.only(right: 20.0),
                        //               child: Image.asset(
                        //                 'assets/achievements/1.png',
                        //                 fit: BoxFit.cover,
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //       Container(
                        //         width: 500.0, // Set the width of the container
                        //         height: 40.0,// Set the height of the container
                        //         margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 3.0),
                        //         decoration: BoxDecoration(
                        //           color: Colors.white, // Set the background color of the container
                        //           borderRadius: BorderRadius.circular(15.0), // Set the border radius of the container
                        //           boxShadow: [
                        //             BoxShadow(
                        //               color: Colors.grey.withOpacity(0.5),
                        //               spreadRadius: 1.0,
                        //               blurRadius: 2.0,
                        //               offset: Offset(0, 3), // Adjust the shadow position as needed
                        //             ),
                        //           ],
                        //         ),
                        //         child: Row(
                        //           mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align the children at the start and end of the row
                        //           children: [
                        //             Padding(
                        //               padding: EdgeInsets.only(left: 20.0),
                        //               child: Text(
                        //                 "${caneAmount >= 10 ? '10' : caneAmount}/10",
                        //                 textAlign: TextAlign.left,
                        //               ),
                        //             ),
                        //             Expanded(
                        //               child: Center(
                        //                 child: Text(
                        //                   'Getting Started',
                        //                   textAlign: TextAlign.center,
                        //                 ),
                        //               ),
                        //             ),
                        //             Container(
                        //               padding: EdgeInsets.only(right: 20.0),
                        //               child: Image.asset(
                        //                 'assets/achievements/2.png',
                        //                 fit: BoxFit.cover,
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //       Container(
                        //         width: 500.0, // Set the width of the container
                        //         height: 40.0,// Set the height of the container
                        //         margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 3.0),
                        //         decoration: BoxDecoration(
                        //           color: Colors.white, // Set the background color of the container
                        //           borderRadius: BorderRadius.circular(15.0), // Set the border radius of the container
                        //           boxShadow: [
                        //             BoxShadow(
                        //               color: Colors.grey.withOpacity(0.5),
                        //               spreadRadius: 1.0,
                        //               blurRadius: 2.0,
                        //               offset: Offset(0, 3), // Adjust the shadow position as needed
                        //             ),
                        //           ],
                        //         ),
                        //         child: Row(
                        //           mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align the children at the start and end of the row
                        //           children: [
                        //             Padding(
                        //               padding: EdgeInsets.only(left: 20.0),
                        //               child: Text(
                        //                 "${caneAmount >= 100 ? '100' : caneAmount}/100",
                        //                 textAlign: TextAlign.left,
                        //               ),
                        //             ),
                        //             Expanded(
                        //               child: Center(
                        //                 child: Text(
                        //                   'Eco-Warrior',
                        //                   textAlign: TextAlign.center,
                        //                 ),
                        //               ),
                        //             ),
                        //             Container(
                        //               padding: EdgeInsets.only(right: 20.0),
                        //               child: Image.asset(
                        //                 'assets/achievements/3.png',
                        //                 fit: BoxFit.cover,
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // Container(
                        //   padding: EdgeInsets.all(16.0), // Set the padding within the container
                        //   margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0), // Set the margin around the container
                        //   decoration: BoxDecoration(
                        //     color: Colors.green, // Set the background color of the container
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
                        //   child: Column(
                        //     children: [
                        //       Container(
                        //         margin: EdgeInsets.only(bottom: 10.0),
                        //         child: Text(
                        //           "Glass",
                        //           textAlign: TextAlign.left, // This is for text alignment.
                        //           style: TextStyle(
                        //             fontSize: 20.0,     // Change the font size.// Change the font family.
                        //             fontWeight: FontWeight.bold,  // Change the font weight.
                        //           ),
                        //         ),
                        //       ),
                        //       Container(
                        //         width: 500.0, // Set the width of the container
                        //         height: 40.0,// Set the height of the container
                        //         margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 3.0),
                        //         decoration: BoxDecoration(
                        //           color: Colors.white, // Set the background color of the container
                        //           borderRadius: BorderRadius.circular(15.0), // Set the border radius of the container
                        //           boxShadow: [
                        //             BoxShadow(
                        //               color: Colors.grey.withOpacity(0.5),
                        //               spreadRadius: 1.0,
                        //               blurRadius: 2.0,
                        //               offset: Offset(0, 3), // Adjust the shadow position as needed
                        //             ),
                        //           ],
                        //         ),
                        //         child: Row(
                        //           mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align the children at the start and end of the row
                        //           children: [
                        //             Padding(
                        //               padding: EdgeInsets.only(left: 20.0),
                        //               child: Text(
                        //                 "${glassAmount >= 1 ? '1' : glassAmount}/1",
                        //                 textAlign: TextAlign.left,
                        //               ),
                        //             ),
                        //             Expanded(
                        //               child: Center(
                        //                 child: Text(
                        //                   'Baby step',
                        //                   textAlign: TextAlign.center,
                        //                 ),
                        //               ),
                        //             ),
                        //             Container(
                        //               padding: EdgeInsets.only(right: 20.0),
                        //               child: Image.asset(
                        //                 'assets/achievements/1.png',
                        //                 fit: BoxFit.cover,
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //       Container(
                        //         width: 500.0, // Set the width of the container
                        //         height: 40.0,// Set the height of the container
                        //         margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 3.0),
                        //         decoration: BoxDecoration(
                        //           color: Colors.white, // Set the background color of the container
                        //           borderRadius: BorderRadius.circular(15.0), // Set the border radius of the container
                        //           boxShadow: [
                        //             BoxShadow(
                        //               color: Colors.grey.withOpacity(0.5),
                        //               spreadRadius: 1.0,
                        //               blurRadius: 2.0,
                        //               offset: Offset(0, 3), // Adjust the shadow position as needed
                        //             ),
                        //           ],
                        //         ),
                        //         child: Row(
                        //           mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align the children at the start and end of the row
                        //           children: [
                        //             Padding(
                        //               padding: EdgeInsets.only(left: 20.0),
                        //               child: Text(
                        //                 "${glassAmount >= 10 ? '10' : glassAmount}/10",
                        //                 textAlign: TextAlign.left,
                        //               ),
                        //             ),
                        //             Expanded(
                        //               child: Center(
                        //                 child: Text(
                        //                   'Getting Started',
                        //                   textAlign: TextAlign.center,
                        //                 ),
                        //               ),
                        //             ),
                        //             Container(
                        //               padding: EdgeInsets.only(right: 20.0),
                        //               child: Image.asset(
                        //                 'assets/achievements/2.png',
                        //                 fit: BoxFit.cover,
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //       Container(
                        //         width: 500.0, // Set the width of the container
                        //         height: 40.0,// Set the height of the container
                        //         margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 3.0),
                        //         decoration: BoxDecoration(
                        //           color: Colors.white, // Set the background color of the container
                        //           borderRadius: BorderRadius.circular(15.0), // Set the border radius of the container
                        //           boxShadow: [
                        //             BoxShadow(
                        //               color: Colors.grey.withOpacity(0.5),
                        //               spreadRadius: 1.0,
                        //               blurRadius: 2.0,
                        //               offset: Offset(0, 3), // Adjust the shadow position as needed
                        //             ),
                        //           ],
                        //         ),
                        //         child: Row(
                        //           mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align the children at the start and end of the row
                        //           children: [
                        //             Padding(
                        //               padding: EdgeInsets.only(left: 20.0),
                        //               child: Text(
                        //                 "${glassAmount >= 100 ? '100' : glassAmount}/100",
                        //                 textAlign: TextAlign.left,
                        //               ),
                        //             ),
                        //             Expanded(
                        //               child: Center(
                        //                 child: Text(
                        //                   'Eco-Warrior',
                        //                   textAlign: TextAlign.center,
                        //                 ),
                        //               ),
                        //             ),
                        //             Container(
                        //               padding: EdgeInsets.only(right: 20.0),
                        //               child: Image.asset(
                        //                 'assets/achievements/3.png',
                        //                 fit: BoxFit.cover,
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // Container(
                        //   padding: EdgeInsets.all(16.0), // Set the padding within the container
                        //   margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0), // Set the margin around the container
                        //   decoration: BoxDecoration(
                        //     color: Colors.green, // Set the background color of the container
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
                        //   child: Column(
                        //     children: [
                        //       Container(
                        //         margin: EdgeInsets.only(bottom: 10.0),
                        //         child: Text(
                        //           "Bin",
                        //           textAlign: TextAlign.left, // This is for text alignment.
                        //           style: TextStyle(
                        //             fontSize: 20.0,     // Change the font size.// Change the font family.
                        //             fontWeight: FontWeight.bold,  // Change the font weight.
                        //           ),
                        //         ),
                        //       ),
                        //       Container(
                        //         width: 500.0, // Set the width of the container
                        //         height: 40.0,// Set the height of the container
                        //         margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 3.0),
                        //         decoration: BoxDecoration(
                        //           color: Colors.white, // Set the background color of the container
                        //           borderRadius: BorderRadius.circular(15.0), // Set the border radius of the container
                        //           boxShadow: [
                        //             BoxShadow(
                        //               color: Colors.grey.withOpacity(0.5),
                        //               spreadRadius: 1.0,
                        //               blurRadius: 2.0,
                        //               offset: Offset(0, 3), // Adjust the shadow position as needed
                        //             ),
                        //           ],
                        //         ),
                        //         child: Row(
                        //           mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align the children at the start and end of the row
                        //           children: [
                        //             Padding(
                        //               padding: EdgeInsets.only(left: 20.0),
                        //               child: Text(
                        //                 "${binAmount >= 1 ? '1' : binAmount}/1",
                        //                 textAlign: TextAlign.left,
                        //               ),
                        //             ),
                        //             Expanded(
                        //               child: Center(
                        //                 child: Text(
                        //                   'Curious',
                        //                   textAlign: TextAlign.center,
                        //                 ),
                        //               ),
                        //             ),
                        //             Container(
                        //               padding: EdgeInsets.only(right: 20.0),
                        //               child: Image.asset(
                        //                 'assets/achievements/4.png',
                        //                 fit: BoxFit.cover,
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //       Container(
                        //         width: 500.0, // Set the width of the container
                        //         height: 40.0,// Set the height of the container
                        //         margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 3.0),
                        //         decoration: BoxDecoration(
                        //           color: Colors.white, // Set the background color of the container
                        //           borderRadius: BorderRadius.circular(15.0), // Set the border radius of the container
                        //           boxShadow: [
                        //             BoxShadow(
                        //               color: Colors.grey.withOpacity(0.5),
                        //               spreadRadius: 1.0,
                        //               blurRadius: 2.0,
                        //               offset: Offset(0, 3), // Adjust the shadow position as needed
                        //             ),
                        //           ],
                        //         ),
                        //         child: Row(
                        //           mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align the children at the start and end of the row
                        //           children: [
                        //             Padding(
                        //               padding: EdgeInsets.only(left: 20.0),
                        //               child: Text(
                        //                 "${binAmount >= 10 ? '10' : binAmount}/10",
                        //                 textAlign: TextAlign.left,
                        //               ),
                        //             ),
                        //             Expanded(
                        //               child: Center(
                        //                 child: Text(
                        //                   'Lucky',
                        //                   textAlign: TextAlign.center,
                        //                 ),
                        //               ),
                        //             ),
                        //             Container(
                        //               padding: EdgeInsets.only(right: 20.0),
                        //               child: Image.asset(
                        //                 'assets/achievements/5.png',
                        //                 fit: BoxFit.cover,
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //       Container(
                        //         width: 500.0, // Set the width of the container
                        //         height: 40.0,// Set the height of the container
                        //         margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 3.0),
                        //         decoration: BoxDecoration(
                        //           color: Colors.white, // Set the background color of the container
                        //           borderRadius: BorderRadius.circular(15.0), // Set the border radius of the container
                        //           boxShadow: [
                        //             BoxShadow(
                        //               color: Colors.grey.withOpacity(0.5),
                        //               spreadRadius: 1.0,
                        //               blurRadius: 2.0,
                        //               offset: Offset(0, 3), // Adjust the shadow position as needed
                        //             ),
                        //           ],
                        //         ),
                        //         child: Row(
                        //           mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align the children at the start and end of the row
                        //           children: [
                        //             Padding(
                        //               padding: EdgeInsets.only(left: 20.0),
                        //               child: Text(
                        //                 "${binAmount >= 100 ? '100' : binAmount}/100",
                        //                 textAlign: TextAlign.left,
                        //               ),
                        //             ),
                        //             Expanded(
                        //               child: Center(
                        //                 child: Text(
                        //                   'Explorer',
                        //                   textAlign: TextAlign.center,
                        //                 ),
                        //               ),
                        //             ),
                        //             Container(
                        //               padding: EdgeInsets.only(right: 20.0),
                        //               child: Image.asset(
                        //                 'assets/achievements/6.png',
                        //                 fit: BoxFit.cover,
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // Container(
                        //   padding: EdgeInsets.all(16.0), // Set the padding within the container
                        //   margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0), // Set the margin around the container
                        //   decoration: BoxDecoration(
                        //     color: Colors.green, // Set the background color of the container
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
                        //   child: Column(
                        //     children: [
                        //       Container(
                        //         width: 500.0, // Set the width of the container
                        //         height: 40.0,// Set the height of the container
                        //         margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 3.0),
                        //         decoration: BoxDecoration(
                        //           color: Colors.white, // Set the background color of the container
                        //           borderRadius: BorderRadius.circular(15.0), // Set the border radius of the container
                        //           boxShadow: [
                        //             BoxShadow(
                        //               color: Colors.grey.withOpacity(0.5),
                        //               spreadRadius: 1.0,
                        //               blurRadius: 2.0,
                        //               offset: Offset(0, 3), // Adjust the shadow position as needed
                        //             ),
                        //           ],
                        //         ),
                        //         child: Row(
                        //           mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align the children at the start and end of the row
                        //           children: [
                        //             Padding(
                        //               padding: EdgeInsets.only(left: 20.0),
                        //               child: Text(
                        //                 "${usageAmount >= 1 ? '1' : usageAmount}/1",
                        //                 textAlign: TextAlign.left,
                        //               ),
                        //             ),
                        //             Expanded(
                        //               child: Center(
                        //                 child: Text(
                        //                   'Day 01',
                        //                   textAlign: TextAlign.center,
                        //                 ),
                        //               ),
                        //             ),
                        //             Container(
                        //               padding: EdgeInsets.only(right: 20.0),
                        //               child: Image.asset(
                        //                 'assets/achievements/7.png',
                        //                 fit: BoxFit.cover,
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //       Container(
                        //         width: 500.0, // Set the width of the container
                        //         height: 40.0,// Set the height of the container
                        //         margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 3.0),
                        //         decoration: BoxDecoration(
                        //           color: Colors.white, // Set the background color of the container
                        //           borderRadius: BorderRadius.circular(15.0), // Set the border radius of the container
                        //           boxShadow: [
                        //             BoxShadow(
                        //               color: Colors.grey.withOpacity(0.5),
                        //               spreadRadius: 1.0,
                        //               blurRadius: 2.0,
                        //               offset: Offset(0, 3), // Adjust the shadow position as needed
                        //             ),
                        //           ],
                        //         ),
                        //         child: Row(
                        //           mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align the children at the start and end of the row
                        //           children: [
                        //             Padding(
                        //               padding: EdgeInsets.only(left: 20.0),
                        //               child: Text(
                        //                 "${usageAmount >= 10 ? '10' : usageAmount}/10",
                        //                 textAlign: TextAlign.left,
                        //               ),
                        //             ),
                        //             Expanded(
                        //               child: Center(
                        //                 child: Text(
                        //                   'Behaviour',
                        //                   textAlign: TextAlign.center,
                        //                 ),
                        //               ),
                        //             ),
                        //             Container(
                        //               padding: EdgeInsets.only(right: 20.0),
                        //               child: Image.asset(
                        //                 'assets/achievements/8.png',
                        //                 fit: BoxFit.cover,
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //       Container(
                        //         width: 500.0, // Set the width of the container
                        //         height: 40.0,// Set the height of the container
                        //         margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 3.0),
                        //         decoration: BoxDecoration(
                        //           color: Colors.white, // Set the background color of the container
                        //           borderRadius: BorderRadius.circular(15.0), // Set the border radius of the container
                        //           boxShadow: [
                        //             BoxShadow(
                        //               color: Colors.grey.withOpacity(0.5),
                        //               spreadRadius: 1.0,
                        //               blurRadius: 2.0,
                        //               offset: Offset(0, 3), // Adjust the shadow position as needed
                        //             ),
                        //           ],
                        //         ),
                        //         child: Row(
                        //           mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align the children at the start and end of the row
                        //           children: [
                        //             Padding(
                        //               padding: EdgeInsets.only(left: 20.0),
                        //               child: Text(
                        //                 "${usageAmount >= 100 ? '100' : usageAmount}/100",
                        //                 textAlign: TextAlign.left,
                        //               ),
                        //             ),
                        //             Expanded(
                        //               child: Center(
                        //                 child: Text(
                        //                   'Habit',
                        //                   textAlign: TextAlign.center,
                        //                 ),
                        //               ),
                        //             ),
                        //             Container(
                        //               padding: EdgeInsets.only(right: 20.0),
                        //               child: Image.asset(
                        //                 'assets/achievements/9.png',
                        //                 fit: BoxFit.cover,
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // Container(
                        //   padding: EdgeInsets.all(16.0), // Set the padding within the container
                        //   margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0), // Set the margin around the container
                        //   decoration: BoxDecoration(
                        //     color: Colors.green, // Set the background color of the container
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
                        //   child: Column(
                        //     children: [
                        //       Container(
                        //         width: 500.0, // Set the width of the container
                        //         height: 40.0,// Set the height of the container
                        //         margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 3.0),
                        //         decoration: BoxDecoration(
                        //           color: Colors.white, // Set the background color of the container
                        //           borderRadius: BorderRadius.circular(15.0), // Set the border radius of the container
                        //           boxShadow: [
                        //             BoxShadow(
                        //               color: Colors.grey.withOpacity(0.5),
                        //               spreadRadius: 1.0,
                        //               blurRadius: 2.0,
                        //               offset: Offset(0, 3), // Adjust the shadow position as needed
                        //             ),
                        //           ],
                        //         ),
                        //         child: Row(
                        //           mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align the children at the start and end of the row
                        //           children: [
                        //             Padding(
                        //               padding: EdgeInsets.only(left: 20.0),
                        //               child: Text(
                        //                 "${MediaAmount >= 1 ? '1' : MediaAmount}/1",
                        //                 textAlign: TextAlign.left,
                        //               ),
                        //             ),
                        //             Expanded(
                        //               child: Center(
                        //                 child: Text(
                        //                   'Do You Know',
                        //                   textAlign: TextAlign.center,
                        //                 ),
                        //               ),
                        //             ),
                        //             Container(
                        //               padding: EdgeInsets.only(right: 20.0),
                        //               child: Image.asset(
                        //                 'assets/achievements/13.png',
                        //                 fit: BoxFit.cover,
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //       Container(
                        //         width: 500.0, // Set the width of the container
                        //         height: 40.0,// Set the height of the container
                        //         margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 3.0),
                        //         decoration: BoxDecoration(
                        //           color: Colors.white, // Set the background color of the container
                        //           borderRadius: BorderRadius.circular(15.0), // Set the border radius of the container
                        //           boxShadow: [
                        //             BoxShadow(
                        //               color: Colors.grey.withOpacity(0.5),
                        //               spreadRadius: 1.0,
                        //               blurRadius: 2.0,
                        //               offset: Offset(0, 3), // Adjust the shadow position as needed
                        //             ),
                        //           ],
                        //         ),
                        //         child: Row(
                        //           mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align the children at the start and end of the row
                        //           children: [
                        //             Padding(
                        //               padding: EdgeInsets.only(left: 20.0),
                        //               child: Text(
                        //                 "${MediaAmount >= 10 ? '10' : MediaAmount}/10",
                        //                 textAlign: TextAlign.left,
                        //               ),
                        //             ),
                        //             Expanded(
                        //               child: Center(
                        //                 child: Text(
                        //                   'Influencer',
                        //                   textAlign: TextAlign.center,
                        //                 ),
                        //               ),
                        //             ),
                        //             Container(
                        //               padding: EdgeInsets.only(right: 20.0),
                        //               child: Image.asset(
                        //                 'assets/achievements/14.png',
                        //                 fit: BoxFit.cover,
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //       Container(
                        //         width: 500.0, // Set the width of the container
                        //         height: 40.0,// Set the height of the container
                        //         margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 3.0),
                        //         decoration: BoxDecoration(
                        //           color: Colors.white, // Set the background color of the container
                        //           borderRadius: BorderRadius.circular(15.0), // Set the border radius of the container
                        //           boxShadow: [
                        //             BoxShadow(
                        //               color: Colors.grey.withOpacity(0.5),
                        //               spreadRadius: 1.0,
                        //               blurRadius: 2.0,
                        //               offset: Offset(0, 3), // Adjust the shadow position as needed
                        //             ),
                        //           ],
                        //         ),
                        //         child: Row(
                        //           mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align the children at the start and end of the row
                        //           children: [
                        //             Padding(
                        //               padding: EdgeInsets.only(left: 20.0),
                        //               child: Text(
                        //                 "${MediaAmount >= 100 ? '100' : MediaAmount}/100",
                        //                 textAlign: TextAlign.left,
                        //               ),
                        //             ),
                        //             Expanded(
                        //               child: Center(
                        //                 child: Text(
                        //                   'Social Media Star',
                        //                   textAlign: TextAlign.center,
                        //                 ),
                        //               ),
                        //             ),
                        //             Container(
                        //               padding: EdgeInsets.only(right: 20.0),
                        //               child: Image.asset(
                        //                 'assets/achievements/15.png',
                        //                 fit: BoxFit.cover,
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // Container(
                        //   padding: EdgeInsets.all(16.0), // Set the padding within the container
                        //   margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0), // Set the margin around the container
                        //   decoration: BoxDecoration(
                        //     color: Colors.green, // Set the background color of the container
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
                        //   child: Column(
                        //     children: [
                        //       Container(
                        //         width: 500.0, // Set the width of the container
                        //         height: 40.0,// Set the height of the container
                        //         margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 3.0),
                        //         decoration: BoxDecoration(
                        //           color: Colors.white, // Set the background color of the container
                        //           borderRadius: BorderRadius.circular(15.0), // Set the border radius of the container
                        //           boxShadow: [
                        //             BoxShadow(
                        //               color: Colors.grey.withOpacity(0.5),
                        //               spreadRadius: 1.0,
                        //               blurRadius: 2.0,
                        //               offset: Offset(0, 3), // Adjust the shadow position as needed
                        //             ),
                        //           ],
                        //         ),
                        //         child: Row(
                        //           mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align the children at the start and end of the row
                        //           children: [
                        //             Padding(
                        //               padding: EdgeInsets.only(left: 20.0),
                        //               child: Text(
                        //                 "${socialAmount >= 1 ? '1' : socialAmount}/1",
                        //                 textAlign: TextAlign.left,
                        //               ),
                        //             ),
                        //             Expanded(
                        //               child: Center(
                        //                 child: Text(
                        //                   'Friend',
                        //                   textAlign: TextAlign.center,
                        //                 ),
                        //               ),
                        //             ),
                        //             Container(
                        //               padding: EdgeInsets.only(right: 20.0),
                        //               child: Image.asset(
                        //                 'assets/achievements/16.png',
                        //                 fit: BoxFit.cover,
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //       Container(
                        //         width: 500.0, // Set the width of the container
                        //         height: 40.0,// Set the height of the container
                        //         margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 3.0),
                        //         decoration: BoxDecoration(
                        //           color: Colors.white, // Set the background color of the container
                        //           borderRadius: BorderRadius.circular(15.0), // Set the border radius of the container
                        //           boxShadow: [
                        //             BoxShadow(
                        //               color: Colors.grey.withOpacity(0.5),
                        //               spreadRadius: 1.0,
                        //               blurRadius: 2.0,
                        //               offset: Offset(0, 3), // Adjust the shadow position as needed
                        //             ),
                        //           ],
                        //         ),
                        //         child: Row(
                        //           mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align the children at the start and end of the row
                        //           children: [
                        //             Padding(
                        //               padding: EdgeInsets.only(left: 20.0),
                        //               child: Text(
                        //                 "${socialAmount >= 10 ? '10' : socialAmount}/10",
                        //                 textAlign: TextAlign.left,
                        //               ),
                        //             ),
                        //             Expanded(
                        //               child: Center(
                        //                 child: Text(
                        //                   'Best Friend',
                        //                   textAlign: TextAlign.center,
                        //                 ),
                        //               ),
                        //             ),
                        //             Container(
                        //               padding: EdgeInsets.only(right: 20.0),
                        //               child: Image.asset(
                        //                 'assets/achievements/17.png',
                        //                 fit: BoxFit.cover,
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //       Container(
                        //         width: 500.0, // Set the width of the container
                        //         height: 40.0,// Set the height of the container
                        //         margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 3.0),
                        //         decoration: BoxDecoration(
                        //           color: Colors.white, // Set the background color of the container
                        //           borderRadius: BorderRadius.circular(15.0), // Set the border radius of the container
                        //           boxShadow: [
                        //             BoxShadow(
                        //               color: Colors.grey.withOpacity(0.5),
                        //               spreadRadius: 1.0,
                        //               blurRadius: 2.0,
                        //               offset: Offset(0, 3), // Adjust the shadow position as needed
                        //             ),
                        //           ],
                        //         ),
                        //         child: Row(
                        //           mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align the children at the start and end of the row
                        //           children: [
                        //             Padding(
                        //               padding: EdgeInsets.only(left: 20.0),
                        //               child: Text(
                        //                 "${socialAmount >= 100 ? '100' : socialAmount}/100",
                        //                 textAlign: TextAlign.left,
                        //               ),
                        //             ),
                        //             Expanded(
                        //               child: Center(
                        //                 child: Text(
                        //                   'Friend in Need',
                        //                   textAlign: TextAlign.center,
                        //                 ),
                        //               ),
                        //             ),
                        //             Container(
                        //               padding: EdgeInsets.only(right: 20.0),
                        //               child: Image.asset(
                        //                 'assets/achievements/18.png',
                        //                 fit: BoxFit.cover,
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
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
