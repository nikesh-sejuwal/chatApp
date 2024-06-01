import 'dart:convert';

import 'package:chatapp/pages/Chat_Page.dart';
import 'package:chatapp/resources/resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Check_Sender extends StatefulWidget {
  const Check_Sender({super.key});

  @override
  State<Check_Sender> createState() => _Check_SenderState();
}

GlobalKey<FormState> myForm = GlobalKey<FormState>();

class _Check_SenderState extends State<Check_Sender> {
  var isLoading = false;
  var myController = TextEditingController();

  void savePersonalInfo(int id, String name) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setInt('sender_id', id);
    await prefs.setString('sender_name', name);
    print('$name with $id is saved to local storage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'New User',
          style: TextStyle(color: sColor),
        )),
        backgroundColor: pColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: myForm,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Enter your Full Name',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10),
              SizedBox(
                // height: 60,
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFormField(
                  controller: myController,
                  validator: (value) {
                    if (value == null) return "Enter something";
                    if (value.isEmpty) return "Enter something";
                    if (!value.contains(" ")) return "Enter full name";
                    return null;
                  },
                  cursorColor: Colors.red,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      hintText: 'Enter name here...',
                      border: borderInfo,
                      enabledBorder: borderInfo,
                      focusedBorder: borderInfo,
                      focusColor: pColor),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 50),
                    decoration: BoxDecoration(
                        color: pColor, borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        onPressed: !isLoading
                            ? () async {
                                if (myForm.currentState!.validate()) {
                                  try {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    var response = await http.post(
                                        Uri.parse('https://$myIP/peoples/new'),
                                        headers: {
                                          'Content-Type': 'application/json'
                                        },
                                        body: jsonEncode(
                                            {'name': myController.text}));

                                    if (response.statusCode == 200) {
                                      print('${response.body}');
                                      var decoded = jsonDecode(response.body);
                                      savePersonalInfo(
                                          decoded['data']['person']['id'],
                                          decoded['data']['person']['name']);
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: ((context) => Chat_Page(
                                                  senderId: decoded['data']
                                                      ['person']['id'],
                                                  senderName: decoded['data']
                                                      ['person']['name']))));
                                    }
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Errorr')));
                                  } finally {
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                } else {
                                  print('Invalid Text');
                                }
                              }
                            : null,
                        child: !isLoading
                            ? Text(
                                'DONE',
                                style: TextStyle(
                                    color: sColor, fontWeight: FontWeight.w500),
                              )
                            : CupertinoActivityIndicator(color: sColor),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
