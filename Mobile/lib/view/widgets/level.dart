import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Level extends StatelessWidget {
  String? logo;
  int? level;
  //  Color ?color1;
  //  Color ?color2;

  Level({
    this.logo,
    this.level,
  });
  Widget build(BuildContext context) {
    return Container(
      height: 157,
      width: 128,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xff5971E0),
                Color(0xff5971E0).withOpacity(0.5),
                Color(0xff4A313E).withOpacity(0.2),
              ],
              stops: [
                0,
                0.5,
                1
              ]),
          borderRadius: BorderRadius.circular(16)),
      margin: EdgeInsets.only(
        right: 14,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${logo}",
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 20),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 14),
            child: Text(
              "Level ${level}",
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
