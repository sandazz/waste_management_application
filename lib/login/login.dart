import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:waste_management_app/components/squre_tile.dart';
import 'package:waste_management_app/components/snackbar.dart';
import 'package:waste_management_app/components/textFeild.dart';
import 'package:waste_management_app/login/forgetPassword.dart';
import 'package:waste_management_app/login/register.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> with WidgetsBindingObserver{
  String loginLogoImageURL = "assets/app_images/splashScreen_image.png";
  String loginLogoNameURL = "assets/app_images/splashScreen_name.png";

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _passwordVisible = false;

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
  _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        print("Successfully completed");

        // Sign-in successful, handle the result here
        CustomSnackBar.showSuccess(context, 'Login Success...');
      } on FirebaseAuthException catch (error) {
        // Handle any errors that occur during sign-in
        if (error.code == 'user-not-found') {
          CustomSnackBar.showError(context, 'User Not Found!');
        } else if (error.code == 'wrong-password') {
          CustomSnackBar.showError(context, 'Wrong Password!');
        }
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
                            MyTextField(
                              controller: emailController,
                              hintText: "Email",
                              obscureText: false,
                              validator: _validateEmail,
                            ),
                            SizedBox(height: 10.0,),
                            Stack(
                              alignment: Alignment.centerRight,
                                children:[
                                  Container(
                                    child: MyTextField(
                                      controller: passwordController,
                                      hintText: "Password",
                                      obscureText: !_passwordVisible,
                                      validator: _validatePassword,
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
                            Container(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 11.0,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'Forgot Password',
                                        style: TextStyle(color: Colors.green, decoration: TextDecoration.underline,),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => ForgetPassword()),
                                            );
                                          },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 50.0,),
                            Container(
                              width: 300.0,
                              child: ElevatedButton(
                                onPressed: ()  {
                                  _login();
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(100.0, 50.0), backgroundColor: Colors.green[700], // Set the desired button color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0), // Set the desired border radius
                                  ),
                                ),
                                child: Text(
                                    'Sign In',
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
                                    text: 'Register',
                                    style: TextStyle(color: Colors.green, decoration: TextDecoration.underline,),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => SignUp()),
                                        );
                                      },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.0,),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     // google button
                            //     SquareTile(
                            //       imagePath: 'assets/app_images/google_logo.png',
                            //       onTap: () => AuthService().signInWithGoogle(),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
            child: Text("!dea Factory | 2023"),
          ),
        ],
      ),
    );
  }
}
