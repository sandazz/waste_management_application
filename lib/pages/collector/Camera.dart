import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Camera extends StatefulWidget {
  const Camera({super.key});

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> with WidgetsBindingObserver {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final mobileController = TextEditingController();
  final plasticAmountController = TextEditingController();
  final caneAmountController = TextEditingController();
  final glassAmountController = TextEditingController();

  final User currentUser = FirebaseAuth.instance.currentUser!;

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
                      controller: plasticAmountController,
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
                        labelText: 'Cane Amount',
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
                      controller: caneAmountController,
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
                        labelText: 'Glass Amount',
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
                      controller: glassAmountController,
                    )
                )
              ],
            ),
            SizedBox(height: 20.0,),
            ElevatedButton(
              onPressed: () {
                String mobile = mobileController.text.trim();
                String plasticAmount = plasticAmountController.text.trim();
                String caneAmount = caneAmountController.text.trim();
                String glassAmount = glassAmountController.text.trim();
                String binAmount = "0";
                double points = (double.parse(plasticAmount)+double.parse(caneAmount)+double.parse(glassAmount))*0.05;
                double spinnablePoints = points;


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

                    // Update "dataToSave" map with
                    Map<String, String> dataToSave = {
                      "mobile": mobile,
                      "plasticAmount": plasticAmount,
                      "caneAmount": caneAmount,
                      "glassAmount": glassAmount,
                      "points" : points.toString(),
                      "spinnablePoints" : spinnablePoints.toString(),
                      "binAmount" : binAmount, //bin in not initailzed up to now
                    };

                    //  Check if a record with the same mobile number exists
                    FirebaseFirestore.instance
                        .collection('recycledWasteEndUser')
                        .where('mobile', isEqualTo: mobile)
                        .get()
                        .then((querySnapshot) {
                      if (querySnapshot.docs.isNotEmpty) {
                        // Retrieve the existing record document
                        var existingDoc = querySnapshot.docs.first;
                        String existingDocId = existingDoc.id;

                        //plastic amount increase
                        int existingPlasticAmount = int.parse(existingDoc.data()['plasticAmount']);
                        int newPlasticAmount = int.parse(plasticAmount);
                        int updatedPlasticAmount = existingPlasticAmount + newPlasticAmount;

                        //cane amount increase
                        int existingCaneAmount = int.parse(existingDoc.data()['caneAmount']);
                        int newCaneAmount = int.parse(caneAmount);
                        int updatedCaneAmount = existingCaneAmount + newCaneAmount;

                        //glass amount increase
                        int existingGlassAmount = int.parse(existingDoc.data()['glassAmount']);
                        int newGlassAmount = int.parse(glassAmount);
                        int updatedGlassAmount = existingGlassAmount + newGlassAmount;

                        double existingPoints = double.parse(existingDoc.data()['points']);
                        double newPoints = points;
                        double updatedPoints = existingPoints + newPoints;

                        double existingSpinnablePoints = double.parse(existingDoc.data()['spinnablePoints']);
                        double newSpinnablePoints = spinnablePoints;
                        double updatedspinnablePoints = existingSpinnablePoints + newSpinnablePoints;

                        // Update the existing record with the new amount value
                        FirebaseFirestore.instance
                            .collection('recycledWasteEndUser')
                            .doc(existingDocId)
                            .update({'plasticAmount': updatedPlasticAmount.toString(), 'caneAmount': updatedCaneAmount.toString(),'glassAmount': updatedGlassAmount.toString(),'points': updatedPoints.toString(),'spinnablePoints': updatedspinnablePoints.toString()})
                            .then((_) {
                          print("Updated existing record with ID: $existingDocId");
                        });
                      } else {
                        // Add a new record since no existing record found
                        FirebaseFirestore.instance.collection('recycledWasteEndUser').doc(userId).set(dataToSave);
                      }
                    });

                    Map<String, String> collectorPoints = {
                      "plasticAmount": plasticAmount,
                    };

                    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
                        .collection("recycledWasteCollector")
                        .doc(currentUser.uid)
                        .get();

                    if (documentSnapshot.exists) {
                      Map<String, dynamic> userData = documentSnapshot.data() as Map<String, dynamic>;
                      setState(() {
                        int point = int.parse(userData['plasticAmount']);
                        int updateAmount = point +int.parse(plasticAmount) ;
                        Map<String, String> collectorPoints = {
                          "plasticAmount": plasticAmount,
                        };
                        FirebaseFirestore.instance
                                .collection('recycledWasteCollector')
                                .doc(currentUser.uid)
                                .update({'plasticAmount': updateAmount.toString()})
                                .then((_) {
                                  print("Updated existing record with ID: $currentUser.uid");
                                  }
                                );
                        });
                    } else {
                      FirebaseFirestore.instance.collection('recycledWasteCollector').doc(currentUser.uid).set(collectorPoints);
                    }
                  }
                });

                // Clear text form fields and reset data
                mobileController.clear();
                plasticAmountController.clear();
                caneAmountController.clear();
                glassAmountController.clear();

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
