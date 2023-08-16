import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class LeaderBoard extends StatefulWidget {
  const LeaderBoard({Key? key}) : super(key: key);

  @override
  State<LeaderBoard> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  @override

  Future<void> getRecycleUsers() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('recycledWasteEndUser')
          .orderBy('spinnablePoints', descending: true)
          .get();

      if (querySnapshot.size > 0) {
        // Documents exist in the collection
        for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
          // Access each document's data
          Object? data = documentSnapshot.data();
          String uid = documentSnapshot.id;
          DocumentSnapshot documentSnapshot1 = await FirebaseFirestore.instance
              .collection("users")
              .doc(uid)
              .get();



          if (documentSnapshot.exists) {
            Map<String, dynamic> data1 = documentSnapshot1.data() as Map<String, dynamic>;
            setState(() {
              String firstName = data1['fname'];
              names.add(firstName);
              double redeemablePoint = documentSnapshot['spinnablePoints'];
              redeemablePoints.add(redeemablePoint);
            });
          } else {
            print("User not found");
          }
        }
      } else {
        // Collection is empty
        print('No documents found in the collection.');
      }
    } catch (e) {
      // Handle any errors that occurred during the process
      print('Error retrieving documents: $e');
    }
    print(redeemablePoints);
    print(names);

  }


  List<String> names = [
  ];
  List<double> redeemablePoints = [
  ];

  @override
  void initState() {
    super.initState();
    getRecycleUsers();
  }



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
            children: names.asMap().entries.map((entry) {
              int idx = entry.key;
              double points = redeemablePoints[idx];
              int index = entry.key + 1; // count of the names
              String text = entry.value; // names in the list
              String indexWithLeadingZero = index.toString().padLeft(2, '0'); // to make numbering 01, 02, 03

              if (colorIntensity > 300){
                colorIntensity = colorIntensity - (index * 100);
              }else{
                colorIntensity =50;
              }
              return AspectRatio(
                aspectRatio: 12/2,
                  child: Container(
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
                          ),
                        ),
                        Spacer(), // Spacer will take all available space pushing the next widgets to the center
                        Expanded( // Expanded will ensure the text widget takes only the space it needs
                          child: Center(
                            child: Text(
                              text,
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ),
                        Spacer(), // Spacer will take all available space pushing the next widgets to the end
                        Text(
                          '${points}',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

