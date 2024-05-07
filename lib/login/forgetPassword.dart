import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:waste_management_app/components/snackbar.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword>  {

  String forgetPasswordImageURL = "assets/app_images/forget_password_image.png";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

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

  Future<void> sendPasswordResetEmail() async {
    if (_formKey.currentState!.validate()) {
      try {
        print(emailController.text.trim());
        await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());
        CustomSnackBar.showSuccess(context, 'Password reset email sent. Check your inbox.');
      } catch (e) {
        print('Error sending password reset email: $e');
        CustomSnackBar.showError(context, 'Error sending password reset email.');
      }
    }
  }



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
              Navigator.of(context).pop();
            },
          ),
        ),
        title: Text(
          'Forget Password',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 50.0,),
              Container(
                width: 300.0,
                child: Image.asset(
                  forgetPasswordImageURL, // Replace "image.jpg" with the actual filename and extension of your image
                  fit: BoxFit.cover, // Choose the desired fit option (e.g., BoxFit.cover, BoxFit.fill)
                ),
              ),
              SizedBox(height: 10.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
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
                          border: OutlineInputBorder(),
                        ),
                        validator: _validateEmail,
                        controller: emailController,
                      )
                  )
                ],
              ),
              SizedBox(height: 20.0,),
              ElevatedButton(
                onPressed: () => sendPasswordResetEmail(),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(100.0, 40.0), backgroundColor: Colors.green[700], // Set the desired button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0), // Set the desired border radius
                  ),
                ),
                child: Text(
                    'Send Password Reset Email',
                  style: TextStyle(
                    color: Colors.white,
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
