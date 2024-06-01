import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../resources/resources.dart';

class Delete_Chat extends StatefulWidget {
  final String myId;
  final Function myFun;
  Delete_Chat({super.key, required this.myId, required this.myFun});

  @override
  State<Delete_Chat> createState() => _Delete_ChatState();
}

class _Delete_ChatState extends State<Delete_Chat> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Delete Chat',
        style: TextStyle(color: Colors.red),
      ),
      content: Container(
        width: 100,
        height: 90,
        child: Column(
          children: [
            Text(
              "Sure! You want to delete.",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () async {
                      await http.delete(
                          Uri.parse("http://${myIP}/messages/${widget.myId}"));
                      Navigator.of(context).pop();
                      widget.myFun();
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
                      color: pColor,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
