import 'package:flutter/material.dart';

class NotificationButton extends StatefulWidget {
  @override
  _NotificationButtonState createState() => _NotificationButtonState();
}

class _NotificationButtonState extends State<NotificationButton> {
  List<Map<String, dynamic>> notifications = [];

  final int studentId = 1;
  final int groupId = 1;

  // Method to fetch notifications (API integration placeholder)
  Future<void> fetchNotifications() async {
    // Simulate API call
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      notifications = [
        {
          "ID": 1,
          "NotificationId": 1,
          "Title": "New Assignment Posted",
          "NotificationContent": "Check the new assignment in Math.",
          "CreationDate": "2024-12-01",
          "IsRead": false,
        },
        {
          "ID": 2,
          "NotificationId": 2,
          "Title": "Exam Schedule Updated",
          "NotificationContent":
              "The exam schedule for Physics has been updated.",
          "CreationDate": "2024-12-02",
          "IsRead": false,
        },
        {
          "ID": 2,
          "NotificationId": 2,
          "Title": "Exam Schedule Updated",
          "NotificationContent":
              "The exam schedule for Physics has been updated.",
          "CreationDate": "2024-12-02",
          "IsRead": true,
        },
        {
          "ID": 2,
          "NotificationId": 2,
          "Title": "Exam Schedule Updated",
          "NotificationContent":
              "The exam schedule for Physics has been updated.",
          "CreationDate": "2024-12-02",
          "IsRead": true,
        },
        {
          "ID": 2,
          "NotificationId": 2,
          "Title": "Exam Schedule Updated",
          "NotificationContent":
              "The exam schedule for Physics has been updated.",
          "CreationDate": "2024-12-02",
          "IsRead": true,
        },
      ];
    });
  }

  // Count unread notifications
  int get unreadCount {
    return notifications
        .where((notification) => notification['IsRead'] == false)
        .length;
  }

  @override
  void initState() {
    super.initState();
    fetchNotifications(); // Fetch notifications on load
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          icon: Icon(Icons.notifications),
          iconSize: 33,
          color: Colors.black,
          onPressed: () {
            // Navigate to notification details screen
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NotificationScreen(notifications)),
            );
          },
        ),
        if (unreadCount > 0)
          Positioned(
            right: 11,
            top: 11,
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 101, 163, 234),
                borderRadius: BorderRadius.circular(10),
              ),
              constraints: BoxConstraints(
                minWidth: 13,
                minHeight: 5,
              ),
              child: Text(
                unreadCount.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}

class NotificationScreen extends StatelessWidget {
  final List<Map<String, dynamic>> notifications;

  NotificationScreen(this.notifications);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.5, 1.4),
            colors: [
              Color(0xffF2F2F2),
              Color(0xff4B39EF),
            ],
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context); // Pop back to the previous screen
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 70.0),
                    child: Center(
                      child: Text(
                        "Notifications",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notification = notifications[index];
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Color(0xFFFFFFFF),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      title: Text(notification['Title']),
                      subtitle: Text(notification['NotificationContent']),
                      trailing: Icon(
                        notification['IsRead']
                            ? null
                            : Icons.circle_notifications_outlined,
                        color: notification['IsRead']
                            ? null
                            : Color.fromARGB(255, 113, 95, 187),
                      ),
                      onTap: () {
                        // Handle marking as read or viewing details
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
