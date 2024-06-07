// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart'; // Import Firebase Messaging
// import 'package:hello/ownerlogin.dart';
// import 'ongoingemergenciesscreen.dart';
// import 'package:http/http.dart' as http;
//
//
//
//
//
// class OwnerManagementScreen extends StatefulWidget {
//   final String? username;
//   final bool presence;
//
//   const OwnerManagementScreen({Key? key, required this.presence, this.username}) : super(key: key);
//
//   @override
//
//   _OwnerManagementScreenState createState() => _OwnerManagementScreenState();
// }
//
// class _OwnerManagementScreenState extends State<OwnerManagementScreen> {
//   late FirebaseFirestore _firestore; // Firestore instance
//   late CollectionReference _ownersCollection; // Firestore collection reference
//   late Stream<QuerySnapshot> _ownersStream; // Stream to listen for changes in owners
//   late FirebaseMessaging _firebaseMessaging;
//   final http.Client client = http.Client(); // Initialize http.Client here
//
//
//   void getFCMToken() async {
//     String? fcmToken = await FirebaseMessaging.instance.getToken();
//     print('FCM Token: $fcmToken');
//
//     if (fcmToken != null) {
//       // Store the FCM token in Firestore
//       storeTokenInFirestore(fcmToken);
//     }
//   }
//
//   void storeTokenInFirestore(String fcmToken) async {
//     final currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser != null) {
//       try {
//         await FirebaseFirestore.instance
//             .collection('users') // Change to your collection name
//             .doc(currentUser.uid)
//             .update({'fcmToken': fcmToken});
//         print('FCM Token updated in Firestore successfully.');
//       } catch (e) {
//         print('Error updating FCM Token: $e');
//       }
//     }
//   }
//
//
//   @override
//
//   void initState() {
//     super.initState();
//     getFCMToken();
//
//
// // Call getFCMToken when the widget is initialize
//     _firestore = FirebaseFirestore.instance;
//     _ownersCollection = _firestore.collection('owners');
//     _ownersStream = _ownersCollection.snapshots(); // Listen for changes in owners collection
//
//     // Initialize Firebase Messaging
//     _firebaseMessaging = FirebaseMessaging.instance;
//
//     // Request permission for receiving notifications (iOS only)
//     _firebaseMessaging.requestPermission();
//
//     // Configure Firebase Messaging
//     _configureFirebaseMessaging();
//
//     // Listen for new emergencies
//     _listenForEmergencies();
//   }
//
//   void _configureFirebaseMessaging() {
//     // Handle incoming messages when the app is in the foreground
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print("Received foreground message: ${message.notification!.title}");
//       // Handle the received message as needed
//     });
//
//     // Handle notification when the app is in the background or terminated
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print("Opened app from notification: ${message.notification!.title}");
//       // Handle the opened message as needed
//     });
//   }
//
//   void _listenForEmergencies() {
//     _firestore.collection('emergencies').snapshots().listen((QuerySnapshot snapshot) {
//       // Check for new emergencies
//       snapshot.docChanges.forEach((change) {
//         if (change.type == DocumentChangeType.added || change.type == DocumentChangeType.modified) {
//           // A new emergency has been added or updated
//           String location = change.doc['location'];
//           String severity = change.doc['type'];
//
//           // Construct notification message
//           String notificationMessage = "Emergency occurred in $location of $severity";
//
//           // Retrieve owner's FCM token
//           String ownerFCMToken = 'eRS02wC6S3iXRNB6OYjC4M:APA91bGs6ELOERNjAM2inqJMdrPUTZyr_FIIvM6hr5VN1mRBWU8cFBc9lM6mSAdueqC3MvGvMsYlulwrbkIOEa9AKmBeYwnTdLKIH-lmGocPmD-WecxMTK_gYxtLJgS1XHAzsIs1a2NQ'; // Fetch owner's FCM token from Firestore
//
//           // Send notification to owner
//           _sendEmergencyNotification(notificationMessage, ownerFCMToken);
//         }
//       });
//     });
//   }
//   Future<void> _sendEmergencyNotification(String location, String severity) async {
//     // Fetch all FCM tokens of users (replace with your logic)
//     final List<String> userFcmTokens = await _getUserFcmTokens();
//
//     // Loop through each user's FCM token
//     for (final fcmToken in userFcmTokens) {
//       try {
//         // Define the FCM endpoint
//         final url = Uri.parse('https://fcm.googleapis.com/fcm/send');
//
//         // Define the request headers
//         final headers = {
//           'Content-Type': 'application/json',
//           'Authorization': 'key=AAAAgV9NMd8:APA91bGm5NIiHoRRySxr7jpLibo7-lxjaTyggg4a9DoYd7EMQFqNA6fg7QhcpwoGN6RTWvGWaYwCxBbJKCuGgplPmSJ--pLLCdAa_2jJt6_N0KS_-9sUg29u3bDDDQjCL7x9VDuog0Fi', // Replace with your server key
//         };
//
//         // Define the notification payload (customize based on your needs)
//         final body = {
//           'notification': {
//             'title': 'Emergency Alert!',
//             'body': 'An emergency of severity "$severity" has occurred in $location.',
//             // Consider adding sound and other notification options
//           },
//           'to': fcmToken,
//         };
//
//         // Send the HTTP request
//         final response = await http.post(url, headers: headers, body: json.encode(body));
//
//         // Check the response status
//         if (response.statusCode == 200) {
//           print('Notification sent successfully to FCM token: $fcmToken');
//         } else {
//           print('Error sending notification: Status code ${response.statusCode}');
//         }
//       } catch (e) {
//         print('Error sending notification: $e');
//       }
//     }
//   }
//
// // Replace this with your logic to retrieve FCM tokens of all users
//   Future<List<String>> _getUserFcmTokens() async {
//     // Replace with your implementation to fetch tokens from a database or user profiles
//     return ['PLACEHOLDER_FCM_TOKEN_1', 'PLACEHOLDER_FCM_TOKEN_2']; // Replace with actual tokens
//   }
//
//
//
//   void _updatePresence(bool isPresent) async {
//     final currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser != null) {
//       final documentSnapshot = await _ownersCollection.doc(currentUser.uid).get();
//       if (documentSnapshot.exists) {
//         // If the document exists, update the presence field
//         await _ownersCollection.doc(currentUser.uid).update({'presence': isPresent});
//       } else {
//         // If the document does not exist, create a new document with the presence field
//         await _ownersCollection.doc(currentUser.uid).set({'presence': isPresent});
//       }
//     }
//   }
//   @override
//   void dispose() {
//
//     super.dispose();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Onboard Officers'),
//       ),
//       drawer: OwnerDrawer(username: widget.username),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: _ownersStream,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             List<QueryDocumentSnapshot> owners = snapshot.data!.docs;
//
//             return Column(
//               children: [
//                 // Bar for owner to update as absent or present
//                 Container(
//                   height: 50,
//                   color: Colors.green, // Use colors based on your design
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         'I am:',
//                         style: TextStyle(color: Colors.white, fontSize: 18),
//                       ),
//                       SizedBox(width: 10),
//                       ElevatedButton(
//                         onPressed: () {
//                           _updatePresence(true); // Update presence to 'Present'
//                         },
//                         style: ElevatedButton.styleFrom(
//                           foregroundColor: Colors.white,
//                         ),
//                         child: Text(
//                           'Present',
//                           style: TextStyle(color: Colors.black),
//                         ),
//                       ),
//                       SizedBox(width: 10),
//                       ElevatedButton(
//                         onPressed: () {
//                           _updatePresence(false); // Update presence to 'Absent'
//                         },
//                         style: ElevatedButton.styleFrom(
//                           foregroundColor: Colors.white,
//                         ),
//                         child: Text(
//                           'Absent',
//                           style: TextStyle(color: Colors.black),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 // List view for other owners
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: owners.length,
//                     itemBuilder: (context, index) {
//                       var owner = owners[index];
//                       bool presence = owner.get('presence') ?? false;
//                       String ownerName = owner.get('name') ?? '';
//                       String designation = owner.get('designation') ?? '';
//
//                       return ListTile(
//                         title: Text(ownerName),
//                         subtitle: Text(designation),
//                         trailing: Text(
//                           presence ? 'Present' : 'Absent',
//                           style: TextStyle(
//                             color: presence ? Colors.green : Colors.red,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             );
//           }
//         },
//       ),
//     );
//   }
// }
// class OwnerDrawer extends StatelessWidget {
//   final String? username; // Receive the username
//   const OwnerDrawer({Key? key, this.username}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: [
//           DrawerHeader(
//             decoration: BoxDecoration(
//               color: Colors.blue,
//             ),
//             child: Text(
//               username ?? 'Username', // Display owner's name here
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 24,
//               ),
//             ),
//           ),
//           ListTile(
//             title: Text('Declare Emergencies'),
//             onTap: () {
//               // Navigate to the declare emergencies screen
//             },
//           ),
//           ListTile(
//             title: Text('Solutions for Emergencies'),
//             onTap: () {
//               // Navigate to the solutions for emergencies screen
//             },
//           ),
//           ListTile(
//             title: Text('Ongoing Emergencies'),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => OngoingEmergenciesScreen()),
//               );
//
//               // Navigate to the ongoing emergencies screen
//             },
//           ),
//           ListTile(
//             title: Text('Write a Notice'),
//             onTap: () {
//               // Navigate to the write a notice screen
//             },
//           ),
//           ListTile(
//             title: Text('Log Out'),
//             onTap: () {
//               FirebaseAuth.instance.signOut(); // Logout the user
//               // Navigate to login screen or any other screen you prefer
//               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OwnerLogin()));
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hello/ownerlogin.dart';
import 'package:hello/ongoingemergenciesscreen.dart';
import 'package:http/http.dart' as http;
import 'main.dart'; // Import the main.dart file where flutterLocalNotificationsPlugin is initialized
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class OwnerManagementScreen extends StatefulWidget {
  final String? username;
  final bool presence;

  const OwnerManagementScreen({Key? key, required this.presence, this.username}) : super(key: key);

  @override
  _OwnerManagementScreenState createState() => _OwnerManagementScreenState();
}

