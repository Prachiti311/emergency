

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

  //40
  // List of emergency types and locations
  List<String> emergencyItems = [
    'Chemical Release',
    'Fire In coal',
    'Fire in Electrical System',
    'Fire in Control Room',
    'Major Release of Fuel Oil ',
    'Fire in Switch Yards',
    'Fire in CT,PT',
    'Boiler Explosion',
    'Fire in Switch Yards',
    'Fire in Transformer',
    'Fire in Turbine Generator areas',
    'Health Hazard Plastic Chemical Drums',
    'Health Hazard Waste Ion exchange Resins',
    'Health Hazard Used Oil',
    'Health Hazard Used Batteries',
    'Accident',
    'Fire',
    'Bursting of Pressure Vessel',
    'Collapse of Equip/Building Human Error',

  ];

  // page 36
  List<String> locationItems = [
    'Coal Yard',
    'Tank Farm',
    'Pipeline',
    'D.G room',
    'Cylinder Stores',
    'Hydrogen Plant',
    'Turbine Floor',
    'D.M Plant',
    'Laboratory',
    'Chemical Dozing',
    'TG Building 1 Roof',
    'TG Building 2 Roof'
    'TG Building 3 Roof',
    'CPWH 1 Roof',
    'CPWH 2 Roof',
    'CPWH 3 Roof',
    'AHP Control Room 1 Roof',
    'AHP Control Room 2 Roof',
    'AHP Control Room 3 Roof',

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Inform Emergency',
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
              // Dropdown for selecting emergency type
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
                  contentPadding: EdgeInsets.all(1),
                  labelText: "Select Emergency",
                ),
                onChanged: (String? value) {
                  setState(() {
                    selectedEmergency = value;
                  });
                },
              ),
              SizedBox(height: 30),
              // Dropdown for selecting location
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
              // Note section
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
              // Buttons for messaging and calling
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
                        backgroundColor: Colors.blue,
                      ),
                      icon: Icon(Icons.message),
                      label: Text('Message', style: TextStyle(fontSize: 16,color: Colors.white)),
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: _makePhoneCall,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      icon: Icon(Icons.call),
                      label: Text('Call', style: TextStyle(fontSize: 16,color: Colors.white)),
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

  // Function to send a message to the owner
  void _sendMessageToOwner() async {
    if (selectedEmergency != null && selectedLocation != null) {
      String message = 'Emergency: $selectedEmergency, Location: $selectedLocation';

      try {
        // Get the current user's document from the users collection
        DocumentReference userRef = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid);
        DocumentSnapshot userSnapshot = await userRef.get();

        // Check if the user document exists
        if (userSnapshot.exists) {
          // Access the username field from the user document
          String username = userSnapshot['username'];

          // Send message to Firestore
          await FirebaseFirestore.instance.collection('messages').add({
            'message': message,
            'sender': FirebaseAuth.instance.currentUser?.uid,
            'username': username, // Add username to the message
            'timestamp': DateTime.now(),
          });
          print('Message sent to owner');

          // Store emergency data in Firestore
          await FirebaseFirestore.instance.collection('emergencies').add({
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
          // Create the user document if it doesn't exist
          await userRef.set({
            'username': 'Unknown', // Default value, replace with actual username if available
            'phonenumber': 'Unknown', // Default value, replace with actual phone number if available
            'email': FirebaseAuth.instance.currentUser?.email ?? 'Unknown',
          });
          print('User document created');

          // Retry sending the message after creating the user document
          _sendMessageToOwner();
        }
      } catch (e) {
        print('Failed to send message: $e');
      }
    } else {
      print('Please select emergency and location first');
    }
  }

  // Function to make a phone call
  void _makePhoneCall() async {
    print('Making a phone call to the owner');
    await FlutterPhoneDirectCaller.callNumber('7020357477');
  }
}
