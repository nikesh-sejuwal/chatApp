import 'package:flutter/material.dart';

// GLOBAL
var pColor = Colors.pink;
var cColor = Colors.pink.shade400;
var sColor = Colors.white;
var myIP = 'soch-message.padxu.com';
// Chat_Page

var Icon1 =
    IconButton(onPressed: () {}, icon: Icon(Icons.videocam, color: sColor));
var Icon2 =
    IconButton(onPressed: () {}, icon: Icon(Icons.phone, color: sColor));
var Icon3 = Padding(
  padding: const EdgeInsets.only(right: 12.0),
  child:
      IconButton(onPressed: () {}, icon: Icon(Icons.more_vert, color: sColor)),
);
var picture1 =
    'https://images.pexels.com/photos/8294606/pexels-photo-8294606.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1';

var borderInfo = OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(color: Colors.pink.shade500, width: 1.5));

var icon4 = IconButton(
    onPressed: () {},
    icon: Icon(Icons.emoji_emotions, size: 25, color: pColor));
// Generate_Chat

var Decoration1 = BoxDecoration(
    color: pColor,
    borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(20),
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20)));

var Decoration2 = BoxDecoration(
    color: Colors.grey,
    borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20)));
