// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class HeadOfficersScreen extends StatelessWidget {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Details about Officers',style: TextStyle(color: Colors.white),),
//         backgroundColor: Colors.grey[500],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildInfoCard(
//                 title: 'Head Incharges:',
//                 data: [
//                   {'name': 'MayankKumar Doshi ', 'department': 'Chief Incident Controller(CIC)'},
//                   {'name': 'Bhanu Prakash Rao', 'department': 'Deputy Chief Incident Controller(DCIC)'},
//                   {'name': 'Suraj Puthiyidath Kuriakose', 'department': 'Site Incident Controller(SIC)'},
//                   {'name': 'Nitin Jain', 'department': 'Deputy Site Incident Controller(DSIC) '},
//                   {'name': 'Vidyadhar Mulay', 'department': 'Mechanical Maintenance Coordinator '},
//                   {'name': 'Jagat Satpathy', 'department': 'Electrical Maintenance Coordinator '},
//                   {'name': 'G Gowari Shankar', 'department': 'Service Coodinator'},
//                   {'name': 'Rabi Manik', 'department': 'C&I Maintenance Cordinator '},
//                   {'name': 'Mudit Khair', 'department': 'Fire Rescue Responder '},
//                   {'name': 'Shashikant Bodhankar', 'department': 'Safety Coordinator'},
//                   {'name': 'Dr. Ujawala Upadhaya', 'department': 'Medical Aid Coordinator'},
//                   {'name': 'Arun Pratap Singh', 'department': 'Enviroment Coordinator'},
//                   {'name': 'Shift Incharge', 'department': 'Assembly Points Coordinator '},
//                   {'name': 'Sanjay Argade', 'department': 'Chief Relief Controller '},
//                   {'name': 'Pradeep Nair', 'department': 'Transport Contoller '},
//
//
//                 ],
//                 icon: Icons.person,
//               ),
//               const SizedBox(height: 15),
//               _buildInfoCard(
//                 title: 'Shift Incharges:',
//                 data: [
//                   {'name': 'Jane Doe', 'shiftTiming': 'Morning Shift'},
//                   {'name': 'Tom Harris', 'shiftTiming': 'Afternoon Shift'},
//                   {'name': 'Lucy Clark', 'shiftTiming': 'Evening Shift'},
//                   {'name': 'Sam Wilson', 'shiftTiming': 'Night Shift'},
//                 ],
//                 icon: Icons.schedule,
//               ),
//               const SizedBox(height: 20),
//             ],
//           ),
//         ),
//       )
//     );
//   }
//   Widget _buildInfoCard({required String title, required List<Map<String, String>> data, required IconData icon}) {
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5),
//             spreadRadius: 5,
//             blurRadius: 7,
//             offset: Offset(0, 3),
//           ),
//         ],
//         borderRadius: BorderRadius.circular(10),
//       ),
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Icon(icon, color: Colors.blue),
//               SizedBox(width: 8),
//               Text(
//                 title,
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
//               ),
//             ],
//           ),
//           const SizedBox(height: 10),
//           ...data.map((info) => Padding(
//             padding: const EdgeInsets.only(bottom: 10),
//             child: Row(
//               children: [
//                 Icon(Icons.person, color: Colors.grey[700]),
//                 SizedBox(width: 8),
//                 Expanded(
//                   child: Text(
//                     info.containsKey('name') ? info['name']! : info['shiftTiming']!,
//                     style: TextStyle(color: Colors.black87),
//                   ),
//                 ),
//                 if (info.containsKey('department'))
//                   Padding(
//                     padding: const EdgeInsets.only(left: 10.0),
//                     child: Text(
//                       info['department']!,
//                       style: TextStyle(color: Colors.grey),
//                     ),
//                   ),
//                 if (info.containsKey('shiftTiming'))
//                   Padding(
//                     padding: const EdgeInsets.only(left: 10.0),
//                     child: Text(
//                       info['shiftTiming']!,
//                       style: TextStyle(color: Colors.grey),
//                     ),
//                   ),
//               ],
//             ),
//           )).toList(),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';

class HeadOfficersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Details about Officers',
          style: TextStyle(color: Colors.white),
        ),
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
                  {'name': 'MayankKumar Doshi', 'department': 'Chief Incident Controller(CIC)'},
                  {'name': 'Bhanu Prakash Rao', 'department': 'Deputy Chief Incident Controller(DCIC)'},
                  {'name': 'Suraj Puthiyidath Kuriakose', 'department': 'Site Incident Controller(SIC)'},
                  {'name': 'Nitin Jain', 'department': 'Deputy Site Incident Controller(DSIC)'},
                  {'name': 'Vidyadhar Mulay', 'department': 'Mechanical Maintenance Coordinator'},
                  {'name': 'Jagat Satpathy', 'department': 'Electrical Maintenance Coordinator'},
                  {'name': 'G Gowari Shankar', 'department': 'Service Coordinator'},
                  {'name': 'Rabi Manik', 'department': 'C&I Maintenance Coordinator'},
                  {'name': 'Mudit Khair', 'department': 'Fire Rescue Responder'},
                  {'name': 'Shashikant Bodhankar', 'department': 'Safety Coordinator'},
                  {'name': 'Dr. Ujawala Upadhaya', 'department': 'Medical Aid Coordinator'},
                  {'name': 'Arun Pratap Singh', 'department': 'Environment Coordinator'},
                  {'name': 'Shift Incharge', 'department': 'Assembly Points Coordinator'},
                  {'name': 'Sanjay Argade', 'department': 'Chief Relief Controller'},
                  {'name': 'Pradeep Nair', 'department': 'Transport Controller'},
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
    );
  }

  Widget _buildInfoCard(
      {required String title, required List<Map<String, String>> data, required IconData icon}) {
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        info['name']!,
                        style: TextStyle(color: Colors.black87),
                      ),
                      if (info.containsKey('department'))
                        Text(
                          info['department']!,
                          style: TextStyle(color: Colors.grey),
                        ),
                      if (info.containsKey('shiftTiming'))
                        Text(
                          info['shiftTiming']!,
                          style: TextStyle(color: Colors.grey),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ))
              .toList(),
        ],
      ),
    );
  }
}
