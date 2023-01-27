import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
Future signOut() async {
    try {
      return await FirebaseAuth.instance.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
GestureDetector LogOut(double w, double h) {
    return GestureDetector(
        onTap: (() {
          signOut();
        }),
        child: Container(
          width: w * 0.93,
          height: h * 0.06,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color.fromARGB(255, 220, 15, 0),
          ),
          child: Center(
            child: Text(
              "Sign out",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      );
  }
