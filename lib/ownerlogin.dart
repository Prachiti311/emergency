

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hello/ownermanagementscreen.dart';
import 'package:hello/splashscreen.dart';


class OwnerLogin extends StatefulWidget {
  const OwnerLogin({Key? key}) : super(key: key);


  @override
  _OwnerLoginState createState() => _OwnerLoginState();
}

class _OwnerLoginState extends State<OwnerLogin> {
  String? _username; // Add a field to store the username

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late Future<UserCredential?> _loginFuture;
  late FirebaseFirestore _firestore; // Add instance variable for Firestore

  @override
  void initState() {
    super.initState();
    requestPermission();
    _loginFuture = Future.value(null);
    _firestore = FirebaseFirestore.instance; // Initialize Firestore
  }
  Future<void> requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      provisional: false,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.notDetermined) {
      print('User not determined');
    } else {
      print('User denied permission');
    }
  }

  Future<void> signIn() async {
    try {
      final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Debug print
      print('User signed in: ${userCredential.user?.email}');

      if (userCredential.user != null && userCredential.user!.email != null) {
        if (userCredential.user!.email!.endsWith('@ownerdomain.com')) {
          _username = userCredential.user!.displayName;

          // Check if the document exists
          DocumentSnapshot userSnapshot = await _firestore
              .collection('owners')
              .doc(userCredential.user!.uid)
              .get();

          // Debug print
          print('Document snapshot exists: ${userSnapshot.exists}');

          if (userSnapshot.exists) {
            bool isPresent = userSnapshot.get('presence') ?? false;
            String username = userSnapshot.get('username') ?? '';

            // Debug print
            print('Presence: $isPresent, Username: $username');

            // Navigate to the owner management screen if the user is an owner
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OwnerManagementScreen(
                  presence: isPresent,
                  username: username,
                ),
              ),
            );
          } else {
            // Handle case when the document does not exist
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Owner information not found.'),
                duration: Duration(seconds: 2),
              ),
            );
            await FirebaseAuth.instance.signOut();
          }
        } else {
          // Sign out the user if they are not an owner
          await FirebaseAuth.instance.signOut();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Only owners are allowed to sign in.'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      // If there's an error with login, show a snackbar with the error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid username or password'),
          duration: Duration(seconds: 2),
        ),
      );
      // Navigate to splash screen after showing the SnackBar
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SplashScreen()),
      );
      // If the login fails, reset the login future
      setState(() {
        _loginFuture = Future.value(null);
      });
    }
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Owner Login',
          style: TextStyle(fontSize: 28, color: Colors.white),
        ),
        backgroundColor: Colors.grey[500],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 60),
            Text(
              'Welcome Back, Owner!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Username',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: signIn,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Login',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GestureDetector(
          onTap: () {
            print('Help in the center tapped');
          },
          child: Text(
            'Need Help? Tap here!',
            style: TextStyle(color: Colors.blue, fontSize: 16, decoration: TextDecoration.underline),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}


