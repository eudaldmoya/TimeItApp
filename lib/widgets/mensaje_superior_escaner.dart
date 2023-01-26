import 'package:flutter/material.dart';

class MensajeSuperiorRecordatorioEscaneo extends StatelessWidget {
  const MensajeSuperiorRecordatorioEscaneo({
    Key? key,
    required this.atWork,
  }) : super(key: key);

  final bool atWork;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 32),
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            decoration: BoxDecoration(
                color: Color.fromARGB(50, 255, 255, 255)),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 8, left: 50, bottom: 8, right: 50),
              child: atWork
                  ? Text(
                      "Escanea el código para salir de trabajar",
                      style: TextStyle(color: Colors.white),
                    )
                  : Text(
                      "Escanea el código para entrar a trabajar",
                      style: TextStyle(color: Colors.white),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}