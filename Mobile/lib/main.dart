import 'package:elmanasa/view/screens/Home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:elmanasa/view/screens/welcomeScreen.dart';
import 'package:elmanasa/view/screens/login.dart';
import 'package:elmanasa/view/screens/register.dart';
import 'package:elmanasa/view/screens/Home.dart';

import 'package:elmanasa/view/screens/public_page.dart';






main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "ELMANASA",
      home:HomeScreen(),
    );
  }
}

