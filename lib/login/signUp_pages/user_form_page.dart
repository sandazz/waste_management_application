import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:waste_management_app/components/snackbar.dart';
import 'package:waste_management_app/components/textFeild.dart';

class UserFormSignUp extends StatelessWidget {
  UserFormSignUp({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final fullNameController = TextEditingController();
  final mobileNumberController = TextEditingController();

  final User currentUser = FirebaseAuth.instance.currentUser!;

  String? _validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Full Name is required';
    }
    return null;
  }

  String? _validateMobileNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mobile Number is required';
    }
    return null;
  }

  Future<void> _donorDetailEnter(BuildContext context) async {
    if (_formKey.currentState!.validate()) {

      Map<String, String> dataToSave = {
        "fullName": fullNameController.text.trim(),
        "mobile": mobileNumberController.text.trim(),
        "role": "user",
      };

      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .set(dataToSave);
        CustomSnackBar.showSuccess(context, 'Data saved successfully...');
        Navigator.pop(context);
      } catch (e) {
        print('An error occurred while saving data to Firestore: $e');
        CustomSnackBar.showError(context, 'An error occurred while saving data. Please try again.');
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
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        title: Text(
          'Donor Details',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 400.0,
                      child: Image.asset(
                        "assets/app_images/donor_detail_image.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    MyTextField(
                      controller: fullNameController,
                      hintText: "Full Name of the Donor",
                      obscureText: false,
                      validator: _validateFullName,
                    ),
                    SizedBox(height: 10),
                    MyTextField(
                      controller: mobileNumberController,
                      hintText: "Mobile Number",
                      obscureText: false,
                      validator: _validateMobileNumber,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        _donorDetailEnter(context);  // Pass context here
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(100.0, 40.0),
                        backgroundColor: Colors.green[700],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
