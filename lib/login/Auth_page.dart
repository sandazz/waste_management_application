import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:waste_management_app/login/login.dart';
import 'package:waste_management_app/pages/collector/Collector.dart';
import 'package:waste_management_app/pages/collector/NotVerified.dart';
import 'package:waste_management_app/pages/enduser/layout.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // If user already logged in
          if (snapshot.hasData){
            final User currentUser = FirebaseAuth.instance.currentUser!;
            return StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance.collection("users").doc(currentUser.uid).snapshots(),
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {

                  // role is collector
                  if (snapshot.hasData && snapshot.data!.data() != null && snapshot.data!.get("role") == "collector") {
                    print("---------role = collector");

                    // collector is verified
                    if(snapshot.data!.get("verified") == "true"){
                      return ShowCaseWidget(
                          builder: Builder(
                              builder: (context) => LayoutCollector() // assuming you want to showcase something in LayoutCollector
                          )
                      );
                    }else{
                      // collector is not varified
                      return NotVerified();
                    }
                  }
                  // role is user
                  else if (snapshot.hasData && snapshot.data!.data() != null && snapshot.data!.get("role") == "user") {
                    print("--------role = user");
                    return ShowCaseWidget(
                        builder: Builder(
                            builder: (context) => BottomNavigationExample() // assuming you want to showcase something in LayoutCollector
                        )
                    );
                  }
                  print("-----------return login()");
                  return login();
                }
              );
          }
          // If user logged out or not signed up
          else {
            return const login();
          }
        },
      ),
    );
  }
}
