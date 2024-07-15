// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class AssemblyPointsPage extends StatefulWidget {
//   @override
//   _AssemblyPointsPageState createState() => _AssemblyPointsPageState();
// }
//
// class _AssemblyPointsPageState extends State<AssemblyPointsPage> {
//   String? selectedLocation;
//   TextEditingController newLocationController = TextEditingController();
//   List<String> locations = ['CHP Control Room', 'Near Cooling Tower-1', 'Phase 1 and 2 control Room','Security Office Gate NO 2','Service Building','admin']; // Default locations
//
//   @override
//   void dispose() {
//     newLocationController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Assembly Points',
//           style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: Colors.grey,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             DropdownButtonFormField<String>(
//               value: selectedLocation,
//               hint: Text('Select Location', style: TextStyle(fontSize: 20, color: Colors.black)),
//               onChanged: (value) {
//                 setState(() {
//                   selectedLocation = value;
//                 });
//               },
//               items: locations.map((String location) {
//                 return DropdownMenuItem<String>(
//                   value: location,
//                   child: Text(location, style: TextStyle(fontSize: 16, color: Colors.grey[700])),
//                 );
//               }).toList(),
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
//                 labelText: 'Select Location',
//                 labelStyle: TextStyle(fontSize: 16, color: Colors.grey[700]),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Expanded(
//               child: selectedLocation != null
//                   ? StreamBuilder<DocumentSnapshot>(
//                 stream: FirebaseFirestore.instance
//                     .collection('locations')
//                     .doc('${selectedLocation!.toLowerCase()}_locations')
//                     .snapshots(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Center(child: CircularProgressIndicator());
//                   }
//
//                   if (!snapshot.hasData || !snapshot.data!.exists) {
//                     return Center(child: Text('No assembly points available', style: TextStyle(fontSize: 16, color: Colors.grey[700])));
//                   }
//
//                   List<dynamic> assemblyPoints = snapshot.data!.get('assembly_points');
//
//                   return assemblyPoints.isEmpty
//                       ? Center(child: Text('No assembly points available for this location', style: TextStyle(fontSize: 16, color: Colors.grey[700])))
//                       : ListView.builder(
//                     itemCount: assemblyPoints.length,
//                     itemBuilder: (context, index) {
//                       var assemblyPoint = assemblyPoints[index];
//
//                       return Card(
//                         margin: EdgeInsets.symmetric(vertical: 8.0),
//                         color: Colors.grey[100],
//                         child: ListTile(
//                           leading: Icon(
//                             Icons.place,
//                             color: Colors.grey[800],
//                             size: 40,
//                           ),
//                           title: Text(
//                             assemblyPoint.toString(),
//                             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.grey[800]),
//                           ),
//                           trailing: Icon(
//                             Icons.arrow_forward,
//                             color: Colors.grey[800],
//                           ),
//                           onTap: () {
//                             // Add onTap functionality if needed
//                           },
//                         ),
//                       );
//                     },
//                   );
//                 },
//               )
//                   : Center(child: Text('Select a location', style: TextStyle(fontSize: 16, color: Colors.grey[700]))),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class AssemblyPointsPage extends StatefulWidget {
//   @override
//   _AssemblyPointsPageState createState() => _AssemblyPointsPageState();
// }
//
// class _AssemblyPointsPageState extends State<AssemblyPointsPage> {
//   String? selectedLocation;
//   TextEditingController newLocationController = TextEditingController();
//   List<String> locations = ['canteen','chpcontrolroom', 'Near Cooling Tower-1', 'Phase 1 and 2 control Room','Security Office Gate NO 2','Service Building','admin']; // Default locations
//
//   @override
//   void dispose() {
//     newLocationController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Assembly Points',
//           style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: Colors.grey,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             DropdownButtonFormField<String>(
//               value: selectedLocation,
//               hint: Text('Select Location', style: TextStyle(fontSize: 20, color: Colors.black)),
//               onChanged: (value) {
//                 setState(() {
//                   selectedLocation = value;
//                 });
//               },
//               items: locations.map((String location) {
//                 return DropdownMenuItem<String>(
//                   value: location,
//                   child: Text(location, style: TextStyle(fontSize: 16, color: Colors.grey[700])),
//                 );
//               }).toList(),
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
//                 labelText: 'Select Location',
//                 labelStyle: TextStyle(fontSize: 16, color: Colors.grey[700]),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Expanded(
//               child: selectedLocation != null
//                   ? StreamBuilder<DocumentSnapshot>(
//                 stream: FirebaseFirestore.instance
//                     .collection('locations')
//                     .doc('${selectedLocation!.toLowerCase()}_locations')
//                     .snapshots(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Center(child: CircularProgressIndicator());
//                   }
//
//                   if (!snapshot.hasData || !snapshot.data!.exists) {
//                     return Center(child: Text('No assembly points available', style: TextStyle(fontSize: 16, color: Colors.grey[700])));
//                   }
//
//                   String assemblyPoint = snapshot.data!.get('assembly_points');
//
//                   return Card(
//                     margin: EdgeInsets.symmetric(vertical: 8.0),
//                     color: Colors.grey[100],
//                     child: ListTile(
//                       leading: Icon(
//                         Icons.place,
//                         color: Colors.grey[800],
//                         size: 40,
//                       ),
//                       title: Text(
//                         assemblyPoint,
//                         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.grey[800]),
//                       ),
//                       trailing: Icon(
//                         Icons.arrow_forward,
//                         color: Colors.grey[800],
//                       ),
//                       onTap: () {
//                         // Add onTap functionality if needed
//                       },
//                     ),
//                   );
//                 },
//               )
//                   : Center(child: Text('Select a location', style: TextStyle(fontSize: 16, color: Colors.grey[700]))),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AssemblyPointsPage extends StatefulWidget {
  @override
  _AssemblyPointsPageState createState() => _AssemblyPointsPageState();
}

