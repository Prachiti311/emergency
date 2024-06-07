// notice_screen.dart
import 'package:flutter/material.dart';

class UserNoticeScreen extends StatefulWidget {
  @override
  _UserNoticeScreenState createState() => _UserNoticeScreenState();
}

class _UserNoticeScreenState extends State<UserNoticeScreen> {
  List<String> notices = []; // List to store notices

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notices'),
        backgroundColor: Color(0xFF5FA2F1),
      ),
      body: ListView.builder(
        itemCount: notices.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(notices[index]),
          );
        },
      ),
    );
  }

  // Method to add a new notice
  void addNotice(String notice) {
    setState(() {
      notices.add(notice);
    });
  }
}
