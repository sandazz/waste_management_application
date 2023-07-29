import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:waste_management_app/components/snackbar.dart';
import 'package:waste_management_app/login/login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    // Check length of email
    if (value.length > 50) {
      return 'Email cannot exceed 50 characters';
    }

    // Check if the email has specific domain (like gmail.com)
    if (!value.endsWith('@gmail.com')) {
      return 'Only gmail.com email addresses are allowed';
    }

    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Enter a valid email address';
    }

    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    // Check for at least one lowercase letter in the password
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }

    // Check for at least one uppercase letter in the password
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }

    // Check for at least one digit in the password
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one number';
    }

    // Check for at least one special character in the password
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }

    return null;
  }


  String? _validateFname(String? value) {
    // Check if the input is empty
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }

    // Check if the input only contains alphabets and spaces
    if (!RegExp(r'^[a-zA-Z\s]*$').hasMatch(value)) {
      return 'Name can only contain alphabets and spaces';
    }

    // Check if the input contains at least a first name and a last name
    if (!value.trim().contains(' ')) {
      return 'Please enter both first and last name';
    }

    return null;
  }

  String? _validateLocation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Location is required';
    }
    return null;
  }

  String? _validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mobile is required';
    }

    // Check for non-numeric characters
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Mobile number can only contain digits';
    }

    // Check for the correct number of digits for a mobile number
    // (Assuming a mobile number should have 10 digits - modify this as necessary)
    if (value.length != 10) {
      return 'Mobile number must contain exactly 10 digits';
    }

    // Check for specific starting digits
    // (Assuming a mobile number should start with '07' - modify this as necessary)
    if (!value.startsWith('07')) {
      return 'Mobile number must start with 07';
    }

    return null;
  }

  String? _validateRole(String? value) {
    if (value == null || value.isEmpty) {
      return 'Role is required';
    }
    return null;
  }

  String? _validateNIC(String? value) {
    if (value == null || value.isEmpty) {
      return 'NIC is required';
    }

    // Check for non-numeric characters (allowing for a letter at the end)
    if (!RegExp(r'^[0-9]{9}[vVxX]?$').hasMatch(value)) {
      return 'NIC number should be 9 digits followed by an optional letter';
    }

    // Check for the correct number of digits/characters in the NIC
    if (value.length != 10 && value.length != 12) {
      return 'NIC number must contain exactly 10 or 12 characters';
    }

    return null;
  }


  @override
  Widget build(BuildContext context) {

    String? selectedOption = "collector";

    final fnameController = TextEditingController();
    final locationController = TextEditingController();
    final emailController = TextEditingController();
    final mobileController = TextEditingController();
    final roleController = TextEditingController();
    final nicController = TextEditingController();
    final passwordController = TextEditingController();

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
          'Sign Up',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,

      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 20.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(

                        width: 300.0,
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'First Name',
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
                          validator: _validateFname,
                          controller: fnameController,
                        )
                    )
                  ],
                ),
                SizedBox(height: 20.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(

                        width: 300.0,
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Location',
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
                              border: OutlineInputBorder()),
                          validator: _validateLocation,
                          controller: locationController,
                        )
                    )
                  ],
                ),
                SizedBox(height: 20.0,),
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
                              border: OutlineInputBorder()),
                          validator: _validateEmail,
                          controller: emailController,
                        )
                    )
                  ],
                ),
                SizedBox(height: 20.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(

                        width: 300.0,
                        child: TextFormField(
                          decoration:  InputDecoration(
                              labelText: 'Mobile',
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
                              border: OutlineInputBorder()),
                          validator: _validateMobile,
                          controller: mobileController,
                        )
                    )
                  ],
                ),
                SizedBox(height: 20.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 300.0,
                      child: DropdownButtonFormField<String>(
                        decoration:  InputDecoration(
                            labelText: 'role',
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
                            border: OutlineInputBorder()
                        ),
                        validator: _validateRole,
                        onChanged: (value) {
                            selectedOption = value!;
                        },
                        items: [
                          DropdownMenuItem(
                            value: 'user',
                            child: Text('User'),
                          ),
                          DropdownMenuItem(
                            value: 'collector',
                            child: Text('Collector'),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20.0,),
                Visibility(
                  visible: selectedOption == 'collector',
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(

                          width: 300.0,
                          child: TextFormField(
                            decoration:  InputDecoration(
                                labelText: 'NIC No',
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
                                border: OutlineInputBorder()),
                            validator: _validateNIC,
                            controller: nicController,
                          )
                      )
                    ],
                ),
                  ),
                if (selectedOption == 'collector')
                SizedBox(height: 20.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(

                        width: 300.0,
                        child: TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(

                              labelText: 'Password',
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
                              border: OutlineInputBorder()),
                          validator: _validatePassword,
                          controller: passwordController,
                        )
                    )
                  ],
                ),
                SizedBox(height: 20.0,),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      //firebase auth data adding
                      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      );

                      roleController.text = selectedOption!;
                      if(roleController.text == 'user'){
                        //firebase firestore data adding
                        Map<String, String> dataToSave = {
                          "fname": fnameController.text.trim(),
                          "lccation": locationController.text.trim(),
                          "email": emailController.text.trim(),
                          "mobile": mobileController.text.trim(),
                          "role": roleController.text.trim(),
                          "password": passwordController.text.trim(),
                        };

                        try {
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(userCredential.user!.uid)
                              .set(dataToSave);

                          CustomSnackBar.showSuccess(context, 'Data saved successfully...');
                        } catch (e) {
                          print('An error occurred while saving data to Firestore: $e');
                          CustomSnackBar.showError(context, 'An error occurred while saving data. Please try again.');
                        }
                        FirebaseAuth.instance.signOut();
                        Navigator.of(context).pop();

                      }else if(roleController.text == 'collector'){
                        //firebase firestore data adding
                        Map<String, String> dataToSave = {
                          "fname": fnameController.text.trim(),
                          "lccation": locationController.text.trim(),
                          "email": emailController.text.trim(),
                          "mobile": mobileController.text.trim(),
                          "role": roleController.text.trim(),
                          "password": passwordController.text.trim(),
                          "nic" : nicController.text.trim(),
                          "google_map_location": '',
                          "verified" : 'false',
                        };
                        try {
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(userCredential.user!.uid)
                              .set(dataToSave);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Data saved successfully...'),
                              backgroundColor: Colors.green,),
                          );
                        } catch (e) {
                          print('An error occurred while saving data to Firestore: $e');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('An error occurred while saving data. Please try again.'),
                              backgroundColor: Colors.red,),
                          );
                        }
                        FirebaseAuth.instance.signOut();
                        Navigator.of(context).pop();
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(100.0, 40.0),
                    primary: Colors.green[700], // Set the desired button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0), // Set the desired border radius
                    ),
                  ),
                  child: Text('Sign up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
