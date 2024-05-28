import 'package:flutter/material.dart';
import 'package:waste_management_app/components/textFeild.dart';

class UserFormSignUp extends StatelessWidget {
  UserFormSignUp({super.key});

  final fullNameController = TextEditingController();
  final mobileNumberController = TextEditingController();


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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 400.0,
                    child: Image.asset(
                      "assets/app_images/donor_detail_image.png", // Replace "image.jpg" with the actual filename and extension of your image
                      fit: BoxFit.cover, // Choose the desired fit option (e.g., BoxFit.cover, BoxFit.fill)
                    ),
                  ),
                  MyTextField(
                    controller: fullNameController,
                    hintText: "Full Name of the Donor",
                    obscureText: true,
                    validator: _validateFullName,
                  ),
                  SizedBox(height: 10,),
                  MyTextField(
                    controller: mobileNumberController,
                    hintText: "Mobile Number",
                    obscureText: true,
                    validator: _validateMobileNumber,
                  ),
                  SizedBox(height: 20,),
                  ElevatedButton(
                    onPressed: () => {},
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
