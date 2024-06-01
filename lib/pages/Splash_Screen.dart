import 'package:chatapp/pages/Chat_Page.dart';
import 'package:chatapp/pages/Check_Sender.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  Future<void> checkifUserExits() async {
    var prefs = await SharedPreferences.getInstance();
    int? savedId = prefs.getInt('sender_id');
    String? savedName = prefs.getString('sender_name');
    await Future.delayed(Duration(seconds: 2));
    if (savedId != null) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Chat_Page(
                senderId: savedId,
                senderName: savedName.toString(),
              )));
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Check_Sender()));
    }
  }

  @override
  void initState() {
    checkifUserExits();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Group Messaging App.',
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(color: Colors.black),
          ],
        ),
      ),
    );
  }
}
