//
// import 'package:flutter/material.dart';
// import 'package:hello/userlogin.dart';
// import 'package:hello/userreportscreen.dart';
// import 'package:hello/usernoticescreen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
//
// class UserInfoScreen extends StatefulWidget {
//   const UserInfoScreen({Key? key}) : super(key: key);
//
//   @override
//   _UserInfoScreenState createState() => _UserInfoScreenState();
// }
//
// class _UserInfoScreenState extends State<UserInfoScreen> {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//
//   @override
//   void initState() {
//     super.initState();
//
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Details about Officers'),
//         backgroundColor: const Color(0xFF5FA2F1),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   gradient: const LinearGradient(
//                     colors: [Color(0xFF1A8DE1), Color(0xFFAACCEE)],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   border: Border.all(color: Colors.black),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: const [
//                     Text(
//                       'Head Incharges:',
//                       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
//                     ),
//                     SizedBox(height: 10),
//                     Text('Name: John Doe', style: TextStyle(color: Colors.white)),
//                     Text('Department: .........', style: TextStyle(color: Colors.white)),
//                     SizedBox(height: 10),
//                     Text('Name: John Doe', style: TextStyle(color: Colors.white)),
//                     Text('Department: .........', style: TextStyle(color: Colors.white)),
//                     SizedBox(height: 10),
//                     Text('Name: John Doe', style: TextStyle(color: Colors.white)),
//                     Text('Department: .........', style: TextStyle(color: Colors.white)),
//                     SizedBox(height: 10),
//                     Text('Name: John Doe', style: TextStyle(color: Colors.white)),
//                     Text('Department: .........', style: TextStyle(color: Colors.white)),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 15),
//               Container(
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   gradient: const LinearGradient(
//                     colors: [Color(0xFF1A8DE1), Color(0xFFAACCEE)],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   border: Border.all(color: Colors.black),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: const [
//                     Text(
//                       'Shift Incharges:',
//                       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
//                     ),
//                     SizedBox(height: 10),
//                     Text('Name: Jane Doe', style: TextStyle(color: Colors.white)),
//                     Text('ShiftTiming:.....', style: TextStyle(color: Colors.white)),
//                     SizedBox(height: 10),
//                     Text('Name: Jane Doe', style: TextStyle(color: Colors.white)),
//                     Text('ShiftTiming:.....', style: TextStyle(color: Colors.white)),
//                     SizedBox(height: 10),
//                     Text('Name: Jane Doe', style: TextStyle(color: Colors.white)),
//                     Text('ShiftTiming:.....', style: TextStyle(color: Colors.white)),
//                     SizedBox(height: 10),
//                     Text('Name: Jane Doe', style: TextStyle(color: Colors.white)),
//                     Text('ShiftTiming:.....', style: TextStyle(color: Colors.white)),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: Colors.grey[400],
//         selectedItemColor: Colors.red, // Set the color for selected items
//         unselectedItemColor: Colors.black, // Set the color for unselected items
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.assignment),
//             label: 'Reports',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.notifications),
//             label: 'Alerts',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.note),
//             label: 'Notices',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.exit_to_app),
//             label: 'Sign Out',
//           ),
//         ],
//         onTap: (index) {
//           switch (index) {
//             case 0:
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => UserReportScreen()),
//               );
//               break;
//             case 1:
//             // Navigate to Alerts Page
//               break;
//             case 2:
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => UserNoticeScreen()),
//               );
//               break;
//             case 3:
//               FirebaseAuth.instance.signOut(); // Logout the user
//               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UserLogin()));
//               break;
//           }
//         },
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:hello/userlogin.dart';
import 'package:hello/userreportscreen.dart';
import 'package:hello/usernoticescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({Key? key, required User user}) : super(key: key);

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    _initializeFirebaseMessaging();
  }

  void _initializeFirebaseMessaging() async {
    // Request permissions if necessary
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else {
      print('User declined or has not accepted permission');
    }

    // Get the device token
    String? token = await _firebaseMessaging.getToken();
    print("Firebase Messaging Token: $token");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details about Officers'),
        backgroundColor: const Color(0xFF5FA2F1),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoCard(
                title: 'Head Incharges:',
                data: [
                  'Name: John Doe',
                  'Department: .........',
                  'Name: John Doe',
                  'Department: .........',
                  'Name: John Doe',
                  'Department: .........',
                  'Name: John Doe',
                  'Department: .........',
                ],
              ),
              const SizedBox(height: 15),
              _buildInfoCard(
                title: 'Shift Incharges:',
                data: [
                  'Name: Jane Doe',
                  'ShiftTiming:.....',
                  'Name: Jane Doe',
                  'ShiftTiming:.....',
                  'Name: Jane Doe',
                  'ShiftTiming:.....',
                  'Name: Jane Doe',
                  'ShiftTiming:.....',
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[400],
        selectedItemColor: Colors.red, // Set the color for selected items
        unselectedItemColor: Colors.black, // Set the color for unselected items
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Reports',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Alerts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note),
            label: 'Notices',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.exit_to_app),
            label: 'Sign Out',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserReportScreen()),
              );
              break;
            case 1:
            // Navigate to Alerts Page
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserNoticeScreen()),
              );
              break;
            case 3:
              FirebaseAuth.instance.signOut(); // Logout the user
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UserLogin()));
              break;
          }
        },
      ),
    );
  }

  Widget _buildInfoCard({required String title, required List<String> data}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1A8DE1), Color(0xFFAACCEE)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 10),
          ...data.map((info) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(info, style: TextStyle(color: Colors.white)),
          )).toList(),
        ],
      ),
    );
  }
}
