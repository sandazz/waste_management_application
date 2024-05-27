import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waste_management_app/components/snackbar.dart';
import 'package:waste_management_app/login/forgetPassword.dart';
import 'package:waste_management_app/login/login.dart';
import 'package:waste_management_app/login/register.dart';
import 'package:waste_management_app/login/register2.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with WidgetsBindingObserver{
  String loginLogoImageURL = "assets/app_images/splashScreen_image.png";
  String loginLogoNameURL = "assets/app_images/splashScreen_name.png";

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

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

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    return null;
  }

  // login using email and password
  _signUp() async {
    if (_formKey.currentState!.validate()) {
      if (confirmPasswordController.text == passwordController.text) {
        try {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );
          print("Successfully completed");

          // Sign-in successful, handle the result here
          CustomSnackBar.showSuccess(context, 'Sign Up Success...');
        } on FirebaseAuthException catch (error) {
            CustomSnackBar.showError(context, error.code);
        }
      }else {
        CustomSnackBar.showError(context, 'Password does not match...');
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 60.0,
                      child: Image.asset(
                        loginLogoImageURL, // Replace "image.jpg" with the actual filename and extension of your image
                        fit: BoxFit.cover, // Choose the desired fit option (e.g., BoxFit.cover, BoxFit.fill)
                      ),
                    ),
                    SizedBox(height: 10.0,),
                    Container(
                      width: 300.0,
                      child: Image.asset(
                        loginLogoNameURL, // Replace "image.jpg" with the actual filename and extension of your image
                        fit: BoxFit.cover, // Choose the desired fit option (e.g., BoxFit.cover, BoxFit.fill)
                      ),
                    ),
                    SizedBox(height: 50.0,),
                    Form(
                      key: _formKey,
                      child: Container(
                        width: 300.0,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: emailController,
                              decoration:  InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(
                                  color: Colors.green[700], // Set the desired text color
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: Colors.grey, width: 0.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: Colors.green, width: 2.0), // Set the desired border color and width
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                                  borderSide:
                                  BorderSide(color: Colors.red, width: 2.0),
                                ),
                                border: OutlineInputBorder(),
                              ),
                              validator: _validateEmail,
                              onChanged: (value) {
                                // Handle the input value change
                              },
                            ),
                            SizedBox(height: 10.0,),
                            Stack(
                                alignment: Alignment.centerRight,
                                children:[
                                  Container(
                                    child: TextFormField(
                                      controller: passwordController,
                                      decoration: InputDecoration(
                                          labelText: 'Password',
                                          labelStyle: TextStyle(
                                            color: Colors.green[700], // Set the desired text color
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                            borderSide:
                                            BorderSide(color: Colors.grey, width: 0.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                            borderSide: BorderSide(color: Colors.green, width: 2.0), // Set the desired border color and width
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(10.0)),
                                            borderSide:
                                            BorderSide(color: Colors.red, width: 2.0),
                                          ),
                                          border: OutlineInputBorder()),
                                      obscureText: !_passwordVisible,
                                      validator: _validatePassword,
                                      onChanged: (value) {
                                        // Handle the input value change
                                      },
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      // Based on passwordVisible state choose the icon
                                      _passwordVisible ? Icons.visibility : Icons.visibility_off,
                                      color: Colors.green,
                                    ),
                                    onPressed: () {
                                      // Update the state i.e. toogle the state of passwordVisible variable
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                  ),
                                ]

                            ),
                            SizedBox(height: 10.0,),
                            Stack(
                                alignment: Alignment.centerRight,
                                children:[
                                  Container(
                                    child: TextFormField(
                                      controller: confirmPasswordController,
                                      decoration: InputDecoration(
                                          labelText: 'Confirm Password',
                                          labelStyle: TextStyle(
                                            color: Colors.green[700], // Set the desired text color
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                            borderSide:
                                            BorderSide(color: Colors.grey, width: 0.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                            borderSide: BorderSide(color: Colors.green, width: 2.0), // Set the desired border color and width
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(10.0)),
                                            borderSide:
                                            BorderSide(color: Colors.red, width: 2.0),
                                          ),
                                          border: OutlineInputBorder()),
                                      obscureText: !_confirmPasswordVisible,
                                      validator: _validatePassword,
                                      onChanged: (value) {
                                        // Handle the input value change
                                      },
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      // Based on passwordVisible state choose the icon
                                      _confirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                      color: Colors.green,
                                    ),
                                    onPressed: () {
                                      // Update the state i.e. toogle the state of passwordVisible variable
                                      setState(() {
                                        _confirmPasswordVisible = !_confirmPasswordVisible;
                                      });
                                    },
                                  ),
                                ]

                            ),
                            SizedBox(height: 50.0,),
                            Container(
                              width: 300.0,
                              child: ElevatedButton(
                                onPressed: ()  {
                                  _signUp();
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(100.0, 50.0), backgroundColor: Colors.green[700], // Set the desired button color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0), // Set the desired border radius
                                  ),
                                ),
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10.0,),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 11.0,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Login',
                                    style: TextStyle(color: Colors.green, decoration: TextDecoration.underline,),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pop(context);
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
