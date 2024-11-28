// import 'package:flutter/material.dart';
// import 'package:flutter_background_service/flutter_background_service.dart';
// import 'package:flutter_background_service_android/flutter_background_service_android.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:geolocator/geolocator.dart';

// final service = FlutterBackgroundService();

// Future<void> initializeBackgroundService() async {
//   await service.configure(
//     androidConfiguration: AndroidConfiguration(
//       onStart: onStart, // Pass the top-level function
//       autoStart: true,
//       autoStartOnBoot: true,
//       isForegroundMode: true,
//     ),
//     iosConfiguration: IosConfiguration(
//       onForeground: onStart, // Pass the top-level function
//       autoStart: true,
//     ),
//   );
//   service.startService();
// }

// // Top-level function
// void onStart(ServiceInstance serviceIns) async {
//   // WidgetsFlutterBinding.ensureInitialized();
//   // await Firebase.initializeApp();

//   // if (serviceIns is AndroidServiceInstance) {
//   //   serviceIns.on("stopService").listen((event) {
//   //     serviceIns.stopSelf();
//   //   });

//   //   serviceIns.setForegroundNotificationInfo(
//   //     title: "Location Service Running",
//   //     content: "Updating location in the background...",
//   //   );
//   // }

//   // if (!await Geolocator.isLocationServiceEnabled()) {
//   //   await Geolocator.openLocationSettings();
//   // }

//   // LocationPermission permission = await Geolocator.checkPermission();
//   // if (permission == LocationPermission.denied ||
//   //     permission == LocationPermission.deniedForever) {
//   //   permission = await Geolocator.requestPermission();
//   //   if (permission == LocationPermission.deniedForever) return;
//   // }

//   if (await service.isRunning()) {
//     debugPrint("Service is running");
//   } else {
//     debugPrint("Service is not running");
//   }

//   // const updateInterval = Duration(seconds: 30);

//   // while (await FlutterBackgroundService().isRunning()) {
//   //   try {
//   //     final position = await Geolocator.getCurrentPosition(
//   //       desiredAccuracy: LocationAccuracy.high,
//   //     );

//   //     debugPrint(
//   //         "Location updated: ${position.latitude}, ${position.longitude}");

//   //     final userId = "-OBdKmO_7ktHNFm9DLA2";
//   //     final ref = FirebaseDatabase.instance.ref("users").child(userId);

//   //     await ref.update({
//   //       "latitude": position.latitude,
//   //       "longitude": position.longitude,
//   //       "last_updated": DateTime.now().toIso8601String(),
//   //     });

//   //     debugPrint(
//   //         "Location updated: ${position.latitude}, ${position.longitude}");
//   // } catch (e) {
//   //   debugPrint("Error: $e");
//   // }

//   //   await Future.delayed(updateInterval);
//   // }
// }

// // import 'package:flutter/material.dart';
// // import 'package:flutter_background_service/flutter_background_service.dart';
// // import 'package:flutter_background_service_android/flutter_background_service_android.dart';
// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:firebase_database/firebase_database.dart';
// // import 'package:geolocator/geolocator.dart';

// // final service = FlutterBackgroundService();

// // Future<void> initializeBackgroundService() async {
// //   await service.configure(
// //     androidConfiguration: AndroidConfiguration(
// //       onStart: onStart,
// //       isForegroundMode: true,
// //       autoStart: true,
// //       notificationChannelId: "location_tracking",
// //       initialNotificationTitle: "Location Service Running",
// //       initialNotificationContent: "Updating location in the background...",
// //       foregroundServiceNotificationId: 888,
// //     ),
// //     iosConfiguration: IosConfiguration(
// //       onForeground: onStart,
// //       autoStart: true,
// //     ),
// //   );
// //   service.startService();
// // }

// // void onStart(ServiceInstance serviceIns) async {
// //   if (serviceIns is AndroidServiceInstance) {
// //     serviceIns.on("stopService").listen((event) {
// //       serviceIns.stopSelf();
// //     });
// //   }

// //   // Ensure Firebase is initialized
// //   await Firebase.initializeApp();

// //   // Check location permissions
// //   bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
// //   if (!serviceEnabled) {
// //     await Geolocator.openLocationSettings();
// //   }

// //   LocationPermission permission = await Geolocator.checkPermission();
// //   if (permission == LocationPermission.denied ||
// //       permission == LocationPermission.deniedForever) {
// //     permission = await Geolocator.requestPermission();
// //   }

// //   const updateInterval =
// //       Duration(seconds: 30); // Update location every 30 seconds

// //   // Periodically fetch and update location
// //   while (await service.isRunning()) {
// //     final position = await Geolocator.getCurrentPosition(
// //       desiredAccuracy: LocationAccuracy.high,
// //     );

// //     debugPrint("Location Update Starting...");
// //     String userId = "-OBdKmO_7ktHNFm9DLA2"; // Replace with the user-specific ID
// //     DatabaseReference ref =
// //         FirebaseDatabase.instance.ref("users").child(userId);
// // // debugPrint("Lo")
// //     // debugPrint("User: " + (await ref.get()).value.toString());
// //     await ref.update({
// //       // "latitude": position.latitude,
// //       // "longitude": position.longitude,
// //       "last_updated": DateTime.now().toIso8601String(),
// //     });
// //     debugPrint("Location Update Finished!");

// //     await Future.delayed(updateInterval);
// //   }
// // }
