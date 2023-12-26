import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class login2 extends StatefulWidget {
  const login2({super.key});

  @override
  State<login2> createState() => _login2State();
}

class _login2State extends State<login2> {
  String loginLogoImageURL = "assets/app_images/splashScreen_image.png";
  String loginLogoNameURL = "assets/app_images/splashScreen_name.png";

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
                    Container(
                      width: 300.0,
                      child: Column(
                        children: [
                          TextFormField(
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
                            onChanged: (value) {
                              // Handle the input value change
                            },
                          ),
                          SizedBox(height: 10.0,),
                          TextFormField(
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
                            obscureText: true,
                            onChanged: (value) {
                              // Handle the input value change
                            },
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
                              onPressed: () async  {
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(100.0, 50.0),
                                primary: Colors.green[700], // Set the desired button color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0), // Set the desired border radius
                                ),
                              ),
                              child: Text(
                                  'Sign In',
                                      style: TextStyle(
                                        fontSize: 18.0
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
                                    },
                                ),
                              ],
                            ),
                          ),
                        ],
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
