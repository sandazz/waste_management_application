

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword>  {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String currentUser = '';

  final mobileController = TextEditingController();
  final emailController = TextEditingController();

  String? _validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mobile is required';
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
  }

  Future<void> resetPassword() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser)
        .update({'password': 'Qwerty@123'});
  }

  Future<void> handleSubmit(TextEditingController emailController, TextEditingController mobileController) async {
    if (_formKey.currentState!.validate()) {
      // Query Firestore for documents in the 'users' collection where 'email' equals the email provided by the user
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: emailController.text.trim())
          .where('mobile', isEqualTo: mobileController.text.trim()) // Please note that storing passwords in plaintext is a bad practice
          .get();

      if (querySnapshot.docs.isEmpty) {
        // If the query results in no documents, then there is no user with the given email and password
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No user found with given credentials.')),
        );
      } else {
        // If the query results in one or more documents, then there is a user with the given email and password
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User found with given credentials.')),
        );

        currentUser = querySnapshot.docs.first.id; // assuming there is only one matching document
        print("Current user ID is: $currentUser");
      }


      // Clear store values
      emailController.clear();
      mobileController.clear();
    }
  }

  Future<void> addContactDetails() async{
    emailController.text = 'sandazzzg1999@gmail.com';
    mobileController.text = '0768511134';
  }

  @override
  void initState(){
    super.initState();
    addContactDetails();
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
          'Forget Password',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
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
                          labelText: 'Email',
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
                        validator: _validateEmail,
                        controller: emailController,
                        enabled: false,
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
                        controller: mobileController,
                        enabled: false,
                      )
                  )
                ],
              ),
              SizedBox(height: 20.0,),
              ElevatedButton(
                onPressed: null,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(100.0, 40.0),
                  primary: Colors.green[700], // Set the desired button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0), // Set the desired border radius
                  ),
                ),
                child: Text('Contact Admin'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
