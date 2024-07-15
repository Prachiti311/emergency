import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserNoticeScreen extends StatefulWidget {
  @override
  _UserNoticeScreenState createState() => _UserNoticeScreenState();
}

class _UserNoticeScreenState extends State<UserNoticeScreen> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _deleteOldNotices(); // Call method to delete old notices on initialization
  }

  // Method to delete notices older than one day
  void _deleteOldNotices() async {
    QuerySnapshot snapshot = await _firestore.collection('notices').get();
    DateTime now = DateTime.now();

    for (var doc in snapshot.docs) {
      Timestamp timestamp = doc['timestamp'];
      DateTime noticeTime = timestamp.toDate();

      if (now.difference(noticeTime).inDays >= 1) {
        await _firestore.collection('notices').doc(doc.id).delete();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notices'),
        backgroundColor: Colors.white,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('notices').orderBy('timestamp', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No notices available'));
          }

          var notices = snapshot.data!.docs;

          return ListView.builder(
            itemCount: notices.length,
            itemBuilder: (context, index) {
              var notice = notices[index];
              var title = notice['title'];
              var content = notice['content'];
              var timestamp = notice['timestamp'] as Timestamp;
              var dateTime = timestamp.toDate();

              return Card(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(content),
                      SizedBox(height: 5),
                      Text(
                        dateTime.toString(),
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
