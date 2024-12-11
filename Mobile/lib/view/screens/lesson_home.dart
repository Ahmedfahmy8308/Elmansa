// import 'package:elmanasa/helper/notification.dart';
import 'package:elmanasa/helper/dashboard.dart';
import 'package:elmanasa/view/screens/Home.dart';
// import 'package:elmanasa/view/screens/lesson.dart';
// import 'package:elmanasa/view/screens/quiz.dart';

import 'package:flutter/material.dart';
import 'package:elmanasa/helper/utils.dart';

import 'package:google_fonts/google_fonts.dart';

class LessonHomeScreen extends StatefulWidget {
  @override
  _LessonHomeScreenState createState() => _LessonHomeScreenState();
}

class _LessonHomeScreenState extends State<LessonHomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  String? firstName;
  String? photoUrl;
  bool isLoading = true;

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchMockData();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
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

  void _toggleDashboard() {
    if (_animationController.isDismissed) {
      _animationController.forward(); // Open the side menu
    } else {
      _animationController.reverse(); // Close the side menu
    }
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
                GestureDetector(
                  // Detecting taps outside the dashboard to close the menu
                  onTap: () {
                    if (_animationController.isCompleted) {
                      _toggleDashboard(); // Only toggle the menu if it's open
                    }
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                              icon: Icon(Icons.arrow_back),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()),
                                );
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 8,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.menu),
                                    onPressed: _toggleDashboard,
                                  ),
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundImage:
                                        photoUrl != null && photoUrl!.isNotEmpty
                                            ? AssetImage(photoUrl!)
                                            : AssetImage('assets/images/me.jpg')
                                                as ImageProvider,
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 0.0, left: 15),
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
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                decoration: InputDecoration(
                                    hintText: 'Search here...',
                                    hintStyle: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 114, 114, 114),
                                        fontSize: 16),
                                    suffixIcon: Icon(
                                      Icons.search,
                                      color: const Color.fromARGB(
                                          255, 114, 114, 114),
                                    ),
                                    filled: true,
                                    fillColor: Color(0xffeaf3fd),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(26),
                                      borderSide: BorderSide.none,
                                    ),
                                    contentPadding: EdgeInsets.all(15)),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, bottom: 18, left: 18),
                          child: Text(
                            'Lessons ',
                            style: GoogleFonts.readexPro(
                              fontSize: 24,
                              color: Color(0xff14181B),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LessonHomeScreen()),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Lesson_item(
                              image_path: 'assets/images/c4.jpg',
                              lesson_num: 1,
                              Hduration: 2,
                              Mduartion: 30,
                              title: 'Differential Equations',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Lesson_item(
                            image_path: 'assets/images/c5.jpg',
                            lesson_num: 2,
                            Hduration: 1,
                            Mduartion: 40,
                            title: 'Integration & Deviation',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Lesson_item(
                            image_path: 'assets/images/c6.jpg',
                            lesson_num: 3,
                            Hduration: 2,
                            Mduartion: 30,
                            title: 'Riemann Surfaces',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Lesson_item(
                            image_path: 'assets/images/c7.jpg',
                            lesson_num: 4,
                            Hduration: 2,
                            Mduartion: 50,
                            title: 'Complex Analysis',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Lesson_item(
                            image_path: 'assets/images/c8.jpg',
                            lesson_num: 5,
                            Hduration: 3,
                            Mduartion: 30,
                            title: 'Metric Spaces',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Lesson_item(
                            image_path: 'assets/images/c9.jpg',
                            lesson_num: 6,
                            Hduration: 2,
                            Mduartion: 30,
                            title: 'Linear Algebra',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SlideTransition(
                  position: _slideAnimation,
                  child: Dashboard(
                    onClose:
                        _toggleDashboard, // Close menu when tapping outside
                  ),
                ),
              ],
            ),
    );
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
