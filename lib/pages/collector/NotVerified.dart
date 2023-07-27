import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:waste_management_app/login/login.dart';

class NotVerified extends StatefulWidget {
  const NotVerified({super.key});

  @override
  State<NotVerified> createState() => _NotVerifiedState();
}

class _NotVerifiedState extends State<NotVerified> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      FirebaseAuth.instance.signOut();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Text(
            'Your Collecting Account not Verified.\n Please Try Again later.',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 30,
              color: Colors.green[900],
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
