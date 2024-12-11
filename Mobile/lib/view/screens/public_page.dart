import 'package:elmanasa/helper/dataLevel.dart';
import 'package:elmanasa/view/screens/login.dart';
import 'package:elmanasa/view/widgets/level.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:elmanasa/model/levelModel.dart';
import 'package:elmanasa/model/CourseModel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PublicPage extends StatefulWidget {
  State<PublicPage> createState() => _PublicPageState();
}

class _PublicPageState extends State<PublicPage> {
  List<LevelModel> levels = [];
  List<CourseModel> courses = [];
  bool _loading = false;

  void initState() {
    super.initState();
    levels = getLevel();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffef7ff),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xfffef7ff),
        flexibleSpace: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25, top: 7),
                  child: Text(
                    "ELMANASA",
                    style: GoogleFonts.notoSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Color(0xFF232323)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 7),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (e) => LoginScreen()));
                    },
                    child: Container(
                      height: 35,
                      width: 100,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xff5971E0),
                            Color(0xff5971E0).withOpacity(0.5),
                            Color(0xff5971E0).withOpacity(0.6),
                          ],
                          stops: [0, 0.5, 1],
                        ),
                        borderRadius: BorderRadius.circular(34),
                      ),
                      child: Center(
                        child: Text(
                          "Sign In",
                          style: GoogleFonts.poppins(
                              fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: _loading
          ? Center(
              child: Container(
                child: SpinKitWave(
                  color: Colors.blue,
                  size: 50.0,
                ),
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Levels',
                        style: GoogleFonts.notoSans(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff232323)),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      width: double.infinity,
                      height: 200,
                      child: ListView.builder(
                        itemCount: levels.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, int index) {
                          return Level(
                            logo: levels[index].logo,
                            level: levels[index].level,
                          );
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Courses',
                        style: GoogleFonts.notoSans(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff232323)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                        child: ListView.builder(
                          itemCount: 2,
                          physics: ClampingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (context, int index) {
                            return Column(
                              children: [
                                Container(
                                  color: Color(0xfffef7ff),
                                  height:
                                      350, // Set a fixed height for each image container
                                  child: Image.asset(
                                    'assets/images/c1.jpg',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                SizedBox(
                                    height: 10), // Add space between the images
                                Container(
                                  color: Color(0xfffef7ff),
                                  height:
                                      350, // Set a fixed height for each image container
                                  child: Image.asset(
                                    'assets/images/c3.jpg',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                SizedBox(
                                    height: 10), // Add space between the images
                                Container(
                                  color: Color(0xfffef7ff),
                                  height:
                                      350, // Set a fixed height for each image container
                                  child: Image.asset(
                                    'assets/images/c2.jpg',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
