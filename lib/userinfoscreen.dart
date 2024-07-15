
import 'package:flutter/material.dart';
import 'package:hello/assemblypointspage.dart';
import 'package:hello/emergenciespage.dart';
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

    String? token = await _firebaseMessaging.getToken();
    print("Firebase Messaging Token: $token");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details about Officers',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.grey[500],
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
                  {'name': 'MayankKumar Doshi ', 'department': 'Chief Incident Controller(CIC)'},
                  {'name': 'Bhanu Prakash Rao', 'department': 'Deputy Chief Incident Controller(DCIC)'},
                  {'name': 'Suraj Puthiyidath Kuriakose', 'department': 'Site Incident Controller(SIC)'},
                  {'name': 'Nitin Jain', 'department': 'Deputy Site Incident Controller(DSIC) '},
                  {'name': 'Vidyadhar Mulay', 'department': 'Mechanical Maintenance Coordinator '},
                  {'name': 'Jagat Satpathy', 'department': 'Electrical Maintenance Coordinator '},
                  {'name': 'G Gowari Shankar', 'department': 'Service Coodinator'},
                  {'name': 'Rabi Manik', 'department': 'C&I Maintenance Cordinator '},
                  {'name': 'Mudit Khair', 'department': 'Fire Rescue Responder '},
                  {'name': 'Shashikant Bodhankar', 'department': 'Safety Coordinator'},
                  {'name': 'Dr. Ujawala Upadhaya', 'department': 'Medical Aid Coordinator'},
                  {'name': 'Arun Pratap Singh', 'department': 'Enviroment Coordinator'},
                  {'name': 'Shift Incharge', 'department': 'Assembly Points Coordinator '},
                  {'name': 'Sanjay Argade', 'department': 'Chief Relief Controller '},
                  {'name': 'Pradeep Nair', 'department': 'Transport Contoller '},


                ],
                icon: Icons.person,
              ),
              const SizedBox(height: 15),
              _buildInfoCard(
                title: 'Shift Incharges:',
                data: [
                  {'name': 'Jane Doe', 'shiftTiming': 'Morning Shift'},
                  {'name': 'Tom Harris', 'shiftTiming': 'Afternoon Shift'},
                  {'name': 'Lucy Clark', 'shiftTiming': 'Evening Shift'},
                  {'name': 'Sam Wilson', 'shiftTiming': 'Night Shift'},
                ],
                icon: Icons.schedule,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: const Color(0xFF5FA2F1),
              ),
              child: Text(
                'Navigation Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.emergency),
              title: Text('Inform An Emergency'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserReportScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Assembly points near me '),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AssemblyPointsPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('Instruction of emergencies'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EmergenciesPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.note),
              title: Text('Notices'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserNoticeScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Sign Out'),
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UserLogin()));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({required String title, required List<Map<String, String>> data, required IconData icon}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.blue),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...data.map((info) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Icon(Icons.person, color: Colors.grey[700]),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    info.containsKey('name') ? info['name']! : info['shiftTiming']!,
                    style: TextStyle(color: Colors.black87),
                  ),
                ),
                if (info.containsKey('department'))
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      info['department']!,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                if (info.containsKey('shiftTiming'))
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      info['shiftTiming']!,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }
}
