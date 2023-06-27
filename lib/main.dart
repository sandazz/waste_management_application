import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:waste_management_app/login/login.dart';
import 'package:waste_management_app/pages/collector/Collector.dart';
import 'package:waste_management_app/pages/enduser/layout.dart';



String name = '' ;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  runApp(MaterialApp(
      home: App(),
    )
  );
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  var role ;

  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            FirebaseFirestore.instance.collection("users").where("email", isEqualTo:snapshot.data!.email).get().then(
              (querySnapshot) {
                print("Successfully completed");
                for (var docSnapshot in querySnapshot.docs) {
                  role = docSnapshot.data()["role"];
                  print("role: $role");
                }
              },
              onError: (e) => print("Error completing: $e"),
            );
            if(role == "collector"){
              return Collector();
            }else if (role == "user"){
              return BottomNavigationExample();
            }else{
              return login();
            }
          }else{
            return const login();
          }
        },
      );
  }
}



