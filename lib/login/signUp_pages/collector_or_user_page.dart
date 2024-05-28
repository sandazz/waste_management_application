import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:waste_management_app/components/userRole_squre_tile.dart';
import 'package:waste_management_app/login/signUp_pages/collector_form_page.dart';
import 'package:waste_management_app/login/signUp_pages/user_form_page.dart';

class CollectorOrUser extends StatelessWidget {
  CollectorOrUser({super.key});

  String userOrCollectorImageURL = "assets/app_images/user_or_collector.png";

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
              FirebaseAuth.instance.signOut();
            },
          ),
        ),
        title: Text(
          'Choose Ur Role',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 400.0,
                child: Image.asset(
                  userOrCollectorImageURL, // Replace "image.jpg" with the actual filename and extension of your image
                  fit: BoxFit.cover, // Choose the desired fit option (e.g., BoxFit.cover, BoxFit.fill)
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // google button
                  UserRoleSquareTile(
                    role: 'User',
                    imagePath: 'assets/app_images/donor_icon.png',
                    onTap: () => UserFormSignUp(),
                  ),
                  const SizedBox(width: 20,),
                  UserRoleSquareTile(
                    role: 'Collector',
                    imagePath: 'assets/app_images/collector_icon.png',
                    onTap: () => CollectorFormSignUp(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
