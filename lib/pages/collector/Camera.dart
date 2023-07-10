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
  final amountController = TextEditingController();

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
                      controller: amountController,
                    )
                )
              ],
            ),
            SizedBox(height: 20.0,),
            //other rows not developed funtions for the canes and the glass
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
            //           controller: amountController,
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
            //           controller: amountController,
            //         )
            //     )
            //   ],
            // ),
            // SizedBox(height: 20.0,),
            ElevatedButton(
              onPressed: () {
                String mobile = mobileController.text.trim();
                String amount = amountController.text.trim();

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
                      "plasticAmount": amount,
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
                        int existingAmount = int.parse(existingDoc.data()['plasticAmount']);
                        int newAmount = int.parse(amount);
                        int updatedAmount = existingAmount + newAmount;

                        // Update the existing record with the new amount value
                        FirebaseFirestore.instance
                            .collection('recycledWasteEndUser')
                            .doc(existingDocId)
                            .update({'plasticAmount': updatedAmount.toString()})
                            .then((_) {
                          print("Updated existing record with ID: $existingDocId");
                        });
                      } else {
                        // Add a new record since no existing record found
                        FirebaseFirestore.instance.collection('recycledWasteEndUser').doc(userId).set(dataToSave);
                      }
                    });

                    Map<String, String> collectorPoints = {
                      "plasticAmount": amount,
                    };

                    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
                        .collection("recycledWasteCollector")
                        .doc(currentUser.uid)
                        .get();

                    if (documentSnapshot.exists) {
                      Map<String, dynamic> userData = documentSnapshot.data() as Map<String, dynamic>;
                      setState(() {
                        int point = int.parse(userData['plasticAmount']);
                        int updateAmount = point +int.parse(amount) ;
                        Map<String, String> collectorPoints = {
                          "plasticAmount": amount,
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
                amountController.clear();
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
