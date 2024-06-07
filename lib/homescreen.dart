// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// // import 'package:hello/splashscreen.dart';
//
// class HomeScreen extends StatefulWidget{
//    const HomeScreen({Key? key}) : super(key:key);
//
//
//   @override
//   State<HomeScreen> createState() => HomeScreenState();
//
//
// }
//
// class _HomeScreenState extends State<HomeScreen>{
//   NotificationServices notificationServices = NotificationServices();
//
// @override
//   void initState() {
//   super initState();
//   notificationServices.requestNotificationPermissions();
//   notificationServices.firebaseInit(context);
//   notificationServices.setupInterfaceMessage(context);
//   notificationServices.IsTokenRefresh();
//   notificationServices.getDeviceToken().then((value)){
//     if(kDebugMode) {
//       print('Device Token');
//       print(value);
//     }
//   });
// }
// @override
//   Widget build(BuildContext context){
//   return Scaffold(
//     appBar: AppBar(
//       title: const Text('Flutter Notification'),
//
//     ),
//     body: Center(),
//     child : TextButton(onPressed: (){
//       notificationServices.getDeviceToken().then(value)async{
//         var data = {
//           'to' : value.toString(),
//         'priority' : 'high' ,
//     'notification' :
//         {
//
//           'title' : 'Prachiti',
//           'body' : 'Hello'
//         }
//
//         };
//         await http.host(Uri.parse('https://fcm.googleapis.com/fcm/send'),
//
//         body: jsonEncode(),
//         headers: {
//             'Content-Type': 'application/json',
//             'Authorization' : 'key='
//
//
//             }
//             );
//       }
//     },
//     )
//   );
//   }
// }