import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {

  final User currentUser = FirebaseAuth.instance.currentUser!;

  final fnameController = TextEditingController();
  final locationController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final roleController = TextEditingController();
  final passwordController = TextEditingController();

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
          'Profile',
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
              // CircleAvatar(
              //   backgroundImage: AssetImage(""),
              //   radius: 50,
              // ),
              SizedBox(height: 50),
              Container(
                width: 300.0,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'First Name',
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
                  style: TextStyle(
                    color: Colors.black, // Set the desired text color
                    fontSize: 18.0, // Set the desired text size
                  ),
                  textAlign: TextAlign.center,
                  controller: fnameController,
                  enabled: false,
                ),
              ),
              SizedBox(height:20),
              Container(
                width: 300.0,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
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
                  style: TextStyle(
                    color: Colors.black, // Set the desired text color
                    fontSize: 18.0, // Set the desired text size
                  ),
                  textAlign: TextAlign.center,
                  controller: emailController,
                  enabled: false,
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 300.0,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Mobile',
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
                  style: TextStyle(
                    color: Colors.black, // Set the desired text color
                    fontSize: 18.0, // Set the desired text size
                  ),
                  textAlign: TextAlign.center,
                  controller: mobileController,
                  enabled: false,
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 300.0,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Location',
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
                  style: TextStyle(
                    color: Colors.black, // Set the desired text color
                    fontSize: 18.0, // Set the desired text size
                  ),
                  textAlign: TextAlign.center,
                  controller: locationController,
                  enabled: false,
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 300.0,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Password',
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
                  style: TextStyle(
                    color: Colors.black, // Set the desired text color
                    fontSize: 18.0, // Set the desired text size
                  ),
                  textAlign: TextAlign.center,
                  controller: passwordController,
                  enabled: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}