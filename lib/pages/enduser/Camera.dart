import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/src/material/icons.dart';



class Camera extends StatefulWidget {
  const Camera({Key? key}) : super(key: key);

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  String _scanBarcode = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot<Map<String, dynamic>>?> getSmartBinDataById(String id) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> doc = await _firestore.collection('smartBins').doc(id).get();
      if (doc.exists) {
        print('Document data: ${doc.data()}');
        return doc;
      } else {
        print('No such document!');
        return null;
      }
    } catch (e) {
      print('Error getting document: $e');
      rethrow;
    }
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
      getSmartBinDataById(_scanBarcode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
            body: Builder(builder: (BuildContext context) {
              return Container(
                  alignment: Alignment.center,
                  child: Flex(
                      direction: Axis.vertical,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton.icon(
                            onPressed: () => scanQR(),
                            style: ElevatedButton.styleFrom(
                              elevation: 8.0, backgroundColor: Colors.green,
                              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0), // Set the background color for the button
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30), // Set the border radius here
                              ),
                            ),
                            icon: Icon(Icons.qr_code_2_outlined),
                            label: Text('QR Scan')),
                        SizedBox(height: 10.0,),
                        Text('Scan result : $_scanBarcode\n',
                            style: TextStyle(fontSize: 20))
                      ]));
            }));
  }
}
