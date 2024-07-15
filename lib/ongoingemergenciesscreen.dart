

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'declareemergencyscreen.dart';
import 'assemblypointspage.dart';
import 'emergenciespage.dart'; // Import your instruction page

class OngoingEmergenciesScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _emergenciesCollection = FirebaseFirestore.instance.collection('emergencies');

  OngoingEmergenciesScreen() {
    _deleteOldEmergencies();
  }

  void _deleteOldEmergencies() async {
    final now = DateTime.now();
    final cutoff = now.subtract(Duration(hours: 24));

    final oldEmergencies = await _emergenciesCollection
        .where('timestamp', isLessThan: cutoff)
        .get();

    for (var doc in oldEmergencies.docs) {
      await doc.reference.delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ongoing Emergencies',
          style: TextStyle(fontSize: 28, color: Colors.white),
        ),
        backgroundColor: Colors.grey[500],
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _emergenciesCollection.orderBy('timestamp', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<QueryDocumentSnapshot> emergencies = snapshot.data!.docs;

            if (emergencies.isEmpty) {
              return Center(child: Text('No ongoing emergencies'));
            }

            return ListView.builder(
              itemCount: emergencies.length,
              itemBuilder: (context, index) {
                var emergency = emergencies[index];
                var emergencyData = emergency.data();
                if (emergencyData != null) {
                  return EmergencyCard(emergencyData: emergencyData as Map<String, dynamic>);
                } else {
                  // Handle null emergency data, if needed
                  return SizedBox(); // Return an empty widget or placeholder
                }
              },
            );
          }
        },
      ),
    );
  }
}

class EmergencyCard extends StatelessWidget {
  final Map<String, dynamic> emergencyData;

  const EmergencyCard({Key? key, required this.emergencyData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Convert timestamp to DateTime
    DateTime timestamp = (emergencyData['timestamp'] as Timestamp).toDate();
    // Format time to hours and minutes
    String time = '${timestamp.hour}:${timestamp.minute}';

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                emergencyData['type'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 4),
                  Text('Location: ${emergencyData['location']}'),
                  SizedBox(height: 4),
                  Text('Time: $time'),
                  SizedBox(height: 4),
                  Text('Reported by: ${emergencyData['reportedByUsername']}'), // Display username instead of reportedBy
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.directions),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AssemblyPointsPage()),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.warning),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EmergenciesPage()),
                      );
                    },
                  ),
                ],
              ),
              onTap: () {
                // Implement any action on emergency tap, such as marking as resolved, etc.
              },
            ),
            SizedBox(height: 8),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DeclareEmergencyScreen(emergencyData: emergencyData)),
                  );
                },
                child: Text('Declare Emergency'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
