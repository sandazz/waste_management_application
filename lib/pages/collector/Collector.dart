
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Collector extends StatefulWidget {
  const Collector({super.key});

  @override
  State<Collector> createState() => _CollectorState();
}

class _CollectorState extends State<Collector> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Collector'),
        actions: [
          Padding(
            padding: EdgeInsets.all(0.0),
            child: IconButton(
              icon: Icon(Icons.notifications,
                color: Colors.white,
                size: 30.0,
              ),
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
            ),
          ),
        ],
      ),
    );
  }
}
