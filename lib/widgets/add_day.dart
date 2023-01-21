import 'package:flutter/material.dart';

class AddDay extends StatefulWidget {
  final Function onSend;
  AddDay({required this.onSend});

  @override
  State<AddDay> createState() => _AddDayState();
}

class _AddDayState extends State<AddDay> {
  final TextEditingController controllermen = TextEditingController();

  void dispose() {
    controllermen.dispose();
    super.dispose();
  }

  _send(int aciertos) {
    
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Material(
              //El material es el que crea el cuadro blanco de base
              elevation: 2, //crea una sombra debajo del texto
              shape:
                  StadiumBorder(), //coge la forme de ovulo, la sombra se adapta a este
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16,
                    right:
                        16), //Añadimos espacios a los lados para que el texto no esté tan pegado
                child: TextField(
                  controller: controllermen,
                  
                  decoration: InputDecoration(
                      border: InputBorder
                          .none), //Se va la ralla que tiene de serie el textfield
                ),
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Material(
            color: Theme.of(context)
                .primaryColor, //SE PONE EL COLOR DEL TEMA QUE HAY PREDEFINIDO EN LA APLICACION, POR ESO SALE EN AZUL
            shape: CircleBorder(),
            child: IconButton(
              icon: Icon(Icons.send),
              onPressed: (){},
              color : Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
