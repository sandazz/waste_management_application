import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Achievement extends StatefulWidget {
  const Achievement({Key? key}) : super(key: key);

  @override
  State<Achievement> createState() => _AchievementState();
}

class _AchievementState extends State<Achievement> {
  @override
  Widget build(BuildContext context) {
    return
        Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Text(
                  'Achievement',
                  style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 85.0, // Set the width of the container
                    height: 85.0, // Set the height of the container
                    padding: EdgeInsets.all(16.0),
                    margin: EdgeInsets.symmetric(horizontal: 5.0),// Set the padding within the container
                    decoration: BoxDecoration(
                      color: Colors.white, // Set the background color of the container
                      borderRadius: BorderRadius.circular(20.0), // Set the border radius of the container
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2.0,
                          blurRadius: 5.0,
                          offset: Offset(0, 3), // Adjust the shadow position as needed
                        ),
                      ],
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            'Cane',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                          SizedBox(height: 2.0),
                          Icon(
                            Icons.home,
                            size: 20.0,
                          ),
                          SizedBox(height: 2.0),
                          Text(
                            '0',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 85.0, // Set the width of the container
                    height: 85.0, // Set the height of the container
                    padding: EdgeInsets.all(16.0),
                    margin: EdgeInsets.symmetric(horizontal: 5.0),// Set the padding within the container
                    decoration: BoxDecoration(
                      color: Colors.white, // Set the background color of the container
                      borderRadius: BorderRadius.circular(20.0), // Set the border radius of the container
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2.0,
                          blurRadius: 5.0,
                          offset: Offset(0, 3), // Adjust the shadow position as needed
                        ),
                      ],
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            'Cane',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                          SizedBox(height: 2.0),
                          Icon(
                            Icons.home,
                            size: 20.0,
                          ),
                          SizedBox(height: 2.0),
                          Text(
                            '0',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 85.0, // Set the width of the container
                    height: 85.0, // Set the height of the container
                    padding: EdgeInsets.all(16.0),
                    margin: EdgeInsets.symmetric(horizontal: 5.0),// Set the padding within the container
                    decoration: BoxDecoration(
                      color: Colors.white, // Set the background color of the container
                      borderRadius: BorderRadius.circular(20.0), // Set the border radius of the container
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2.0,
                          blurRadius: 5.0,
                          offset: Offset(0, 3), // Adjust the shadow position as needed
                        ),
                      ],
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            'Cane',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                          SizedBox(height: 2.0),
                          Icon(
                            Icons.home,
                            size: 20.0,
                          ),
                          SizedBox(height: 2.0),
                          Text(
                            '0',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 85.0, // Set the width of the container
                    height: 85.0, // Set the height of the container
                    padding: EdgeInsets.all(16.0),
                    margin: EdgeInsets.symmetric(horizontal: 5.0),// Set the padding within the container
                    decoration: BoxDecoration(
                      color: Colors.white, // Set the background color of the container
                      borderRadius: BorderRadius.circular(20.0), // Set the border radius of the container
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2.0,
                          blurRadius: 5.0,
                          offset: Offset(0, 3), // Adjust the shadow position as needed
                        ),
                      ],
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            'Cane',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                          SizedBox(height: 2.0),
                          Icon(
                            Icons.home,
                            size: 20.0,
                          ),
                          SizedBox(height: 2.0),
                          Text(
                            '0',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(16.0), // Set the padding within the container
                margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0), // Set the margin around the container
                decoration: BoxDecoration(
                  color: Colors.green, // Set the background color of the container
                  borderRadius: BorderRadius.circular(20.0), // Set the border radius of the container
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2.0,
                      blurRadius: 5.0,
                      offset: Offset(0, 3), // Adjust the shadow position as needed
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                        width: 500.0, // Set the width of the container
                        height: 30.0, // Set the height of the container
                        margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 3.0),
                        decoration: BoxDecoration(
                          color: Colors.white, // Set the background color of the container
                          borderRadius: BorderRadius.circular(15.0), // Set the border radius of the container
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1.0,
                              blurRadius: 2.0,
                              offset: Offset(0, 3), // Adjust the shadow position as needed
                            ),
                          ],
                        ),
                        child: Center(child: Text('Cane Collector'))
                    ),
                    Container(
                        width: 500.0, // Set the width of the container
                        height: 30.0, // Set the height of the container
                        margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 3.0),
                        decoration: BoxDecoration(
                          color: Colors.white, // Set the background color of the container
                          borderRadius: BorderRadius.circular(15.0), // Set the border radius of the container
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1.0,
                              blurRadius: 2.0,
                              offset: Offset(0, 3), // Adjust the shadow position as needed
                            ),
                          ],
                        ),
                        child: Center(child: Text('Cane Collector'))
                    ),
                    Container(
                        width: 500.0, // Set the width of the container
                        height: 30.0, // Set the height of the container
                        margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 3.0),
                        decoration: BoxDecoration(
                          color: Colors.white, // Set the background color of the container
                          borderRadius: BorderRadius.circular(15.0), // Set the border radius of the container
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1.0,
                              blurRadius: 2.0,
                              offset: Offset(0, 3), // Adjust the shadow position as needed
                            ),
                          ],
                        ),
                        child: Center(child: Text('Cane Collector'))
                    ),
                    Container(
                        width: 500.0, // Set the width of the container
                        height: 30.0, // Set the height of the container
                        margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 3.0),
                        decoration: BoxDecoration(
                          color: Colors.white, // Set the background color of the container
                          borderRadius: BorderRadius.circular(15.0), // Set the border radius of the container
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1.0,
                              blurRadius: 2.0,
                              offset: Offset(0, 3), // Adjust the shadow position as needed
                            ),
                          ],
                        ),
                        child: Center(child: Text('Cane Collector'))
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(16.0), // Set the padding within the container
                margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0), // Set the margin around the container
                decoration: BoxDecoration(
                  color: Colors.green, // Set the background color of the container
                  borderRadius: BorderRadius.circular(20.0), // Set the border radius of the container
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2.0,
                      blurRadius: 5.0,
                      offset: Offset(0, 3), // Adjust the shadow position as needed
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                        width: 500.0, // Set the width of the container
                        height: 30.0, // Set the height of the container
                        margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 3.0),
                        decoration: BoxDecoration(
                          color: Colors.white, // Set the background color of the container
                          borderRadius: BorderRadius.circular(15.0), // Set the border radius of the container
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1.0,
                              blurRadius: 2.0,
                              offset: Offset(0, 3), // Adjust the shadow position as needed
                            ),
                          ],
                        ),
                        child: Center(child: Text('Cane Collector'))
                    ),
                    Container(
                        width: 500.0, // Set the width of the container
                        height: 30.0, // Set the height of the container
                        margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 3.0),
                        decoration: BoxDecoration(
                          color: Colors.white, // Set the background color of the container
                          borderRadius: BorderRadius.circular(15.0), // Set the border radius of the container
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1.0,
                              blurRadius: 2.0,
                              offset: Offset(0, 3), // Adjust the shadow position as needed
                            ),
                          ],
                        ),
                        child: Center(child: Text('Cane Collector'))
                    ),
                    Container(
                        width: 500.0, // Set the width of the container
                        height: 30.0, // Set the height of the container
                        margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 3.0),
                        decoration: BoxDecoration(
                          color: Colors.white, // Set the background color of the container
                          borderRadius: BorderRadius.circular(15.0), // Set the border radius of the container
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1.0,
                              blurRadius: 2.0,
                              offset: Offset(0, 3), // Adjust the shadow position as needed
                            ),
                          ],
                        ),
                        child: Center(child: Text('Cane Collector'))
                    ),
                    Container(
                        width: 500.0, // Set the width of the container
                        height: 30.0, // Set the height of the container
                        margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 3.0),
                        decoration: BoxDecoration(
                          color: Colors.white, // Set the background color of the container
                          borderRadius: BorderRadius.circular(15.0), // Set the border radius of the container
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1.0,
                              blurRadius: 2.0,
                              offset: Offset(0, 3), // Adjust the shadow position as needed
                            ),
                          ],
                        ),
                        child: Center(child: Text('Cane Collector'))
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(16.0), // Set the padding within the container
                margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0), // Set the margin around the container
                decoration: BoxDecoration(
                  color: Colors.green, // Set the background color of the container
                  borderRadius: BorderRadius.circular(20.0), // Set the border radius of the container
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2.0,
                      blurRadius: 5.0,
                      offset: Offset(0, 3), // Adjust the shadow position as needed
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                        width: 500.0, // Set the width of the container
                        height: 30.0, // Set the height of the container
                        margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 3.0),
                        decoration: BoxDecoration(
                          color: Colors.white, // Set the background color of the container
                          borderRadius: BorderRadius.circular(15.0), // Set the border radius of the container
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1.0,
                              blurRadius: 2.0,
                              offset: Offset(0, 3), // Adjust the shadow position as needed
                            ),
                          ],
                        ),
                        child: Center(child: Text('Cane Collector'))
                    ),
                    Container(
                        width: 500.0, // Set the width of the container
                        height: 30.0, // Set the height of the container
                        margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 3.0),
                        decoration: BoxDecoration(
                          color: Colors.white, // Set the background color of the container
                          borderRadius: BorderRadius.circular(15.0), // Set the border radius of the container
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1.0,
                              blurRadius: 2.0,
                              offset: Offset(0, 3), // Adjust the shadow position as needed
                            ),
                          ],
                        ),
                        child: Center(child: Text('Cane Collector'))
                    ),
                    Container(
                        width: 500.0, // Set the width of the container
                        height: 30.0, // Set the height of the container
                        margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 3.0),
                        decoration: BoxDecoration(
                          color: Colors.white, // Set the background color of the container
                          borderRadius: BorderRadius.circular(15.0), // Set the border radius of the container
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1.0,
                              blurRadius: 2.0,
                              offset: Offset(0, 3), // Adjust the shadow position as needed
                            ),
                          ],
                        ),
                        child: Center(child: Text('Cane Collector'))
                    ),
                    Container(
                        width: 500.0, // Set the width of the container
                        height: 30.0, // Set the height of the container
                        margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 3.0),
                        decoration: BoxDecoration(
                          color: Colors.white, // Set the background color of the container
                          borderRadius: BorderRadius.circular(15.0), // Set the border radius of the container
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1.0,
                              blurRadius: 2.0,
                              offset: Offset(0, 3), // Adjust the shadow position as needed
                            ),
                          ],
                        ),
                        child: Center(child: Text('Cane Collector'))
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
    ;
  }
}
