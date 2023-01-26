import 'package:flutter/material.dart';

class NewUserTextField extends StatelessWidget {
  NewUserTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.index,
    this.width,
  }) : super(key: key);
  List<IconData> _icons = [
    Icons.email,
    Icons.password,
    Icons.monetization_on,
  ];
  final double? width;
  final int? index;
  final TextEditingController controller;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return FractionallySizedBox(
      widthFactor: width != null ? width : 1,
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(0, 255, 255, 255),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [],
        ),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: index != null
                  ? Icon(_icons[index!], color: Color.fromRGBO(57, 67, 156, 1))
                  : null,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    color: Color.fromARGB(255, 25, 29, 69), width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.white, width: 1.0),
              ),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
        ),
      ),
    );
  }
}
