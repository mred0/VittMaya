// import 'dart:async';
// import 'dart:convert';
// import 'dart:developer';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// import '../main.dart';
// // import '../network/firebase_notification_response.dart';


// Future<void> _onBackgroundMessageHandler(RemoteMessage message) async {
//   log('on background message handler $message');
//   log(message.data['data'].toString());
// }

// class FirebaseMessagingService {
//   factory FirebaseMessagingService() {
//     return _singleton;
//   }

//   FirebaseMessagingService._internal();
//   static final FirebaseMessagingService _singleton =
//       FirebaseMessagingService._internal();
//   static final FirebaseMessaging _firebaseMessaging =
//       FirebaseMessaging.instance;
//   static String? token;
//   late AndroidNotificationChannel channel;
//   late StreamSubscription<RemoteMessage> onFrontEndStream;
//   late StreamSubscription<RemoteMessage> onOpenAppStream;
//   late StreamSubscription<String> tokenStream;

//   static Future<void> initializeMain() async {
//     await Firebase.initializeApp();
//     token = await FirebaseMessaging.instance.getToken() ?? '';

//     FirebaseMessaging.onBackgroundMessage(_onBackgroundMessageHandler);
//   }

//   Future<void> initialize(
//       Function(FirebaseNotificationResponse response) onMessage) async {
//     await _firebaseMessaging.requestPermission(
//       announcement: true,
//       carPlay: true,
//       criticalAlert: true,
//     );

//     await _onOpenedAppFromTerminateMessage(onMessage);

//     if (!kIsWeb) {
//       channel = const AndroidNotificationChannel(
//         'high_importance_channel', // id
//         'High Importance Notifications', // title
//         description:
//             'This channel is used for important notifications.', // description
//         importance: Importance.high,
//       );

//       const initializationSettingsAndroid =
//           AndroidInitializationSettings('@drawable/ic_notification');
//       // const initializationSettingsAndroid =
//       //     AndroidInitializationSettings('@drawable/ic_notification');

//       // final initializationSettingsIOS = IOSInitializationSettings(
//       //   onDidReceiveLocalNotification: (_, __, ___, ____) async {
//       //     log('IOS NOTIFICATION');
//       //   },
//       // );

//       // final initializationSettings = InitializationSettings(
//       //   android: initializationSettingsAndroid,
//       //   iOS: initializationSettingsIOS,
//       // );

//       // final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//       // await flutterLocalNotificationsPlugin.initialize(
//       //   initializationSettings,
//       //   onSelectNotification: _onOpenedLocalNotification,
//       // );

//       await flutterLocalNotificationsPlugin
//           .resolvePlatformSpecificImplementation<
//               AndroidFlutterLocalNotificationsPlugin>()
//           ?.createNotificationChannel(channel);

//       await _firebaseMessaging.setForegroundNotificationPresentationOptions(
//         alert: true,
//         badge: true,
//         sound: true,
//       );
//       _onFrontEndMessage(flutterLocalNotificationsPlugin);
//     }
//     await _setToken();
//     _onOpenedAppMessage();
//   }

//   Future<void> _onOpenedAppFromTerminateMessage(
//       Function(FirebaseNotificationResponse response) onMessage) async {
//     final initialMessage = await _firebaseMessaging.getInitialMessage();
//     if (initialMessage != null) {
//       final data = json.decode(initialMessage.data['data']);
//       final notification = FirebaseNotificationResponse.fromJson(data);
//       onMessage(notification);
//     }
//   }

//   Future<void> _onOpenedLocalNotification(String? payload) async {
//     if (payload != null) {
//       log(payload.toString());
//       final notification = FirebaseNotificationResponse.fromJson(
//           jsonDecode(jsonDecode(payload)['data']));

//       if (notification.clickAction == "NEW_CHAT") {
//         final user = await Utility.getUser(key: AppString.userPrefKey);
//         if (user != null && notification.userData?.id != null)
//           navigatorKey.currentState?.push(
//             MaterialPageRoute(
//               builder: (context) => ChatDetailScreen(
//                 loginUser: user,
//                 userId: notification.userData!.id!,
//               ),
//             ),
//           );
//       } else if (notification.clickAction == "OPEN_REQUEST") {
//         if (notification.requestNotification?.id != null)
//           navigatorKey.currentState?.push(
//             MaterialPageRoute(
//               builder: (context) => ParcelDetailScreen(
//                 id: notification.requestNotification!.id!,
//                 accepted: false,
//               ),
//             ),
//           );
//       }
//     }
//   }

//   void _onOpenedAppMessage() {
//     FirebaseMessaging.onMessageOpenedApp.listen((message) async {
//       log(message.toString());

//       final notification = FirebaseNotificationResponse.fromJson(
//           jsonDecode(message.data['data']));
//       if (notification.clickAction == "NEW_CHAT") {
//         final user = await Utility.getUser(key: AppString.userPrefKey);
//         if (user != null && notification.userData?.id != null)
//           navigatorKey.currentState?.push(
//             MaterialPageRoute(
//               builder: (context) => ChatDetailScreen(
//                 userId: notification.userData!.id!,
//                 loginUser: user,
//               ),
//             ),
//           );
//       } else if (notification.clickAction == "OPEN_REQUEST") {
//         if (notification.requestNotification?.id != null)
//           navigatorKey.currentState?.push(
//             MaterialPageRoute(
//               builder: (context) => ParcelDetailScreen(
//                 id: notification.requestNotification!.id!,
//               ),
//             ),
//           );
//       }
//     });
//   }

//   void _onFrontEndMessage(
//       FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) {
//     onFrontEndStream = FirebaseMessaging.onMessage.listen((message) {
//       final notification = message.notification;
//       final android = message.notification?.android;
//       log("::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::");
//       if (notification != null && android != null && !kIsWeb) {
//         flutterLocalNotificationsPlugin.show(
//           notification.hashCode,
//           notification.title,
//           notification.body,
//           NotificationDetails(
//             android: AndroidNotificationDetails(
//               channel.id,
//               channel.name,
//               channelDescription: channel.description,
//               icon: '@drawable/ic_notification',
//             ),
//           ),
//           payload: jsonEncode(message.data),
//         );
//       }
//     });
//   }

//   Future _setToken() async {
//     token = await FirebaseMessaging.instance.getToken() ?? '';

//     tokenStream = _firebaseMessaging.onTokenRefresh.listen((newToken) {
//       token = newToken;
//     });
//   }

//   void dispose() {
//     onFrontEndStream.cancel();
//     onOpenAppStream.cancel();
//     tokenStream.cancel();
//   }
// }
