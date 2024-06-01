import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/Generate_Chat.dart';
import '../resources/resources.dart';
import 'package:http/http.dart' as http;

// import 'Check_Sender.dart';

// import 'Check_Sender.dart';

class Chat_Page extends StatefulWidget {
  final int senderId;
  final String senderName;
  Chat_Page({super.key, required this.senderId, required this.senderName});

  @override
  State<Chat_Page> createState() => _Chat_PageState();
}

class _Chat_PageState extends State<Chat_Page> {
  bool isLoading = false;
  var myController = TextEditingController();

  Future<void> fetchMessage() async {
    await Future.delayed(Duration(seconds: 2), () async {
      setState(() {});
      await fetchMessage();
    });
  }

  @override
  void initState() {
    fetchMessage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: sColor),
            onPressed: () {
              // Navigator.of(context).push(
              //     MaterialPageRoute(builder: (((context) => Check_Sender()))));
            }),
        leadingWidth: 25,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipOval(
              child: Image.network(picture1,
                  width: 50, height: 50, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2.0),
                    child: Text(
                      'Testing Bot',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: sColor),
                    ),
                  ),
                  Text(
                    'seen at 9:30AM',
                    style: TextStyle(fontSize: 12, color: sColor),
                  ),
                ],
              ),
            )
          ],
        ),
        actions: [Icon1, Icon2, Icon3],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                children: [
                  GenerateChat(
                    myId: widget.senderId,
                    myName: widget.senderName,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      // height: 60,
                      width: MediaQuery.of(context).size.width * 0.65,
                      child: TextField(
                        controller: myController,
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            hintText: 'Type message here...',
                            border: borderInfo,
                            focusedBorder: borderInfo,
                            enabledBorder: borderInfo),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    icon4,
                    IconButton(
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          var response = await http.post(
                            Uri.parse('http://${myIP}/messages'),
                            headers: {"Content-Type": "application/json"},
                            body: jsonEncode({
                              'message': myController.text,
                              'sentBy': widget.senderId,
                            }),
                          );
                          // print("${myController.text}");

                          setState(() {
                            // isLoading = false;
                            myController.clear();
                          });
                          var decodedInfo = jsonDecode(response.body);

                          if (decodedInfo['status'] != 'success') {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(decodedInfo['data']['message'])));
                          }
                          setState(() {
                            isLoading = false;
                          });
                        },
                        icon: !isLoading
                            ? Icon(
                                Icons.send,
                                color: pColor,
                                size: 25,
                              )
                            : CupertinoActivityIndicator())
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
