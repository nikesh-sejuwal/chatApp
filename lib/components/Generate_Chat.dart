import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../resources/resources.dart';
import 'Delete_Chat.dart';
import 'Edit_Chat.dart';

class GenerateChat extends StatefulWidget {
  final int myId;
  final String myName;

  GenerateChat({super.key, required this.myId, required this.myName});

  @override
  State<GenerateChat> createState() => _GenerateChatState();
}

class _GenerateChatState extends State<GenerateChat> {
  // Function to check if the message was sent by the current user
  bool wasSentByMe(Map<String, dynamic> message) {
    return message['sentBy']['name'] == widget.myName;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: http.get(Uri.parse('http://${myIP}/messages')),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          var response = snapshot.data!.body;
          // print("my name ${widget.myName}");
          List decodedInfo = (jsonDecode(response)['data']);
          return Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: decodedInfo
                  .map((e) => Row(
                        mainAxisAlignment: wasSentByMe(e)
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  wasSentByMe(e)
                                      ? ''
                                      : '${e['sentBy']['name']}',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                  // textAlign: TextAlign.left,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  // color: Colors.red,
                                  child: Align(
                                    alignment: wasSentByMe(e)
                                        ? Alignment.bottomRight
                                        : Alignment.bottomLeft,
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 2.5),
                                      decoration: wasSentByMe(e)
                                          ? Decoration1
                                          : Decoration2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: InkWell(
                                          onLongPress: () {
                                            showDialog(
                                              context: context,
                                              builder: (builder) => Delete_Chat(
                                                myId: '${e['id']}',
                                                myFun: () {
                                                  setState(() {});
                                                },
                                              ),
                                            );
                                          },
                                          onDoubleTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (builder) => Edit_Chat(
                                                myId: '${e['id']}',
                                                myMessage: '${e['message']}',
                                                myFun: () {
                                                  setState(() {});
                                                },
                                              ),
                                            );
                                          },
                                          child: Column(
                                            children: [
                                              Text(
                                                '${e['message']}',
                                                style: TextStyle(
                                                    color: sColor,
                                                    fontSize: 16),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ))
                  .toList(),
            ),
          );
        } else {
          return Text(snapshot.error.toString());
        }
      }),
    );
  }
}
