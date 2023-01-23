import 'package:flutter/material.dart';

class MessageBox extends StatefulWidget {
  final Function onSend;
  MessageBox({required this.onSend});

  @override
  State<MessageBox> createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
  final TextEditingController controllermen = TextEditingController();

  void dispose() {
    controllermen.dispose();
    super.dispose();
  }

  _send(String text) {
    widget.onSend(text);
    controllermen.clear();
  }
  void formatNickname(){
    controllermen.text = controllermen.text.replaceAll(" ", "");
    print("aqui estoy");
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
                  onSubmitted: _send,
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
              onPressed: () {
                  formatNickname();

                if (controllermen.text.isNotEmpty) {
                  _send(controllermen.text);
                }
              },
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
