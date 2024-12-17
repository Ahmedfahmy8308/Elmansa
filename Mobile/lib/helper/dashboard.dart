//import 'package:elmanasa/view/screens/lesson.dart';
import 'package:elmanasa/view/screens/Home.dart';
import 'package:elmanasa/view/screens/assignement.dart';
import 'package:elmanasa/view/screens/lesson_home.dart';
import 'package:elmanasa/view/screens/login.dart';
import 'package:elmanasa/view/screens/notification.dart';
import 'package:elmanasa/view/screens/quiz_home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Dashboard extends StatelessWidget {
  final VoidCallback onClose;

  const Dashboard({Key? key, required this.onClose}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onClose();
      }, // Close the side menu when tapping outside
      child: Container(
        width:
            MediaQuery.of(context).size.width * 0.6, // Half of the screen width
        height: double.infinity,
        decoration: const BoxDecoration(
            // border: Border(
            //     right: BorderSide(
            //       width: 3,
            //       color: Color.fromARGB(255, 179, 168, 223),
            //     ),
            //     top: BorderSide(
            //       width: 3,
            //       color: Color.fromARGB(255, 179, 168, 223),
            //     )),
            // gradient: LinearGradient(
            //   begin: Alignment.topLeft,
            //   end: Alignment.bottomRight,
            //   colors: [
            //     Color(0xFFFFFFFF), // White
            //     Color.fromARGB(255, 179, 168, 223), // Light Purple
            //   ],
            // ),
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20))),

        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dashboard',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Menu_Items("Lessons", Icons.menu_book, () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LessonHomeScreen()));
            }),
            SizedBox(height: 15),
            Menu_Items("Assignments", Icons.assignment, () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FileUploadApp()));
            }),
            SizedBox(
              height: 15,
            ),
            Menu_Items("Quizzes", Icons.quiz, () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => QuizHomePage()));
            }),
            SizedBox(
              height: 15,
            ),
            Menu_Items("Notifications", Icons.notifications, () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotificationButton(),
                  ));
            }),
            SizedBox(
              height: 15,
            ),
            Menu_Items("Account", Icons.person, () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            }),
            SizedBox(
              height: 15,
            ),
            Menu_Items("Settings", Icons.settings, () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            }),
            SizedBox(
              height: 280,
            ),
            Menu_Items("Contact Us", Icons.help, () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            }),
            SizedBox(
              height: 15,
            ),
            Menu_Items("Log Out", Icons.logout, () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            }),
          ],
        ),
      ),
    );
  }
}

class Menu_Items extends StatelessWidget {
  @override
  String item_name;
  IconData icon;
  final VoidCallback onPressed;
  Menu_Items(this.item_name, this.icon, this.onPressed);
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(0xffeaf3fd),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Icon(icon),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                item_name,
                style: GoogleFonts.readexPro(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
