import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:waste_management_app/login/login.dart';
import 'package:waste_management_app/pages/collector/Collector.dart';
import 'package:waste_management_app/pages/enduser/layout.dart';
import 'package:provider/provider.dart';
import 'package:waste_management_app/providers/loginProvider.dart';

String name = '' ;

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
  @override
  var role ;

  Widget build(BuildContext context) {

    final loginDetails = Provider.of<LoginData>(context, listen: false);  // use provider to save role when login and used here

    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            role = loginDetails.getRole;
            if (role == "collector") {
              return LayoutCollector(); // when user is a collector
            } else if (role == "user") {
              return BottomNavigationExample(); // when user is an end user
            } else {
              // return LayoutCollector();
              return login(); // when unauthorized user
            }
          } else {
            // return LayoutCollector();
            return const login(); // when user is signed out
          }
        },
      );
  }
}



