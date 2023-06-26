import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:waste_management_app/login/register.dart';
import 'package:waste_management_app/main.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[900],
      body: Stack(
        children: [
          Positioned(
            top: 100,
            left: 25,
            child: Container(
              child: Text(
                "Hello.... \nWelcome Back",
              style: TextStyle(
                fontSize: 39,
                fontWeight: FontWeight.w700,
                color: Colors.white
              ),
            )
            ),
          ),
          Positioned(
            top: 550,
            left: 25,
            child: Container(
                width: MediaQuery.of(context).size.width - 50, // Set the width of the container
                height: MediaQuery.of(context).size.height - 575, // Set the height of the container
                decoration: BoxDecoration(
                  color: Colors.white, // Set the background color of the container
                  borderRadius: BorderRadius.circular(20.0), // Set the border radius of the container
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54.withOpacity(0.5),
                      spreadRadius: 3.0,
                      blurRadius: 7.0,
                      offset: Offset(0, 0), // Adjust the shadow position as needed
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 20.0,
                      left: 10.0,
                      child: Container(
                        width: MediaQuery.of(context).size.width - 70,
                        height: 50.0,
                        child: TextField(
                          controller: emailController,
                          decoration: const InputDecoration(
                              labelText: 'Email',
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                borderSide:
                                BorderSide(color: Colors.grey, width: 0.0),
                              ),
                              border: OutlineInputBorder()),
                          onChanged: (value) {
                            // Handle the input value change
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      top: 90.0,
                      left: 10.0,
                      child: Container(
                        width: MediaQuery.of(context).size.width - 70,
                        height: 50.0,
                        child: TextField(
                          controller: passwordController,
                          decoration: const InputDecoration(
                              labelText: 'Password',
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                borderSide:
                                BorderSide(color: Colors.grey, width: 0.0),
                              ),
                              border: OutlineInputBorder()),
                          onChanged: (value) {
                            // Handle the input value change
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      top: 175,
                      left: MediaQuery.of(context).size.width/2 - 75,
                      child: Column(
                        children: [
                            ElevatedButton(
                              onPressed: () {
                                FirebaseAuth.instance.signInWithEmailAndPassword(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                );
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
                    ),
                  ],
                )
            ),
          ),
        ],
      ),
    );
  }
}
