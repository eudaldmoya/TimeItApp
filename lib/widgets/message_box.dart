import 'package:flutter/material.dart';

class MessageBox extends StatefulWidget {
  final Function onSend;
  MessageBox({required this.onSend});

  @override
  State<MessageBox> createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
  final TextEditingController controllermen = TextEditingController();
  bool puedeenviar = false;
  void dispose() {
    controllermen.dispose();
    super.dispose();
  }

  _send(String text) {
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
            child: Material(
              elevation: 2,
              shape: StadiumBorder(),
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: TextField(
                  onChanged: ((value) {
                    if (!controllermen.text.trim().isEmpty) {
                      setState(() {
                        puedeenviar = true;
                      });
                    } else {
                      setState(() {
                        puedeenviar = false;
                      });
                    }
                  }),
                  controller: controllermen,
                  onSubmitted:(value) {
                    if (!controllermen.text.trim().isEmpty) {
                        _send(controllermen.text);
                        puedeenviar = false;
                      }
                  },
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Material(
            color: Theme.of(context).primaryColor,
            shape: CircleBorder(),
            child: IconButton(
              icon: Icon(Icons.send),
              onPressed: puedeenviar
                  ? () {
                      if (!controllermen.text.trim().isEmpty) {
                        _send(controllermen.text);
                        puedeenviar = false;
                      }
                    }
                  : null,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
