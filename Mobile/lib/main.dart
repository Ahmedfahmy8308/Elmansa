import 'package:elmanasa/helper/switch.dart';
import 'package:elmanasa/view/screens/Home.dart';
import 'package:elmanasa/view/screens/assignement.dart';
import 'package:elmanasa/view/screens/attendance.dart';
import 'package:elmanasa/view/screens/lesson.dart';
import 'package:elmanasa/view/screens/lesson_home.dart';
import 'package:elmanasa/view/screens/quiz.dart';
import 'package:elmanasa/view/screens/quiz_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:elmanasa/view/screens/welcomeScreen.dart';
import 'package:elmanasa/view/screens/login.dart';
import 'package:elmanasa/view/screens/register.dart';
import 'package:elmanasa/view/screens/Home.dart';

import 'package:elmanasa/view/screens/public_page.dart';

void main() {
  //debugPaintSizeEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "ELMANASA",
      
      home: PublicPage(),
    );
  }
}
