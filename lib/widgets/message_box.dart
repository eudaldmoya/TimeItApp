
import 'package:flutter/material.dart';

class MessageBox extends StatefulWidget {
  final Function onSend;
 MessageBox({required this.onSend});

  
  @override
  State<MessageBox> createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
 final TextEditingController controllermen = TextEditingController();



void dispose(){
  controllermen.dispose();
  super.dispose();
}

_send(String text){
  widget.onSend(text);
  controllermen.clear();
}


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller : controllermen,
              onSubmitted: _send),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () =>
             _send(controllermen.text),
          
          )
        ],
      ),
    );
  }
}
