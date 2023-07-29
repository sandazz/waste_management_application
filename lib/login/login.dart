import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waste_management_app/components/snackbar.dart';
import 'package:waste_management_app/login/register.dart';
import 'package:waste_management_app/main.dart';
import 'package:waste_management_app/providers/loginProvider.dart';
import 'package:flutter/services.dart';



class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> with WidgetsBindingObserver {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  double containerPosition = 0.0;
  double translateY = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    setState(() {
      translateY = keyboardHeight > 0 ? -100.0 : 0.0;
    });
  }

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

  @override
  Widget build(BuildContext context) {

    final LoginDetails = Provider.of<LoginData>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.green[900],
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Hello.... \nWelcome Back",
              style: TextStyle(
                  fontSize: 39,
                  fontWeight: FontWeight.w700,
                  color: Colors.white
              ),
            ),
            Center(
              child: Container(
                  margin: EdgeInsets.only(top: containerPosition, bottom: 20),
                  width: MediaQuery.of(context).size.width - 50, // Set the width of the container
                  height: MediaQuery.of(context).size.height*0.34, // Set the height of the container
                  decoration: BoxDecoration(
                    color: Colors.white, // Set the background color of the container
                    borderRadius: BorderRadius.circular(15.0), // Set the border radius of the container
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54.withOpacity(0.5),
                        spreadRadius: 3.0,
                        blurRadius: 7.0,
                        offset: Offset(0, 0), // Adjust the shadow position as needed
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 70,
                          // height: 50.0,
                          margin: EdgeInsets.only(top: 20, bottom: 20),
                          child: TextFormField(
                            controller: emailController,
                            decoration: const InputDecoration(
                              contentPadding: const EdgeInsets.all(20.0),
                              labelText: 'Email',
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: Colors.grey, width: 0.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: Colors.green, width: 2.0), // Set the desired border color and width
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                                borderSide:
                                BorderSide(color: Colors.red, width: 2.0),
                              ),
                              border: OutlineInputBorder(),
                            ),
                            validator: _validateEmail,
                            onChanged: (value) {
                              // Handle the input value change
                            },
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 70,
                          // height: 50.0,
                          child: TextFormField(
                            controller: passwordController,
                            decoration: const InputDecoration(
                                labelText: 'Password',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  borderSide:
                                  BorderSide(color: Colors.grey, width: 0.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: Colors.green, width: 2.0), // Set the desired border color and width
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                                  borderSide:
                                  BorderSide(color: Colors.red, width: 2.0),
                                ),
                                border: OutlineInputBorder()),
                            obscureText: true,
                            validator: _validatePassword,
                            onChanged: (value) {
                              // Handle the input value change
                            },
                          ),
                        ),
                        SizedBox(height: 20.0,),
                        Column(
                          children: [
                            ElevatedButton(
                              onPressed: () async  {
                                if (_formKey.currentState!.validate()) {
                                  try {

                                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                    );
                                    print("Successfully completed");

                                    // Sign-in successful, handle the result here
                                    CustomSnackBar.showSuccess(context, 'Login Success...');
                                  } on FirebaseAuthException catch (error) {
                                    // Handle any errors that occur during sign-in
                                    if (error.code == 'user-not-found') {
                                      CustomSnackBar.showError(context, 'User Not Found!');
                                    } else if (error.code == 'wrong-password') {
                                      CustomSnackBar.showError(context, 'Wrong Password!');
                                    }
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(100.0, 40.0),
                                primary: Colors.green[700], // Set the desired button color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0), // Set the desired border radius
                                ),
                              ),
                              child: Text('Sign In'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Register()), // Replace SecondPage with your desired destination page
                                );
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
                      ],
                    ),
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
}
