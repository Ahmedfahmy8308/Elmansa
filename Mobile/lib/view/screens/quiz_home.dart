// import 'package:elmanasa/helper/notification.dart';
import 'package:elmanasa/helper/dashboard.dart';
import 'package:elmanasa/view/screens/Home.dart';
import 'package:elmanasa/view/screens/lesson_home.dart';
import 'package:elmanasa/view/screens/quiz.dart';
// import 'package:elmanasa/view/screens/lesson.dart';
// import 'package:elmanasa/view/screens/quiz.dart';

import 'package:flutter/material.dart';
import 'package:elmanasa/helper/utils.dart';

import 'package:google_fonts/google_fonts.dart';

class QuizHomePage extends StatefulWidget {
  @override
  _QuizHomePageState createState() => _QuizHomePageState();
}

class _QuizHomePageState extends State<QuizHomePage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  String? firstName;
  String? photoUrl;
  bool isLoading = true;

  List<String> filteredCourses = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchMockData();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 30),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(-1.0, 0.0), // Initially off-screen
      end: Offset(0.0, 0.0), // Slide in to take half the screen width
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    )); // Use mock data instead of calling an API
  }

  Future<void> fetchMockData() async {
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay

    // Mock data
    setState(() {
      firstName = "Malak";
      photoUrl = "assets/images/me.jpg"; // Replace with a placeholder image URL
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 7),
                                    child: CircleAvatar(
                                      radius: 25,
                                      backgroundImage: photoUrl != null &&
                                              photoUrl!.isNotEmpty
                                          ? AssetImage(photoUrl!)
                                          : AssetImage('assets/images/me.jpg')
                                              as ImageProvider,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15.0, left: 15),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      firstName != null
                                          ? 'Hello, $firstName!'
                                          : 'Hello!',
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Have a nice day!',
                                      style: GoogleFonts.readexPro(
                                        fontSize: 14,
                                        color: const Color.fromARGB(
                                            255, 114, 114, 114),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 30.0, left: 20),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Quiz',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 15.0, left: 15),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Description',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),

                            const SizedBox(height: 10),
                            Row(
                              children: const [
                                Icon(Icons.bookmark,
                                    color: Colors.black45, size: 18),
                                SizedBox(width: 8),
                                Text(
                                  "Lesson: Mathematics & Statistics",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black87),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: const [
                                Icon(Icons.timer,
                                    color: Colors.black45, size: 18),
                                SizedBox(width: 8),
                                Text(
                                  "Duration: 60 Minutes",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black87),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),

                            // Start Attempt Button
                            SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Quiz()),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Colors.indigo, // Button color
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: const Text("Start Attempt",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ))))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
