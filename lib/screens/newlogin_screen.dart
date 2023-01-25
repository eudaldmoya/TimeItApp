import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_screen/overlay_screen.dart';
import 'package:timeitapp/model/globals.dart' as globals;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  Future signIn() async {
    //cargar cosas
    showDialog(
      context: context,
      builder: (context) {
        return Center(child: CircularProgressIndicator());
      },
    );

    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim());

    // espera();

    // globals.inicioAtWork();
    // print('La variable atwork ${globals.atWork}');

    Navigator.of(context).pop();
  }

  // Future espera() async {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return Center(child: CircularProgressIndicator());
  //     },
  //   );

  //   await globals.inicioAtWork();

  //   Navigator.of(context).pop();
  // }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SafeArea(
      child: Stack(children: [
        LayoutBuilder(builder: (context, BoxConstraints constraints) {
          return Image.asset('assets/back2.png',
              fit: BoxFit.cover, width: constraints.maxWidth);
        }),
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  width: w,
                  height: h * 0.4,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Welcome to",
                            style: GoogleFonts.roboto(
                                fontSize: 40, fontWeight: FontWeight.w100)),
                        Text("TimeIt!",
                            style: GoogleFonts.roboto(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 47, 55, 133))),
                      ],
                    ),
                  )),
              Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  width: w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 90,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(0, 255, 255, 255),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            // BoxShadow(
                            //   spreadRadius: 7,
                            //   blurRadius: 10,
                            //   offset: Offset(1, 1),
                            //   color: Colors.grey.withOpacity(0.2),
                            // ),
                          ],
                        ),
                        child: TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                              hintText: "Email",
                              prefixIcon: Icon(Icons.email,
                                  color: Color.fromRGBO(57, 67, 156, 1)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 25, 29, 69),
                                    width: 1.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1.0),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30))),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(0, 255, 255, 255),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            // BoxShadow(
                            //   spreadRadius: 7,
                            //   blurRadius: 10,
                            //   offset: Offset(1, 1),
                            //   color: Color.fromARGB(0, 158, 158, 158).withOpacity(0.2),
                            // ),
                          ],
                        ),
                        child: TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: "Pasword",
                              prefixIcon: Icon(Icons.password,
                                  color: Color.fromRGBO(57, 67, 156, 1)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 25, 29, 69),
                                    width: 1.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    width: 1.0),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30))),
                        ),
                      )
                    ],
                  )),
              SizedBox(
                height: 90,
              ),
              GestureDetector(
                onTap: signIn,
                child: Container(
                  width: w * 0.93,
                  height: h * 0.06,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(57, 67, 156, 1),
                  ),
                  child: Center(
                    child: Text(
                      "Log in",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    ));
  }
}
