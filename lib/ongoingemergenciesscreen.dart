// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class OngoingEmergenciesScreen extends StatelessWidget {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final CollectionReference _emergenciesCollection = FirebaseFirestore.instance.collection('emergencies');
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Ongoing Emergencies'),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: _emergenciesCollection.snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             List<QueryDocumentSnapshot> emergencies = snapshot.data!.docs;
//
//             if (emergencies.isEmpty) {
//               return Center(child: Text('No ongoing emergencies'));
//             }
//
//             return ListView.builder(
//               itemCount: emergencies.length,
//               itemBuilder: (context, index) {
//                 var emergency = emergencies[index];
//                 var emergencyData = emergency.data();
//                 if (emergencyData != null) {
//                   return EmergencyCard(emergencyData: emergencyData as Map<String, dynamic>);
//                 } else {
//                   // Handle null emergency data, if needed
//                   return SizedBox(); // Return an empty widget or placeholder
//                 }
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }
//
// class EmergencyCard extends StatelessWidget {
//   final Map<String, dynamic> emergencyData;
//
//   const EmergencyCard({Key? key, required this.emergencyData}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//       child: ListTile(
//         title: Text(
//           emergencyData['type'],
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 4),
//             Text('Location: ${emergencyData['location']}'),
//             SizedBox(height: 4),
//             Text('Reported by: ${emergencyData['reportedBy']}'),
//             SizedBox(height: 4),
//             Text('Timestamp: ${emergencyData['timestamp']}'),
//           ],
//         ),
//         onTap: () {
//           // Implement any action on emergency tap, such as marking as resolved, etc.
//         },
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OngoingEmergenciesScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _emergenciesCollection = FirebaseFirestore.instance.collection('emergencies');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ongoing Emergencies'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _emergenciesCollection.snapshots(),
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
      child: ListTile(
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
            Text('Reported by: ${emergencyData['username']}'), // Display username instead of reportedBy
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.directions),
              onPressed: () {
                // Implement action for directions
              },
            ),
            IconButton(
              icon: Icon(Icons.warning),
              onPressed: () {
                // Implement action for declaring emergency
              },
            ),
          ],
        ),
        onTap: () {
          // Implement any action on emergency tap, such as marking as resolved, etc.
        },
      ),
    );
  }
}
