import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RewardGiveAway extends StatefulWidget {
  const RewardGiveAway({super.key});

  @override
  State<RewardGiveAway> createState() => _RewardGiveAwayState();
}

class _RewardGiveAwayState extends State<RewardGiveAway> {

  final _formKey = GlobalKey<FormState>();
  final User currentUser = FirebaseAuth.instance.currentUser!;

  final fnameController = TextEditingController();
  final locationController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final roleController = TextEditingController();
  final passwordController = TextEditingController();
  final rewardAmountController = TextEditingController();

  double rewardPoints = 0.0;

  Future<void> getUserDetails() async{
    String uid = currentUser.uid;

    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .get();

    if (documentSnapshot.exists) {
      Map<String, dynamic> userDetails = documentSnapshot.data() as Map<String, dynamic>;
      setState(() {
        print(userDetails);
        fnameController.text = userDetails['fname'];
        emailController.text = userDetails['email'];
        mobileController.text = userDetails['mobile'];
        locationController.text = userDetails['lccation'];
        passwordController.text = userDetails['password'];

      });
    } else {
      print("User not found");
    }

    DocumentSnapshot gettingRewardPoints = await FirebaseFirestore.instance
        .collection("recycledWasteEndUser")
        .doc(uid)
        .get();

    if (gettingRewardPoints.exists) {
      Map<String, dynamic> userData = gettingRewardPoints.data() as Map<String, dynamic>;
      setState(() {
        rewardPoints = double.parse(userData['rewardPoints']);
        print(rewardPoints);
      });
    } else {
      print("User not found");
    }

  }

  Future<void> updatePoints() async {
    String uid = currentUser.uid;
    FirebaseFirestore.instance.collection("recycledWasteEndUser").doc(uid).update(
        {"rewardPoints": rewardPoints.toString()});
  }

  Future<void> hash() async {
    var data = "Hello, World!"; // data to be hashed

    var bytes = utf8.encode(data); // data being hashed

    var digest = sha512.convert(bytes); // Hashing Process

    print("Hashed Data: $digest");
  }

  Future<void> sendPostRequest() async {
    print('send post request');
    var uri = Uri.https('secure.quickpay.lk', '/api', {
      'action': 'recharge',
      'format': 'JSON',
      'mid': 'NDEwNDAw',
      'provider': 'PAT',
      'number': '768511134',
      'amount': '52',
      'refno': 'sa0111',
      'rurl': 'https://api.example.com/users/123',
      'hash': 'b21c633bac6cc578890a728a46d9884a01eae70eebc30521edd2b6ba53cd5e783b392a30a29611da7fe91c6af23f9c0d41366fa5f7681f19db2d8af7e480934a',
    });
    var response = await http.post(uri, body: {
      'action': 'recharge',
      'format': 'JSON',
      'mid': 'NDEwNDAw',
      'provider': 'PAT',
      'number': '768511134',
      'amount': '52',
      'refno': 'sa0111',
      'rurl': 'https://api.example.com/users/123',
      'hash': 'b21c633bac6cc578890a728a46d9884a01eae70eebc30521edd2b6ba53cd5e783b392a30a29611da7fe91c6af23f9c0d41366fa5f7681f19db2d8af7e480934a',
    });

    print(uri);
    print(response);

    if (response.statusCode == 200) {
      print('Success! Response: ${response.body}');
    } else {
      print('Failure! Status Code: ${response.statusCode}');
      print('Failure! Status Code: ${response.reasonPhrase}');

    }
  }

  String? _validateRewardAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some amount';
    }
    double? rewardAmount = double.tryParse(value);
    if (rewardAmount == null) {
      return 'Please enter a valid number';
    }
    if (rewardAmount < 50.0) {
      return 'Reward amount should be equal to or greater than 50';
    }
    if (rewardAmount > rewardPoints) {
      return 'Reward amount should not exceed available reward points';
    }
    return null;
  }


  @override
  void initState(){
    super.initState();
    getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: Padding(
          padding: EdgeInsets.all(5.0),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_outlined,
              color: Colors.black,
              size: 25.0,
            ),
            onPressed: () {// Handle leading icon press
              Navigator.of(context).pop();
            },
          ),
        ),
        title: Text(
          'Reward Give Away',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,

      ),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Container(
                width: 110.0, // Set the width of the container
                padding: EdgeInsets.all(16.0), // Set the padding within the container
                margin: EdgeInsets.all(8.0), // Set the margin around the container
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
                        'Reward Points',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Icon(
                        Icons.ad_units_outlined,
                        size: 30.0,
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        "$rewardPoints",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      width: 300.0,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Reward Amount',
                          labelStyle: TextStyle(
                            color: Colors.green[700],
                            fontSize: 16.0,// Set the desired text color
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
                        validator: _validateRewardAmount,  // Using the function here
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          color: Colors.black, // Set the desired text color
                          fontSize: 18.0, // Set the desired text size
                        ),
                        textAlign: TextAlign.center,
                        controller: rewardAmountController,
                      ),
                    ),
                    SizedBox(height:20),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          rewardPoints = rewardPoints - double.parse(rewardAmountController.text);
                           await updatePoints();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('You are REWARED with ${rewardAmountController.text} POINTS !'),
                              backgroundColor: Colors.green, // Change color of SnackBar
                              behavior: SnackBarBehavior.floating, // Make SnackBar floating
                              shape: RoundedRectangleBorder( // Change shape of SnackBar
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                          );
                          await sendPostRequest();
                          rewardAmountController.clear();
                          await getUserDetails();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(100.0, 40.0),
                        primary: Colors.green[700], // Set the desired button color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      child: Text('GIVE AWAY'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
