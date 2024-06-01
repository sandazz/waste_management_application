import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:waste_management_app/components/snackbar.dart';
import 'package:waste_management_app/components/textFeild.dart';

class CollectorFormSignUp extends StatelessWidget {
  CollectorFormSignUp({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final fullNameController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final nicController = TextEditingController();

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

  String? _validateNIC(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mobile Number is required';
    }
    return null;
  }

  Future<void> _collectorDetailEnter(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      String name = fullNameController.text.trim();
      String mobile = mobileNumberController.text.trim();
      String NIC = nicController.text.trim();
      print("Collector detail entered name: $name Mobile number: $mobile NIC number: $NIC");

      Map<String, String> dataToSave = {
        "fullName": fullNameController.text.trim(),
        "mobile": mobileNumberController.text.trim(),
        "nic" : nicController.text.trim(),
        "role": "collector",
        "verified" : 'false',
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
            onPressed: () {// Handle leading icon press
              Navigator.of(context).pop();
            },
          ),
        ),
        title: Text(
          'Collector Details',
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
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 400.0,
                    child: Image.asset(
                      "assets/app_images/collector_detail_image.jpg", // Replace "image.jpg" with the actual filename and extension of your image
                      fit: BoxFit.cover, // Choose the desired fit option (e.g., BoxFit.cover, BoxFit.fill)
                    ),
                  ),
                  MyTextField(
                    controller: fullNameController,
                    hintText: "Full Name of the Donor",
                    obscureText: false,
                    validator: _validateFullName,
                  ),
                  SizedBox(height: 10,),
                  MyTextField(
                    controller: mobileNumberController,
                    hintText: "Mobile Number",
                    obscureText: false,
                    validator: _validateMobileNumber,
                  ),
                  SizedBox(height: 10,),
                  MyTextField(
                    controller: nicController,
                    hintText: "NIC Number",
                    obscureText: false,
                    validator: _validateNIC,
                  ),
                  SizedBox(height: 20,),
                  ElevatedButton(
                    onPressed: () {
                      _collectorDetailEnter(context);  // Pass context here
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(100.0, 40.0), backgroundColor: Colors.green[700], // Set the desired button color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0), // Set the desired border radius
                      ),
                    ),
                    child: Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.white,
                        )
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}