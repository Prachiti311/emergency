// import 'package:flutter/material.dart';
// import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:cloud_functions/cloud_functions.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class UserReportScreen extends StatefulWidget {
//   @override
//   _UserReportScreenState createState() => _UserReportScreenState();
// }
//
// class _UserReportScreenState extends State<UserReportScreen> {
//   String? selectedEmergency;
//   String? selectedLocation;
//   List<String> emergencyItems = [
//     'Fire',
//     'Water',
//     'Medical Emergency',
//     'Chemical Leakage',
//   ];
//   List<String> locationItems = [
//     'Building A',
//     'Boiler Level 1',
//     'Admin',
//     'Canteen',
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Report an Emergency',
//           style: TextStyle(color: Colors.grey[50]),
//         ),
//         backgroundColor: Color(0xFFBE1609),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 1),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 135.0),
//                 child: Image.asset(
//                   'assets/images/report.png',
//                   width: 100,
//                   height: 100,
//                   fit: BoxFit.contain,
//                   alignment: Alignment.centerRight,
//                 ),
//               ),
//               SizedBox(height: 65),
//               DropdownButtonFormField<String>(
//                 value: selectedEmergency,
//                 items: emergencyItems.map((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
//                   labelText: "Select Emergency",
//                 ),
//                 onChanged: (String? value) {
//                   setState(() {
//                     selectedEmergency = value;
//                   });
//                 },
//               ),
//               SizedBox(height: 30),
//               DropdownButtonFormField<String>(
//                 value: selectedLocation,
//                 items: locationItems.map((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
//                   labelText: "Select Location",
//                 ),
//                 onChanged: (String? value) {
//                   setState(() {
//                     selectedLocation = value;
//                   });
//                 },
//               ),
//               SizedBox(height: 40),
//               Text(
//                 'Note:',
//                 style: TextStyle(
//                   color: Colors.blue,
//                   fontSize: 17,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Text(
//                 'Please select an emergency type and location from the dropdown lists above. After selection, click on message or call button to report incident to owner .',
//                 textAlign: TextAlign.justify,
//                 style: TextStyle(fontSize: 15, color: Colors.black54),
//               ),
//               SizedBox(height: 130),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Container(
//                     width: 150,
//                     height: 50,
//                     child: ElevatedButton.icon(
//                       onPressed: () {
//                         print('Sending a message to owner');
//                         _sendMessageToOwner();
//                       },
//                       style: ElevatedButton.styleFrom(
//                         foregroundColor: Colors.blue,
//                       ),
//                       icon: Icon(Icons.message),
//                       label: Text('Message', style: TextStyle(fontSize: 16)),
//                     ),
//                   ),
//                   Container(
//                     width: 150,
//                     height: 50,
//                     child: ElevatedButton.icon(
//                       onPressed: _makePhoneCall,
//                       style: ElevatedButton.styleFrom(
//                         foregroundColor: Colors.green,
//                       ),
//                       icon: Icon(Icons.call),
//                       label: Text('Call', style: TextStyle(fontSize: 16)),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _sendMessageToOwner() async {
//     if (selectedEmergency != null && selectedLocation != null) {
//       String message = 'Emergency: $selectedEmergency, Location: $selectedLocation';
//
//       try {
//         // Get the current user's document from the users collection
//         DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).get();
//
//         // Check if the user document exists and is not empty
//         if (userSnapshot.exists && userSnapshot.data() != null) {
//           // Access the username field from the user document
//           String username = userSnapshot['username'];
//
//           // Send message to Firestore
//           await FirebaseFirestore.instance.collection('messages').add({
//             'message': message,
//             'sender': FirebaseAuth.instance.currentUser?.uid,
//             'username': username, // Add username to the message
//             'timestamp': DateTime.now(),
//           });
//           print('Message sent to owner');
//
//           // Store emergency data in Firestore
//           await FirebaseFirestore.instance.collection('emergencies').add({
//             'type': selectedEmergency,
//             'location': selectedLocation,
//             'reportedBy': FirebaseAuth.instance.currentUser?.uid,
//             'reportedByUsername': username, // Add username to the emergency data
//             'timestamp': DateTime.now(),
//           });
//           print('Emergency data stored in Firestore');
//
//           // Reset selected emergency and location
//           setState(() {
//             selectedEmergency = null;
//             selectedLocation = null;
//           });
//         } else {
//           print('User document does not exist or is empty');
//         }
//       } catch (e) {
//         print('Failed to send message: $e');
//       }
//     } else {
//       print('Please select emergency and location first');
//     }
//   }
//
//
//   void _makePhoneCall() async {
//     print('Making a phone call to the owner');
//     await FlutterPhoneDirectCaller.callNumber('7020357477');
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserReportScreen extends StatefulWidget {
  @override
  _UserReportScreenState createState() => _UserReportScreenState();
}

