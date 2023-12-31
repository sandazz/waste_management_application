import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:waste_management_app/components/snackbar.dart';
import 'package:waste_management_app/pages/collector/Collector.dart';
import 'package:waste_management_app/pages/collector/Home.dart';

class Camera extends StatefulWidget {
  const Camera({super.key});

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> with WidgetsBindingObserver {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final mobileController = TextEditingController();
  final plasticAmountController = TextEditingController();
  final bottleAmountController = TextEditingController();
  final caneAmountController = TextEditingController();
  final glassAmountController = TextEditingController();

  int rewardPoints = 0;

  final User currentUser = FirebaseAuth.instance.currentUser!;

  String? _validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mobile is required';
    }

    // Check for non-numeric characters
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Mobile number can only contain digits';
    }

    // Check for the correct number of digits for a mobile number
    // (Assuming a mobile number should have 10 digits - modify this as necessary)
    if (value.length != 10) {
      return 'Mobile number must contain exactly 10 digits';
    }

    // Check for specific starting digits
    // (Assuming a mobile number should start with '07' - modify this as necessary)
    if (!value.startsWith('07')) {
      return 'Mobile number must start with 07';
    }

    return null;
  }

  String? _validateAmount(String? value) {
    if (value != null && value.isNotEmpty) {
      if (int.tryParse(value) == null) {
        return 'Please enter an integer value';
      }
    }
    return null;
  }
  
  Future<void> getRewarPoints() async{
    String uid = currentUser.uid;
    
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection("recycledWasteCollector").doc(uid).get();

    if (documentSnapshot.exists){
      Map<String, dynamic> userData = documentSnapshot.data() as Map<String, dynamic>;
      setState(() {
        rewardPoints = userData['rewardPoints'];
      });
    } else {
      print(" User not found");
    }
  }

  Future<void> pointsAdd() async{
    if (_formKey.currentState!.validate()) {
      String mobile = mobileController.text.trim();
      int plasticAmount = (plasticAmountController.text.isNotEmpty && int.tryParse(plasticAmountController.text) != null)
          ? int.parse(plasticAmountController.text)
          : 0;
      int bottleAmount = (bottleAmountController.text.isNotEmpty && int.tryParse(bottleAmountController.text) != null)
          ? int.parse(bottleAmountController.text)
          : 0;
      int binAmount = 0;
      int points = (plasticAmount*30)+(bottleAmount*5);
      int spinnablePoints = points;

      if (rewardPoints >= plasticAmount + bottleAmount){
        // Retrieve user ID from "users" collection
        FirebaseFirestore.instance
            .collection('users')
            .where('mobile', isEqualTo: mobile)
            .get()
            .then((querySnapshot) async {
          if (querySnapshot.docs.isNotEmpty) {
            // Retrieve user document
            var userDoc = querySnapshot.docs.first;

            // Extract user ID
            String userId = userDoc.id;
            binAmount = ((plasticAmount + bottleAmount)*(1/10000)).floor();
            print("Bin amount :  $binAmount");


            // Update "dataToSave" map with
            Map<String, dynamic> dataToSave = {
              "mobile": mobile,
              "bottleAmount": bottleAmount,
              "plasticAmount": plasticAmount,
              "points" : points,
              "spinnablePoints" : spinnablePoints,
              "binAmount" : binAmount,
            };

            //  Check if a record with the same mobile number exists
            FirebaseFirestore.instance
                .collection('recycledWasteEndUser')
                .where('mobile', isEqualTo: mobile)
                .get()
                .then((querySnapshot) async {
              if (querySnapshot.docs.isNotEmpty) {
                // Retrieve the existing record document
                var existingDoc = querySnapshot.docs.first;
                String existingDocId = existingDoc.id;

                //plastic amount increase
                int existingPlasticAmount = existingDoc.data()['plasticAmount'];
                int newPlasticAmount = plasticAmount;
                int updatedPlasticAmount = existingPlasticAmount + newPlasticAmount;

                //bottle amount increase
                int existingBottleAmount = existingDoc.data()['bottleAmount'];
                int newBottleAmount = bottleAmount;
                int updatedBottleAmount = existingBottleAmount + newBottleAmount;

                //update point
                int existingPoints = existingDoc.data()['points'];
                int newPoints = points;
                int updatedPoints = existingPoints + newPoints;

                //update spinnablepoints
                int existingSpinnablePoints = existingDoc.data()['spinnablePoints'];
                int newSpinnablePoints = spinnablePoints;
                int updatedspinnablePoints = existingSpinnablePoints + newSpinnablePoints;

                // Update the existing record with the new amount value
                try {
                  await FirebaseFirestore.instance
                      .collection('recycledWasteEndUser')
                      .doc(existingDocId)
                      .update({
                    'plasticAmount': updatedPlasticAmount,
                    'bottleAmount': updatedBottleAmount,
                    'points': updatedPoints,
                    'spinnablePoints': updatedspinnablePoints,
                  });

                  // Update successful, handle the result here
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('User Data updated successfully...'),
                      backgroundColor: Colors.green,
                    ),
                  );
                } catch (e) {
                  // Handle any errors that occur during the update
                  print('An error occurred while updating data in Firestore: $e');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('An error occurred while updating data. Please try again.'),
                      backgroundColor: Colors.red,),
                  );
                }
              } else {
                // Add a new record since no existing record found
                try {
                  await FirebaseFirestore.instance
                      .collection('recycledWasteEndUser')
                      .doc(userId)
                      .set(dataToSave);

                  // Set operation successful, show success message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('User Data saved successfully...'),
                      backgroundColor: Colors.green,),
                  );
                } catch (e) {
                  // Handle any errors during the set operation
                  print('An error occurred while saving data to Firestore: $e');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('An error occurred while saving data. Please try again.'),
                      backgroundColor: Colors.red,),
                  );
                }
              }
            });

            Map<String, dynamic> collectorAmounts = {
              "plasticAmount": plasticAmount,
              "bottleAmount": bottleAmount,
              "rewardPoints": rewardPoints,
            };

            DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
                .collection("recycledWasteCollector")
                .doc(currentUser.uid)
                .get();

            if (documentSnapshot.exists) {
              Map<String, dynamic> userData = documentSnapshot.data() as Map<String, dynamic>;
              setState(()  {


                int existingPlasticAmountCollector = userData['plasticAmount'];
                int updatePlasticAmountCollector = existingPlasticAmountCollector + plasticAmount;

                int existingBottleAmountCollector = userData['bottleAmount'];
                int updateBottleAmountCollector = existingBottleAmountCollector + bottleAmount;

                int existingRewardPointsCollector = userData['rewardPoints'];
                int updateRewardPointsCollector = existingRewardPointsCollector - (plasticAmount+bottleAmount);

                try {
                  FirebaseFirestore.instance
                      .collection('recycledWasteCollector')
                      .doc(currentUser.uid)
                      .update({
                    'plasticAmount': updatePlasticAmountCollector,
                    'bottleAmount': updateBottleAmountCollector,
                    'rewardPoints':updateRewardPointsCollector,
                  });

                  // Update operation successful, show a success message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Collector Data updated successfully...'),
                      backgroundColor: Colors.green,),
                  );
                } catch (e) {
                  // Handle any errors during the update operation
                  print('An error occurred while updating data in Firestore: $e');

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('An error occurred while updating data. Please try again.'),
                      backgroundColor: Colors.red,),
                  );
                }
              });
            }else {
              try {
                await FirebaseFirestore.instance
                    .collection('recycledWasteCollector')
                    .doc(currentUser.uid)
                    .set(collectorAmounts);

                // Set operation successful, show success message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Collector Data saved successfully...'),
                    backgroundColor: Colors.green,),
                  );
                } catch (e) {
                  // Handle any errors during the set operation
                  print('An error occurred while saving data to Firestore: $e');

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('An error occurred while saving data. Please try again.'),
                      backgroundColor: Colors.red,),
                  );
                }
            }
          }
        });
      }else{
        CustomSnackBar.showError(context, 'Reward Point Amount insufficient!\nRecharge Your Points');
      }


      // Clear text form fields and reset data
      mobileController.clear();
      plasticAmountController.clear();
      bottleAmountController.clear();
      await Future.delayed(Duration(seconds: 2));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRewarPoints();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                'Recycle',
                style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0
                ),
              ),
            ),
            SizedBox(height: 10.0,),
            Container(
              width: 100.0, // Set the width of the container
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
                    offset: Offset(0, 1), // Adjust the shadow position as needed
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
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Icon(
                      LineIcons.star,
                      size: 35.0,
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      "${rewardPoints}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 300.0,
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Mobile',
                        labelStyle: TextStyle(
                          color: Colors.green[700], // Set the desired text color
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide:
                          BorderSide(color: Colors.green, width: 0.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide: BorderSide(color: Colors.green, width: 2.0), // Set the desired border color and width
                        ),
                        border: OutlineInputBorder(),
                      ),
                      validator: _validateMobile,
                      keyboardType: TextInputType.number,
                      controller: mobileController,
                    )
                )
              ],
            ),
            SizedBox(height: 20.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 300.0,
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Bottle Amount',
                        labelStyle: TextStyle(
                          color: Colors.green[700], // Set the desired text color
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide:
                          BorderSide(color: Colors.green, width: 0.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide: BorderSide(color: Colors.green, width: 2.0), // Set the desired border color and width
                        ),
                        border: OutlineInputBorder(),
                      ),
                      validator: _validateAmount,
                      keyboardType: TextInputType.number,
                      controller: bottleAmountController,
                    )
                )
              ],
            ),
            SizedBox(height: 20.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 300.0,
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Plastic Amount',
                        labelStyle: TextStyle(
                          color: Colors.green[700], // Set the desired text color
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide:
                          BorderSide(color: Colors.green, width: 0.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide: BorderSide(color: Colors.green, width: 2.0), // Set the desired border color and width
                        ),
                        border: OutlineInputBorder(),
                      ),
                      validator: _validateAmount,
                      keyboardType: TextInputType.number,
                      controller: plasticAmountController,
                    )
                )
              ],
            ),
            // SizedBox(height: 20.0,),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Container(
            //         width: 300.0,
            //         child: TextFormField(
            //           decoration: InputDecoration(
            //             labelText: 'Cane Amount',
            //             labelStyle: TextStyle(
            //               color: Colors.green[700], // Set the desired text color
            //             ),
            //             enabledBorder: OutlineInputBorder(
            //               borderRadius: BorderRadius.all(Radius.circular(20.0)),
            //               borderSide:
            //               BorderSide(color: Colors.green, width: 0.0),
            //             ),
            //             focusedBorder: OutlineInputBorder(
            //               borderRadius: BorderRadius.all(Radius.circular(20.0)),
            //               borderSide: BorderSide(color: Colors.green, width: 2.0), // Set the desired border color and width
            //             ),
            //             border: OutlineInputBorder(),
            //           ),
            //           validator: _validateAmount,
            //           controller: caneAmountController,
            //         )
            //     )
            //   ],
            // ),
            // SizedBox(height: 20.0,),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Container(
            //         width: 300.0,
            //         child: TextFormField(
            //           decoration: InputDecoration(
            //             labelText: 'Glass Amount',
            //             labelStyle: TextStyle(
            //               color: Colors.green[700], // Set the desired text color
            //             ),
            //             enabledBorder: OutlineInputBorder(
            //               borderRadius: BorderRadius.all(Radius.circular(20.0)),
            //               borderSide:
            //               BorderSide(color: Colors.green, width: 0.0),
            //             ),
            //             focusedBorder: OutlineInputBorder(
            //               borderRadius: BorderRadius.all(Radius.circular(20.0)),
            //               borderSide: BorderSide(color: Colors.green, width: 2.0), // Set the desired border color and width
            //             ),
            //             border: OutlineInputBorder(),
            //           ),
            //           validator: _validateAmount,
            //           controller: glassAmountController,
            //         )
            //     )
            //   ],
            // ),
            SizedBox(height: 20.0,),
            ElevatedButton(
              onPressed: () async {
                await pointsAdd();
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LayoutCollector()));

                },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(100.0, 40.0),
                primary: Colors.green[700], // Set the desired button color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0), // Set the desired border radius
                ),
              ),
              child: Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
