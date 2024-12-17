import 'package:elmanasa/view/screens/public_page.dart';

import 'package:elmanasa/view/screens/login.dart';
import 'package:elmanasa/view/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(top: 100, left: 36, right: 36),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/wall.jpg'),
          Text(
            "Find Your Favorite Course",
            style: GoogleFonts.poppins(fontSize: 24, color: Color(0xFF232323)),
          ),
          Center(
              child: Padding(
            padding: const EdgeInsets.only(left: 12, top: 9),
            child: Text(
              "Every step you take on this platform is a step\n"
              "       towards your goals and your future.\n Remember, success is not about perfection,\n"
              "                  but about persistence",
              style:
                  GoogleFonts.poppins(color: Color(0xffBBBBBB), fontSize: 14),
            ),
          )),
          Padding(
            padding: const EdgeInsets.only(top: 70, bottom: 30),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (e) => PublicPage()));
              },
              child: Container(
                height: 56,
                width: 315,
                decoration: BoxDecoration(
                    color: Color(0xff5971e0),
                    borderRadius: BorderRadius.circular(34)),
                child: Center(
                  child: Text(
                    "Get Started",
                    style:
                        GoogleFonts.poppins(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
