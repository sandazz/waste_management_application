import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RecycleForm extends StatefulWidget {
  const RecycleForm({super.key});

  @override
  State<RecycleForm> createState() => _RecycleFormState();
}

class _RecycleFormState extends State<RecycleForm> {

  late File _image;
  final ImagePicker _picker = ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> _takePicture() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      print("Picture was taken successfully");
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_image == null) return;

    try {
      String fileName = 'images/${DateTime.now().millisecondsSinceEpoch}.jpg';
      await _storage.ref(fileName).putFile(_image);

      String downloadURL = await _storage.ref(fileName).getDownloadURL();
      print('Download URL: $downloadURL');
    } catch (e) {
      print('Error uploading image: $e');
    }
  }


  Future<void> handleSubmit() async {
    _takePicture();
    print('image:');
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
          'Recycle Form',
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 300.0,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Number of Bottles',
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
                      )
                  ),

                ],
              ),
              SizedBox(height: 20.0,),
              ElevatedButton(
                onPressed: handleSubmit,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(100.0, 40.0), backgroundColor: Colors.green[700], // Set the desired button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0), // Set the desired border radius
                  ),
                ),
                child: Text(
                  'Submit',
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
              ),
            ]
          )
        ),
      )
    );
  }
}