class _AssemblyPointsPageState extends State<AssemblyPointsPage> {
  String? selectedLocation;
  TextEditingController newLocationController = TextEditingController();
  List<String> locations = [ 'CHP Control Room','Near Cooling Tower-1', 'Phase I and II Control Room', 'Security Office Gate No II', 'Service Building', ]; // Default locations

  @override
  void dispose() {
    newLocationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Assembly Points',
          style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.grey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              value: selectedLocation,
              hint: Text('Select Location', style: TextStyle(fontSize: 20, color: Colors.black)),
              onChanged: (value) {
                setState(() {
                  selectedLocation = value;
                });
              },
              items: locations.map((String location) {
                return DropdownMenuItem<String>(
                  value: location,
                  child: Text(location, style: TextStyle(fontSize: 16, color: Colors.grey[700])),
                );
              }).toList(),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                labelText: 'Select Location',
                labelStyle: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: selectedLocation != null
                  ? StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('locations')
                    .where('Name', isEqualTo: selectedLocation)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No assembly points available', style: TextStyle(fontSize: 16, color: Colors.grey[700])));
                  }

                  // Assuming there is only one document that matches the location name
                  var document = snapshot.data!.docs.first;
                  String assemblyPoint = document.get('assembly_points');

                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    color: Colors.grey[100],
                    child: ListTile(
                      leading: Icon(
                        Icons.place,
                        color: Colors.grey[800],
                        size: 40,
                      ),
                      title: Text(
                        assemblyPoint,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.grey[800]),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward,
                        color: Colors.grey[800],
                      ),
                      onTap: () {
                        // Add onTap functionality if needed
                      },
                    ),
                  );
                },
              )
                  : Center(child: Text('Select a location', style: TextStyle(fontSize: 16, color: Colors.grey[700]))),
            ),
          ],
        ),
      ),
    );
  }
}