class _OwnerManagementScreenState extends State<OwnerManagementScreen> {
  late FirebaseFirestore _firestore;
  late CollectionReference _ownersCollection;
  late Stream<QuerySnapshot> _ownersStream;
  late FirebaseMessaging _firebaseMessaging;

  @override
  void initState() {
    super.initState();
    _firestore = FirebaseFirestore.instance;
    _ownersCollection = _firestore.collection('owners');
    _ownersStream = _ownersCollection.snapshots();
    _firebaseMessaging = FirebaseMessaging.instance;

    // Request permission for receiving notifications (iOS only)
    _firebaseMessaging.requestPermission();

    // Get FCM token and store it
    getFCMToken();

    // Configure Firebase Messaging
    _configureFirebaseMessaging();

    // Listen for new emergencies
    _listenForEmergencies();
  }

  void getFCMToken() async {
    String? fcmToken = await _firebaseMessaging.getToken();
    print('FCM Token: $fcmToken');

    if (fcmToken != null) {
      storeFCMToken(fcmToken);
    }
  }

  void storeFCMToken(String fcmToken) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      try {
        DocumentReference userDoc = FirebaseFirestore.instance.collection('users').doc(currentUser.uid);
        DocumentSnapshot userSnapshot = await userDoc.get();

        if (userSnapshot.exists) {
          await userDoc.update({'fcmToken': fcmToken});
        } else {
          await userDoc.set({'fcmToken': fcmToken});
        }

        print('FCM Token updated in Firestore successfully.');
      } catch (e) {
        print('Error updating FCM Token: $e');
      }
    }
  }

  void _configureFirebaseMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message clicked!');
    });
  }

  void _listenForEmergencies() {
    _firestore.collection('emergencies').snapshots().listen((QuerySnapshot snapshot) {
      snapshot.docChanges.forEach((change) {
        if (change.type == DocumentChangeType.added || change.type == DocumentChangeType.modified) {
          String location = change.doc['location'];
          String severity = change.doc['type'];

          String notificationMessage = "Emergency occurred in $location of $severity";

          // Retrieve owner's FCM token
          String ownerFCMToken = 'eRS02wC6S3iXRNB6OYjC4M:APA91bGs6ELOERNjAM2inqJMdrPUTZyr_FIIvM6hr5VN1mRBWU8cFBc9lM6mSAdueqC3MvGvMsYlulwrbkIOEa9AKmBeYwnTdLKIH-lmGocPmD-WecxMTK_gYxtLJgS1XHAzsIs1a2NQ';

          // Send notification to owner
          _sendEmergencyNotification(notificationMessage, ownerFCMToken);
        }
      });
    });
  }

  Future<void> _sendEmergencyNotification(String location, String severity) async {
    final List<String> userFcmTokens = await _getUserFcmTokens();

    for (final fcmToken in userFcmTokens) {
      try {
        final url = Uri.parse('https://fcm.googleapis.com/fcm/send');

        final headers = {
          'Content-Type': 'application/json',
          'Authorization': 'key=AAAAgV9NMd8:APA91bGm5NIiHoRRySxr7jpLibo7-lxjaTyggg4a9DoYd7EMQFqNA6fg7QhcpwoGN6RTWvGWaYwCxBbJKCuGgplPmSJ--pLLCdAa_2jJt6_N0KS_-9sUg29u3bDDDQjCL7x9VDuog0Fi', // Replace with your server key
        };

        final body = {
          'notification': {
            'title': 'Emergency Alert!',
            'body': 'An emergency of severity "$severity" has occurred in $location.',
          },
          'to': fcmToken,
        };

        final response = await http.post(url, headers: headers, body: json.encode(body));

        if (response.statusCode == 200) {
          print('Notification sent successfully to FCM token: $fcmToken');
        } else {
          print('Error sending notification: Status code ${response.statusCode}');
        }
      } catch (e) {
        print('Error sending notification: $e');
      }
    }
  }

  Future<List<String>> _getUserFcmTokens() async {
    return ['PLACEHOLDER_FCM_TOKEN_1', 'PLACEHOLDER_FCM_TOKEN_2'];
  }

  void _updatePresence(bool isPresent) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final documentSnapshot = await _ownersCollection.doc(currentUser.uid).get();
      if (documentSnapshot.exists) {
        await _ownersCollection.doc(currentUser.uid).update({'presence': isPresent});
      } else {
        await _ownersCollection.doc(currentUser.uid).set({'presence': isPresent});
      }
    }
  }

  Future<void> _showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your_channel_id', // channelId
      'your_channel_name', // channelName
      channelDescription: 'your_channel_description', // channelDescription is now a named parameter
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title,
      message.notification?.body,
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Onboard Officers'),
      ),
      drawer: OwnerDrawer(username: widget.username),
      body: StreamBuilder<QuerySnapshot>(
        stream: _ownersStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<QueryDocumentSnapshot> owners = snapshot.data!.docs;

            return Column(
              children: [
                Container(
                  height: 50,
                  color: Colors.green,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'I am:',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          _updatePresence(true);
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                        ),
                        child: Text(
                          'Present',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          _updatePresence(false);
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                        ),
                        child: Text(
                          'Absent',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: owners.length,
                    itemBuilder: (context, index) {
                      var owner = owners[index];
                      bool presence = owner.get('presence') ?? false;
                      String ownerName = owner.get('name') ?? '';
                      String designation = owner.get('designation') ?? '';

                      return ListTile(
                        title: Text(ownerName),
                        subtitle: Text(designation),
                        trailing: Text(
                          presence ? 'Present' : 'Absent',
                          style: TextStyle(
                            color: presence ? Colors.green : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class OwnerDrawer extends StatelessWidget {
  final String? username;

  const OwnerDrawer({Key? key, this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              username ?? 'Username',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text('Declare Emergencies'),
            onTap: () {
              // Navigate to the declare emergencies screen
            },
          ),
          ListTile(
            title: Text('Solutions for Emergencies'),
            onTap: () {
              // Navigate to the solutions for emergencies screen
            },
          ),
          ListTile(
            title: Text('Ongoing Emergencies'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OngoingEmergenciesScreen()),
              );
            },
          ),
          ListTile(
            title: Text('Write a Notice'),
            onTap: () {
              // Navigate to the write a notice screen
            },
          ),
          ListTile(
            title: Text('Log Out'),
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => OwnerLogin()));
            },
          ),
        ],
      ),
    );
  }
}
