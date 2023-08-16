// TODO Implement this library.import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:waste_management_app/login/login.dart';
import 'package:waste_management_app/pages/collector/Collector.dart';
import 'package:waste_management_app/pages/collector/NotVerified.dart';
import 'package:waste_management_app/pages/enduser/layout.dart';
import 'package:provider/provider.dart';
import 'package:waste_management_app/providers/loginProvider.dart';
import 'package:flutter/services.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => LoginData())
    ],
    child: MaterialApp(
      home: App(),
    ),
  )
  );
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  Widget build(BuildContext context) {

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final User currentUser = FirebaseAuth.instance.currentUser!;
          print("----------- user : ${currentUser.uid}");

          return StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(currentUser.uid)
                  .snapshots(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  print("------------ConnectionState.waiting");
                  return login();
                }
                if (snapshot.hasError) {
                  print("----------snapshot.hasError");
                  return login();
                }

                if (snapshot.hasData && snapshot.data!.data() == null) {
                  print("-----snapshot.data!.data() == null");
                  return login();
                } else if (snapshot.hasData && snapshot.data!.data() != null && snapshot.data!.get("role") == "collector") {
                  print("---------role = collector");
                  if(snapshot.data!.get("verified") == "true"){
                    return LayoutCollector();
                  }else{
                    return NotVerified();
                  }

                } else if (snapshot.hasData && snapshot.data!.data() != null && snapshot.data!.get("role") == "user") {
                  print("--------role = user");
                  return BottomNavigationExample();
                }
                print("-----------return login()");
                return login();
              });

        } else {
          // return LayoutCollector();
          print("-----------No user");
          return const login(); // when user is signed out
        }
      },
    );
  }
}



