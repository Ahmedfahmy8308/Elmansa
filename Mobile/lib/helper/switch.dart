import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SwitchPage(),
    );
  }
}

class SwitchPage extends StatefulWidget {
  @override
  _SwitchState createState() => _SwitchState();
}

class _SwitchState extends State<SwitchPage>
    with SingleTickerProviderStateMixin {
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.orange,
          tabs: [
            Tab(text: 'Videos'),
            Tab(text: 'Materials'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Videos Tab
          ListView(
            padding: EdgeInsets.all(16),
            children: [
              ListTile(
                leading: Icon(Icons.play_circle_fill, color: Colors.orange),
                title: Text('Introduction'),
                subtitle: Text('2 Min 43 Sec'),
              ),
              ListTile(
                leading: Icon(Icons.play_circle_fill, color: Colors.orange),
                title: Text('How to Start Design?'),
                subtitle: Text('2 Min 43 Sec'),
              ),
              ListTile(
                leading: Icon(Icons.play_circle_fill, color: Colors.orange),
                title: Text('What is UI/UX Design?'),
                subtitle: Text('2 Min 43 Sec'),
              ),
            ],
          ),

          // Materials Tab
          ListView(
            padding: EdgeInsets.all(16),
            children: [
              ListTile(
                leading: Icon(Icons.picture_as_pdf, color: Colors.red),
                title: Text('UI Design Basics.pdf'),
                subtitle: Text('1.2 MB'),
              ),
              ListTile(
                leading: Icon(Icons.picture_as_pdf, color: Colors.red),
                title: Text('UX Design Guide.pdf'),
                subtitle: Text('850 KB'),
              ),
              ListTile(
                leading: Icon(Icons.picture_as_pdf, color: Colors.red),
                title: Text('Advanced Prototyping.pdf'),
                subtitle: Text('2.4 MB'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}