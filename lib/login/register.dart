import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:waste_management_app/login/login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    // You can add more password validation rules here
    return null;
  }

  String? _validateFname(String? value) {
    if (value == null || value.isEmpty) {
      return 'First Name is required';
    }
    return null;
  }

  String? _validateLocation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Location is required';
    }
    return null;
  }

  String? _validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mobile is required';
    }
    return null;
  }

  String? _validateRole(String? value) {
    if (value == null || value.isEmpty) {
      return 'Role is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {

    String selectedOption = '' ;

    final fnameController = TextEditingController();
    final locationController = TextEditingController();
    final emailController = TextEditingController();
    final mobileController = TextEditingController();
    final roleController = TextEditingController();
    final passwordController = TextEditingController();

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
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => login()), // Replace SecondPage with your desired destination page
                );
              },
            ),
          ),
          title: Text(
            'Sign Up',
            style: TextStyle(
              color: Colors.black,
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,

        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 50.0,
                      width: 300.0,
                      child: TextFormField(
                        decoration: InputDecoration(
                            labelText: 'First Name',
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
                        validator: _validateFname,
                        controller: fnameController,
                      )
                  )
                ],
              ),
              SizedBox(height: 20.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: 50.0,
                      width: 300.0,
                      child: TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Location',
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
                            border: OutlineInputBorder()),
                        validator: _validateLocation,
                        controller: locationController,
                      )
                  )
                ],
              ),
              SizedBox(height: 20.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: 50.0,
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
                            border: OutlineInputBorder()),
                        validator: _validateEmail,
                        controller: emailController,
                      )
                  )
                ],
              ),
              SizedBox(height: 20.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: 50.0,
                      width: 300.0,
                      child: TextFormField(
                        decoration:  InputDecoration(
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
                            border: OutlineInputBorder()),
                        validator: _validateMobile,
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
                      height: 60.0,
                      width: 300.0,
                      child: DropdownButtonFormField<String>(
                        decoration:  InputDecoration(
                            labelText: 'role',
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
                            border: OutlineInputBorder()
                        ),
                        validator: _validateRole,
                        onChanged: (value) {
                            selectedOption = value!;
                        },
                        items: [
                          DropdownMenuItem(
                            value: 'user',
                            child: Text('User'),
                          ),
                          DropdownMenuItem(
                            value: 'collector',
                            child: Text('Collector'),
                          ),
                        ],
                      ),
                  )
                ],
              ),
              SizedBox(height: 20.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: 50.0,
                      width: 300.0,
                      child: TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Password',
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
                            border: OutlineInputBorder()),
                        validator: _validatePassword,
                        controller: passwordController,
                      )
                  )
                ],
              ),
              SizedBox(height: 20.0,),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    //firebase auth data adding
                    FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                    );

                    roleController.text = selectedOption;
                    //firebase firestore data adding
                    Map<String, String> dataToSave = {
                      "fname": fnameController.text.trim(),
                      "lccation": locationController.text.trim(),
                      "email": emailController.text.trim(),
                      "mobile": mobileController.text.trim(),
                      "role": roleController.text.trim(),
                      "password": passwordController.text.trim(),
                    };

                    FirebaseFirestore.instance.collection('users').add(
                        dataToSave).then((documentSnapshot) =>
                        print("Added User with ID: ${documentSnapshot.id}"));
                    FirebaseAuth.instance.signOut();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                          login()), // Replace SecondPage with your desired destination page
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(100.0, 40.0),
                  primary: Colors.green[700], // Set the desired button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0), // Set the desired border radius
                  ),
                ),
                child: Text('Sign up'),
              ),
            ],
          ),
        ),
    );
  }
}
