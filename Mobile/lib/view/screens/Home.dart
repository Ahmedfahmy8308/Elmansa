// import 'package:elmanasa/helper/notification.dart';
import 'package:elmanasa/helper/dashboard.dart';
import 'package:elmanasa/view/screens/lesson_home.dart';
import 'package:elmanasa/view/screens/notification.dart';
import 'package:elmanasa/view/screens/quiz_home.dart';
// import 'package:elmanasa/view/screens/lesson.dart';
// import 'package:elmanasa/view/screens/quiz.dart';

import 'package:flutter/material.dart';
import 'package:elmanasa/helper/utils.dart';

import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  String? firstName;
  String? photoUrl;
  bool isLoading = true;
  List<String> courses = [
    'Math 101',
    'Science 101',
    'History 101',
    'Computer Science 101',
    'Biology 101',
    'Chemistry 101',
    'Literature 101',
  ];

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
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay

    // Mock data
    setState(() {
      firstName = "Malak";
      photoUrl = "assets/images/me.jpg"; // Replace with a placeholder image URL
      isLoading = false;
    });
  }

  void _filterCourses() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredCourses = courses
          .where((course) => course.toLowerCase().contains(query))
          .toList();
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
                                      padding: const EdgeInsets.only(top: 8),
                                      child: IconButton(
                                        icon: Icon(Icons.menu),
                                        onPressed: _toggleDashboard,
                                      ),
                                    ),
                                    Row(
                                      children: [NotificationButton(),
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
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Available Courses',
                              style: GoogleFonts.readexPro(
                                fontSize: 20,
                                color: Color(0xff14181B),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => QuizHomePage()),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xffeaf3fd),
                                borderRadius: BorderRadius.circular(60),
                              ),
                              height: 240,
                              width: 360,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 12.0),
                                      child: Text(
                                        "Mathematics",
                                        style: GoogleFonts.readexPro(
                                          fontSize: 20,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 12.0),
                                      child: Text(
                                        "Quizzes",
                                        style: GoogleFonts.readexPro(
                                          fontSize: 24,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LessonHomeScreen()),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xffeaf3fd),
                                borderRadius: BorderRadius.circular(60),
                              ),
                              height: 240,
                              width: 360,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 12.0),
                                      child: Text(
                                        "Mathematics",
                                        style: GoogleFonts.readexPro(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 12.0),
                                      child: Text(
                                        "Lessons",
                                        style: GoogleFonts.readexPro(
                                          fontSize: 24,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
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
