import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:timeitapp/model/globals.dart';
import 'package:timeitapp/widgets/Log_out.dart';

import 'new_user_textfield.dart';

class CreateWorkerAccount extends StatefulWidget {
  const CreateWorkerAccount({super.key});

  @override
  State<CreateWorkerAccount> createState() => _CreateWorkerAccountState();
}

class _CreateWorkerAccountState extends State<CreateWorkerAccount> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var surname1Controller = TextEditingController();
  var surname2Controller = TextEditingController();
  var dniController = TextEditingController();
  var priceHourController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future createUser() async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(child: CircularProgressIndicator());
      },
    );
    FirebaseApp app = await Firebase.initializeApp(
        name: 'secondary', options: Firebase.app().options);
    var createdUser = await FirebaseAuth.instanceFor(app: app)
        .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim());
    app.delete();
    print(createdUser);
    var userId = await createdUser.user!.uid;
    print(userId);

    DocumentReference newUser = FirebaseFirestore.instance
        .doc('/Company/kGCOpHgRyiIYLr4Fwuys/User/${userId}');
    newUser
        .set({
          'name': nameController.text,
          'firstSurname': surname1Controller.text,
          'secondSurname': surname2Controller.text,
          'dni': dniController.text,
          'admin': false,
          'atWork': false,
          'priceHour': priceHourController.text,
          'photoPath': '',
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 90,
        ),
        Center(
            child: Text('Add a new employee', style: TextStyle(fontSize: 14))),
        SizedBox(
          height: 20,
        ),
        NewUserTextField(
            controller: nameController, hintText: 'Name', index: null),
        SizedBox(
          height: 20,
        ),
        NewUserTextField(
            controller: surname1Controller,
            hintText: 'First Surname',
            index: null),
        SizedBox(
          height: 20,
        ),
        NewUserTextField(
            controller: surname2Controller,
            hintText: 'Second Surname',
            index: null),
        SizedBox(
          height: 20,
        ),
        NewUserTextField(
            controller: dniController, hintText: 'DNI', index: null),
        SizedBox(
          height: 20,
        ),
        NewUserTextField(
            controller: emailController, hintText: 'Email', index: 0),
        SizedBox(
          height: 20,
        ),
        NewUserTextField(
            controller: passwordController, hintText: 'Password', index: 1),
        SizedBox(
          height: 20,
        ),
        NewUserTextField(
            controller: priceHourController, hintText: 'Price Hour', index: 2),
        SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: (() {
            createUser();
          }),
          child: Container(
            width: w * 0.93,
            height: h * 0.06,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromRGBO(57, 67, 156, 1),
            ),
            child: Center(
              child: Text(
                "Add employee",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        LogOut(w, h),
      ],
    );
  }
}
