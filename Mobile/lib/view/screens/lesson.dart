// import 'package:elmanasa/helper/notification.dart';
import 'package:elmanasa/helper/dashboard.dart';
import 'package:elmanasa/helper/video.dart';
import 'package:elmanasa/view/screens/Home.dart';
import 'package:elmanasa/view/screens/lesson_home.dart';
import 'package:video_player/video_player.dart';
// import 'package:elmanasa/view/screens/lesson.dart';
// import 'package:elmanasa/view/screens/quiz.dart';

import 'package:flutter/material.dart';
import 'package:elmanasa/helper/utils.dart';

import 'package:google_fonts/google_fonts.dart';

class LessonScreen extends StatefulWidget {
  @override
  _LessonScreenState createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen>
    with TickerProviderStateMixin {
  bool isLoading = false;
  bool isFavorite = false;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : Stack(children: [
                SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Icon(Icons.arrow_back),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LessonHomeScreen()),
                                );
                              },
                            ),
                            Text(
                              'Lessons ',
                              style: GoogleFonts.readexPro(
                                fontSize: 24,
                                color: Color(0xff14181B),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  border: Border.all(
                                    width: 1,
                                    color: const Color.fromARGB(
                                        255, 205, 205, 205),
                                  )),
                              child: IconButton(
                                icon: Icon(
                                  isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: const Color.fromARGB(149, 95, 63, 177),
                                  size: 30,
                                ),
                                onPressed: toggleFavorite,
                              ),
                            ),
                          ],
                        ),
                      ),
                      VideoPlayerScreen(),
                    ]))
              ]));
  }
}

class Lesson_item extends StatelessWidget {
  int Hduration;
  int Mduartion;
  String image_path;
  int lesson_num;
  String title;
  Lesson_item(
      {required this.image_path,
      required this.lesson_num,
      required this.Hduration,
      required this.Mduartion,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: 80,
                height: 80,
                child: Image.asset(
                  'assets/images/c4.jpg', // Replace with your image asset
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Icon(
                        Icons.assignment,
                        size: 20,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Lesson ${lesson_num}',
                        style: GoogleFonts.readexPro(
                          fontSize: 14,
                          color: const Color.fromARGB(255, 114, 114, 114),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: Container(
                        height: 18,
                        width: 19,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 31, 31, 31),
                            shape: BoxShape.circle),
                        child: Icon(
                          Icons.play_arrow,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        '${Hduration}Hr ${Mduartion}Min',
                        style: GoogleFonts.readexPro(
                          fontSize: 14,
                          color: const Color.fromARGB(255, 114, 114, 114),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, top: 8),
                  child: Text(
                    title,
                    style: GoogleFonts.readexPro(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        Center(
          child: Container(
            margin: EdgeInsets.all(
              9,
            ),
            height: 1,
            width: MediaQuery.of(context).size.width * 0.78,
            color: const Color.fromARGB(255, 204, 204, 204),
          ),
        ),
      ],
    );
  }
}
