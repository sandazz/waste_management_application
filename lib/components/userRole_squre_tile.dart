import 'package:flutter/material.dart';

class UserRoleSquareTile extends StatelessWidget {
  final Function()? onTap;
  final String imagePath;
  final String role;
  const UserRoleSquareTile({
    super.key,
    required this.imagePath,
    required this.role,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => onTap!()),
          );
        }
      },
      child: Container(

        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white, // Set the background color of the container
          borderRadius: BorderRadius.circular(20.0), // Set the border radius of the container
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2.0,
              blurRadius: 5.0,
              offset: const Offset(0, 3), // Adjust the shadow position as needed
            ),
          ],
        ),
        child: Column(
          children: [


            Image.asset(
              imagePath,
              height: 60,
            ),
            SizedBox(height: 5,),
            Text(role,
              style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      ),
    );
  }
}