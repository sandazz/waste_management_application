import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return
        Scaffold(
          body: Stack(
              alignment: Alignment.bottomCenter,
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 150.0, // Set the width of the container
                      height: 150.0, // Set the height of the container
                      padding: EdgeInsets.all(16.0), // Set the padding within the container
                      margin: EdgeInsets.all(8.0), // Set the margin around the container
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
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              'Points',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 30.0,
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Icon(
                                Icons.home,
                              size: 50.0,
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              '0',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 25.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 110.0, // Set the width of the container
                          height: 110.0, // Set the height of the container
                          padding: EdgeInsets.all(16.0), // Set the padding within the container
                          margin: EdgeInsets.all(8.0), // Set the margin around the container
                          decoration: BoxDecoration(
                            color: Colors.green[300], // Set the background color of the container
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
                                    fontSize: 20.0,
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                Icon(
                                  Icons.home,
                                  size: 30.0,
                                ),
                                SizedBox(height: 5.0),
                                Text(
                                  '0',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 110.0, // Set the width of the container
                          height: 110.0, // Set the height of the container
                          padding: EdgeInsets.all(16.0), // Set the padding within the container
                          margin: EdgeInsets.all(8.0), // Set the margin around the container
                          decoration: BoxDecoration(
                            color: Colors.green[300], // Set the background color of the container
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
                                  'Plastic',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                Icon(
                                  Icons.upload_sharp,
                                  size: 30.0,
                                ),
                                SizedBox(height: 5.0),
                                Text(
                                  '0',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 110.0, // Set the width of the container
                          height: 110.0, // Set the height of the container
                          padding: EdgeInsets.all(16.0), // Set the padding within the container
                          margin: EdgeInsets.all(8.0), // Set the margin around the container
                          decoration: BoxDecoration(
                            color: Colors.green[300], // Set the background color of the container
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
                                  'Glass',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                Icon(
                                  Icons.wine_bar_outlined,
                                  size: 30.0,
                                ),
                                SizedBox(height: 5.0),
                                Text(
                                  '0',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      width: 110.0, // Set the width of the container
                      height: 110.0, // Set the height of the container
                      padding: EdgeInsets.all(16.0), // Set the padding within the container
                      margin: EdgeInsets.all(8.0), // Set the margin around the container
                      decoration: BoxDecoration(
                        color: Colors.green[100], // Set the background color of the container
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
                              'Bins',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Icon(
                              Icons.delete_outline,
                              size: 30.0,
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              '0',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 60.0,)
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 16.0), // Add padding to adjust the button's position
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(150.0, 40.0),
                    elevation: 4.0, // Set the elevation of the button
                    backgroundColor: Colors.green[700], // Set the background color of the button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0), // Set the border radius of the button
                    ),
                  ),
                  onPressed: () {
                    // Handle button press
                  },
                  child: Text('Locations'),
                ),
              ),
            ]
          ),
        )
      ;
  }
}