class _UserReportScreenState extends State<UserReportScreen> {
  String? selectedEmergency;
  String? selectedLocation;
  List<String> emergencyItems = [
    'Fire',
    'Water',
    'Medical Emergency',
    'Chemical Leakage',
  ];
  List<String> locationItems = [
    'Building A',
    'Boiler Level 1',
    'Admin',
    'Canteen',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Report an Emergency',
          style: TextStyle(color: Colors.grey[50]),
        ),
        backgroundColor: Color(0xFFBE1609),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 1),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 135.0),
                child: Image.asset(
                  'assets/images/report.png',
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                  alignment: Alignment.centerRight,
                ),
              ),
              SizedBox(height: 65),
              DropdownButtonFormField<String>(
                value: selectedEmergency,
                items: emergencyItems.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                  labelText: "Select Emergency",
                ),
                onChanged: (String? value) {
                  setState(() {
                    selectedEmergency = value;
                  });
                },
              ),
              SizedBox(height: 30),
              DropdownButtonFormField<String>(
                value: selectedLocation,
                items: locationItems.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                  labelText: "Select Location",
                ),
                onChanged: (String? value) {
                  setState(() {
                    selectedLocation = value;
                  });
                },
              ),
              SizedBox(height: 40),
              Text(
                'Note:',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Please select an emergency type and location from the dropdown lists above. After selection, click on message or call button to report incident to owner.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 15, color: Colors.black54),
              ),
              SizedBox(height: 130),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 150,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        print('Sending a message to owner');
                        _sendMessageToOwner();
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.blue,
                      ),
                      icon: Icon(Icons.message),
                      label: Text('Message', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: _makePhoneCall,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.green,
                      ),
                      icon: Icon(Icons.call),
                      label: Text('Call', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _sendMessageToOwner() async {
    if (selectedEmergency != null && selectedLocation != null) {
      String message = 'Emergency: $selectedEmergency, Location: $selectedLocation';

      try {
        // Get the current user's document from the users collection
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).get();

        // Debugging output
        print('User document data: ${userSnapshot.data()}');

        // Check if the user document exists and is not empty
        if (userSnapshot.exists && userSnapshot.data() != null) {
          // Access the username field from the user document
          String? username = userSnapshot['username'];

          // Additional check for username
          if (username == null) {
            print('Username is null in the user document');
            return;
          }

          // Ensure the 'emergencies' collection exists
          var emergencyCollection = FirebaseFirestore.instance.collection('emergencies');
          await emergencyCollection.doc().set({}, SetOptions(merge: true));

          // Send message to Firestore
          await FirebaseFirestore.instance.collection('messages').add({
            'message': message,
            'sender': FirebaseAuth.instance.currentUser?.uid,
            'username': username, // Add username to the message
            'timestamp': DateTime.now(),
          });
          print('Message sent to owner');

          // Store emergency data in Firestore
          await emergencyCollection.add({
            'type': selectedEmergency,
            'location': selectedLocation,
            'reportedBy': FirebaseAuth.instance.currentUser?.uid,
            'reportedByUsername': username, // Add username to the emergency data
            'timestamp': DateTime.now(),
          });
          print('Emergency data stored in Firestore');

          // Reset selected emergency and location
          setState(() {
            selectedEmergency = null;
            selectedLocation = null;
          });
        } else {
          print('User document does not exist or is empty');
        }
      } catch (e) {
        print('Failed to send message: $e');
      }
    } else {
      print('Please select emergency and location first');
    }
  }

  void _makePhoneCall() async {
    print('Making a phone call to the owner');
    await FlutterPhoneDirectCaller.callNumber('7020357477');
  }
}
