import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Attendance extends StatelessWidget {
  const Attendance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'File Upload UI',
      home: Scaffold(
        backgroundColor: Color(0xFFEAF5FF),
        body: const Center(
          child: Attendancetake(),
        ),
      ),
    );
  }
}

class Attendancetake extends StatelessWidget {
  const Attendancetake({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 350,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(
            'Scan To Take Your Attendance',
            style: GoogleFonts.readexPro(
              fontSize: 19,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          // Add Files Button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              //height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/qr.jpg',
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          )
        ]));
  }
}
