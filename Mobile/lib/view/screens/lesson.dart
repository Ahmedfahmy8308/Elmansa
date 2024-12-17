import 'package:elmanasa/view/screens/lesson_home.dart';
import 'package:flutter/material.dart';

class LessonPage extends StatefulWidget {
  @override
  _LessonPageState createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage>
    with SingleTickerProviderStateMixin {
      bool isFavorite = false; // State to track the favorite status
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Navigation Bar
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Text(
                      "Course Details",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                    IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        isFavorite = !isFavorite; // Toggle state
                      });
                    },
                  
                  ),
                ],
              ),
            ),

            // Media Player Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 106, 175, 255),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(Icons.fast_rewind, color: Colors.white),
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.white,
                            child: Icon(Icons.play_arrow,
                                color: Colors.deepOrangeAccent),
                          ),
                          Icon(Icons.fast_forward, color: Colors.white),
                        ],
                      ),
                    ),
                    Slider(
                      value: 0.5,
                      onChanged: (value) {},
                      activeColor: Colors.white,
                      inactiveColor: Colors.white.withOpacity(0.5),
                    ),
                  ],
                ),
              ),
            ),
            // Tab Bar for Videos and Materials
            TabBar(
              controller: _tabController,
              indicatorColor: Color.fromARGB(255, 106, 175, 255),
              labelColor: Color.fromARGB(255, 106, 175, 255),
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(text: "Videos"),
                Tab(text: "Materials"),
              ],
            ),

            // Tab View Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Videos Tab
                  ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          leading: Icon(
                            Icons.play_circle_fill,
                            color: Color.fromARGB(255, 106, 175, 255),
                          ),
                          title: Text("Lesson ${index + 1}"),
                          subtitle: Text("2 Min 43 Sec"),
                          //trailing: Icon(Icons.lock, color: Colors.grey),
                        ),
                      );
                    },
                  ),
                  // Materials Tab
                  ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          leading: Icon(
                            Icons.description,
                            color: Color.fromARGB(255, 106, 175, 255),
                          ),
                          title: Text("Material ${index + 1}"),
                          subtitle: Text("PDF Document"),
                          trailing: Icon(Icons.download, color: Colors.grey),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Purchase Button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 106, 175, 255),
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    "Purchase Only - \$28",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
