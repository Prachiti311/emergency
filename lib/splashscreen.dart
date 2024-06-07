import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hello/ownerlogin.dart';
import 'package:hello/userlogin.dart';
import 'package:hello/userinfoscreen.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    super.initState();
    notificationServices.requestNotificationPermissions(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(), // Use MainPage as the home widget
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var userCredential;
            return UserInfoScreen(user: userCredential.user!);
          } else {
            return const SplashScreen();
          }
        },
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFE7BDBD),
              Color(0xFFC069AF),
            ],

            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/img.png', // Replace with your logo asset path
                width: 250.0,
                height: 250.0,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 1.0), // Add spacing
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to the login page when the owner button is pressed
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OwnerLogin()),
                      );
                      // Action when Owner button is pressed
                      print('Owner button pressed');
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 2,
                      side: const BorderSide(color: Colors.black),
                      padding: const EdgeInsets.all(15.0),
                      minimumSize: const Size(150.0, 50.0),
                      // Set background color and text color directly
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                    ),
                    child: const Text('Owner'),
                  ),
                  const SizedBox(width: 7.0), // Add spacing between buttons
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to the login page when the user button is pressed
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UserLogin()),
                      );
                      // Action when User button is pressed
                      print('User button pressed');
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 2,
                      side: const BorderSide(color: Colors.black),
                      padding: const EdgeInsets.all(15.0),
                      minimumSize: const Size(150.0, 50.0),
                      // Set background color and text color directly
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                    ),
                    child: const Text('User'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NotificationServices {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> requestNotificationPermissions(BuildContext context) async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission: ${settings.authorizationStatus == AuthorizationStatus.authorized}');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User denied permission');

      // Show dialog based on permission status
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Notification Permissions Required'),
            content: Text('Please enable notification permissions to receive updates.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
