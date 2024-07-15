//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class DeclareEmergencyScreen extends StatelessWidget {
//   final Map<String, dynamic> emergencyData;
//
//   const DeclareEmergencyScreen({Key? key, required this.emergencyData}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Declare Emergency'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//
//             SizedBox(height: 16),
//             Text(
//               'Emergency Type: ${emergencyData['type']}',
//               style: TextStyle(fontSize: 18),
//             ),
//             SizedBox(height: 8),
//             Text(
//               'Location: ${emergencyData['location']}',
//               style: TextStyle(fontSize: 18),
//             ),
//             SizedBox(height: 8),
//             Text(
//               'Reported by: ${emergencyData['reportedByUsername']}',
//               style: TextStyle(fontSize: 18),
//             ),
//             // Add more details or actions related to declaring an emergency here
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeclareEmergencyScreen extends StatelessWidget {
  final Map<String, dynamic> emergencyData;

  const DeclareEmergencyScreen({Key? key, required this.emergencyData}) : super(key: key);

  Future<void> sendEmergencyNotification(String message) async {
    // This is a placeholder function where you'll integrate your notification service
    // For Firebase Cloud Messaging (FCM), you would use the FCM API to send notifications
    // You can use the firebase_messaging package to integrate FCM
    // Here, you would send the message to all users
    print('Sending notification: $message');
    // TODO: Implement FCM notification sending logic here
  }

  @override
  Widget build(BuildContext context) {
    String emergencyMessage = 'Emergency Alert!\n\n'
        'Type: ${emergencyData['type']}\n'
        'Location: ${emergencyData['location']}\n'
        'Reported by: ${emergencyData['reportedByUsername']}';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Declare Emergency',
          style: TextStyle(color: Colors.red),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.red),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Icon(
                Icons.warning,
                color: Colors.red,
                size: 100,
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: Text(
                'Emergency Alert',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),
            // SizedBox(height: 16),
            // Text(
            //   'Type:',
            //   style: TextStyle(
            //     fontSize: 18,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // Text(
            //   emergencyData['type'],
            //   style: TextStyle(fontSize: 18),
            // ),
            // SizedBox(height: 8),
            // Text(
            //   'Location:',
            //   style: TextStyle(
            //     fontSize: 18,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // Text(
            //   emergencyData['location'],
            //   style: TextStyle(fontSize: 18),
            // ),
            // SizedBox(height: 8),
            // Text(
            //   'Reported by:',
            //   style: TextStyle(
            //     fontSize: 18,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // Text(
            //   emergencyData['reportedByUsername'],
            //   style: TextStyle(fontSize: 18),
            // ),
            SizedBox(height: 16),
            Divider(color: Colors.black),
            SizedBox(height: 16),
            Text(
              'Notification Preview:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                emergencyMessage,
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton.icon(
                icon: Icon(Icons.notification_important, color: Colors.white),
                label: Text('Declare Emergency',style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                onPressed: () {
                  // Send notification to all users
                  sendEmergencyNotification(emergencyMessage);

                  // Show confirmation message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Emergency declared and notification sent!')),
                  );

                  // Navigate back or to another screen if necessary
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
