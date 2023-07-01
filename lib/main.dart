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
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  var role ;

  Widget build(BuildContext context) {

    final LoginDetails = Provider.of<LoginData>(context, listen: false);  // use provider to save role when login and used here

    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            role = LoginDetails.getRole;
            if(role == "collector"){            // when user is collector
              return Collector();
            }else if (role == "user"){          // when user is enduser
              return BottomNavigationExample();
            }else{                              // when not unauthorized user
              return login();
            }
          }else{
            return const login();
          }
        },
      );
  }
}



