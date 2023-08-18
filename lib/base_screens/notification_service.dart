// import 'package:firebase_messaging/firebase_messaging.dart';

// class NotificationService {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

//   void initialize() {
//     _firebaseMessaging.configure(
//       onMessage: (Map<String, dynamic> message) {
//         // Handle notification when app is in the foreground
//         // You can use Flutter's built-in toast or a custom UI to display the notification.
//         print("onMessage: $message");
//       },
//       onLaunch: (Map<String, dynamic> message) {
//         // Handle notification when app is launched from a terminated state
//         print("onLaunch: $message");
//       },
//       onResume: (Map<String, dynamic> message) {
//         // Handle notification when app is resumed from the background
//         print("onResume: $message");
//       },
//     );
//   }
// }
