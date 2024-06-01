import 'dart:convert';

import 'package:chatapp/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Edit_Chat extends StatefulWidget {
  final String myId;
  final String myMessage;
  final Function myFun;
  Edit_Chat(
      {super.key,
      required this.myId,
      required this.myMessage,
      required this.myFun});

  @override
  State<Edit_Chat> createState() => _Edit_ChatState();
}

class _Edit_ChatState extends State<Edit_Chat> {
  var myController = TextEditingController();

  @override
  void initState() {
    myController.text = widget.myMessage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Edit Chat", style: TextStyle(color: pColor)),
      content: Container(
        height: 100,
        width: 200,
        child: Column(
          children: [
            SizedBox(
              height: 60,
              child: TextField(
                controller: myController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  hintText: "Edit message here",
                  border: borderInfo,
                  enabledBorder: borderInfo,
                  focusedBorder: borderInfo,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () async {
                      if (myController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Cannot be empty')));
                      } else {
                        await http.put(
                            Uri.parse('http://${myIP}/messages/${widget.myId}'),
                            headers: {"Content-Type": "application/json"},
                            body: jsonEncode({'message': myController.text}));
                        Navigator.of(context).pop();
                        print(
                            "${widget.myId} and my message is ${widget.myMessage}");
                        widget.myFun();
                      }
                    },
                    icon: Icon(
                      Icons.check,
                      color: Colors.green,
                    )),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.close,
                      color: Colors.red,
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
