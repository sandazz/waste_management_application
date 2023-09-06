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

  int rewardPoints = 0;

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
        rewardPoints = userData['rewardPoints'];
        print(rewardPoints);
      });
    } else {
      print("User not found");
    }

  }

  Future<void> updatePoints() async {
    String uid = currentUser.uid;
    FirebaseFirestore.instance.collection("recycledWasteEndUser").doc(uid).update(
        {"rewardPoints": rewardPoints});
  }

  String generateHash(String input) {
    final bytes = utf8.encode(input); // Convert the string to bytes
    var digest = sha512.convert(bytes); // Hash the bytes using SHA-256
    return digest.toString(); // Convert the hash bytes to a string and return
  }

  Future<void> sendPostRequest(String rewardAmount) async {
    String action = 'recharge';
    String format = 'JSON';
    String mid = 'OTk2NzAw';
    String provider = '';
    String number = mobileController.text;

    // check the provider code
    String firstThreeDigits = number.substring(0, 3);
    switch (firstThreeDigits) {
      case '076':
        print('Dialog');
        provider = 'PAT';
        break;
      case '074':
        print('Dialog');
        provider = 'PAT';
        break;
      case '077':
        print('Dialog');
        provider = 'PAT';
        break;
      case '072':
        print('Hutch');
        provider = 'HUT';
        break;
      case '078':
        print('Hutch');
        provider = 'HUT';
        break;
      case '071':
        print('Mobital');
        provider = 'PID';
        break;
      case '070':
        print('Mobital');
        provider = 'PID';
        break;
      default:
        print('Airtel');
        provider = 'AIR';
    }

    // Take number without '0'
    if (number.startsWith("0")) {
      number = number.substring(1);
    }

    String amount = rewardAmount;
    String refno = 'ref001';
    String rurl = 'https://www.example.com';
    String data = mid+'|'+number+'|'+provider+'|'+amount+'|'+refno+'|'+rurl+'|'+'e75e61651fb61c7f5844';
    String hash = generateHash(data);

    var parameters = {
      'action': action,
      'format': format,
      'mid': mid,
      'provider': provider,
      'number': number,
      'amount': amount,
      'refno': refno,
      'rurl': rurl,
      'hash': hash
    };

    var uri = Uri.http('secure.quickpay.lk', '/api/', parameters);

    // Make the HTTP GET request
    var response = await http.get(uri);

    // If the call to the server was successful, print the response body
    if (response.statusCode == 200) {

      // Parse the JSON string into a Dart Map
      Map<String, dynamic> parsedJson = jsonDecode(response.body);

      // Check the reload success with reasons code
      if (parsedJson['RechargeStatus']['reasoncode'] == '000'){
        // Reduce the points
        rewardPoints = rewardPoints - int.parse(rewardAmountController.text);

        // Update redused point
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
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error !'),
            backgroundColor: Colors.red, // Change color of SnackBar
            behavior: SnackBarBehavior.floating, // Make SnackBar floating
            shape: RoundedRectangleBorder( // Change shape of SnackBar
              borderRadius: BorderRadius.circular(24),
            ),
          ),
        );
      }
    } else {
      // If that call was not successful, throw an error.
      print('Failed to load data from the server');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to load data from the server'),
          backgroundColor: Colors.red, // Change color of SnackBar
          behavior: SnackBarBehavior.floating, // Make SnackBar floating
          shape: RoundedRectangleBorder( // Change shape of SnackBar
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      );
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

                          await sendPostRequest(rewardAmountController.text);
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
