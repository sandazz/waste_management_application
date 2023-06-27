import 'package:flutter/material.dart';


class LeaderBoard extends StatefulWidget {
  const LeaderBoard({Key? key}) : super(key: key);

  @override
  State<LeaderBoard> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  @override

  List<String> texts = [
    'S. A. S. Gimhana',
    'L. H. Sanjana',
    'G. N. Krishanthi',
    'S. A. Thilak',
    'S. A. H. Eranditha',
    'L. J. Kumara',
    'S. D. Renuka',
    'L. P. Chiranthana'
  ];


  Widget build(BuildContext context) {
    int colorIntensity = 800;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 25.0),
          child: Text(
              'LeaderBoard',
            style: TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            children: texts.asMap().entries.map((entry) {
              int index = entry.key + 1; // count of the names
              String text = entry.value; // names in the list
              String indexWithLeadingZero = index.toString().padLeft(2, '0'); // to make numbering 01, 02, 03

              if (colorIntensity > 300){
                colorIntensity = colorIntensity - (index * 100);
              }else{
                colorIntensity =50;
              }
              return Container(
                  width: 500.0, // Set the width of the container
                  height: 50.0, // Set the height of the container
                  padding: EdgeInsets.all(16.0), // Set the padding within the container
                  margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 3.0), // Set the margin around the container
                  decoration: BoxDecoration(
                    color: Colors.green[colorIntensity], // Set the background color of the container
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
                  child: Row(
                    children: [

                      Text(
                        '$indexWithLeadingZero',
                        style: TextStyle(
                          fontSize: 20.0,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 30.0,),
                      Text(
                        text,
                        style: TextStyle(
                          fontSize: 20.0,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

