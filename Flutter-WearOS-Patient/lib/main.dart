import 'dart:async';
import "package:firebase_core/firebase_core.dart";
import "package:firebase_database/firebase_database.dart";
import "package:flutter/material.dart";
import "package:geolocator/geolocator.dart";
import "package:latlong2/latlong.dart";
import "../alert_screen.dart";
import "../bp_screen.dart";
import "../no_pulse_screen.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:permission_handler/permission_handler.dart";

import "services/location_service.dart";

enum Route {
  noPulse,
  geoLocator,
  bp,
  alert;

  String get route => "/$this";
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.phone.request();
  // Start the global navigation timer when the app starts
  GlobalNavigationTimer.instance.startTimer();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      appId: "1:88837193658:android:b58e43f02db3afc341a783",
      apiKey: "AIzaSyDw6-1R8QyDrxQi1WR2JQCCCkVGH-acmVg",
      projectId: "psytrack-2024",
      messagingSenderId: "88837193658",
      databaseURL: "https://psytrack-2024-default-rtdb.firebaseio.com",
      storageBucket: "psytrack-2024.firebasestorage.app",
    ),
  );
  // await _handleLocationPermissionAndGPS();

  // Start background location updates
  // await initializeBackgroundService(); // Initialize the service
  // FlutterBackgroundService().startService();
  runApp(const MyApp());
}

// Future<bool> _handleLocationPermissionAndGPS() async {
//   // Request location permissions
//   if (!await _requestLocationPermission()) {
//     return false;
//   }

//   // Check if GPS is enabled
//   if (!await _isGPSEnabled()) {
//     // Prompt the user to enable GPS
//     return false;
//   }

//   return true;
// }

// Future<bool> _requestLocationPermission() async {
//   var status = await Permission.locationWhenInUse.status;
//   if (!status.isGranted) {
//     status = await Permission.locationWhenInUse.request();
//     if (!status.isGranted) {
//       if (status.isPermanentlyDenied) {
//         await openAppSettings();
//       } else {
//         debugPrint(
//             "Location services are disabled. Please enable the services.");
//       }
//       return false;
//     }
//   }

//   status = await Permission.locationAlways.status;
//   if (!status.isGranted) {
//     status = await Permission.locationAlways.request();
//     if (!status.isGranted) {
//       if (status.isPermanentlyDenied) {
//         await openAppSettings();
//       } else {
//         debugPrint(
//             "Location services are disabled. Please enable the services.");
//       }
//       return false;
//     }
//   }

//   return true;
// }

// Future<bool> _isGPSEnabled() async {
//   bool serviceEnabled;
//   LocationPermission permission;

//   // Test if location services are enabled.
//   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!serviceEnabled) {
//     // Location services are not enabled, prompt the user to enable them.
//     debugPrint("GPS is disabled. Please enable the GPS.");

//     return false;
//   }

//   return true;
// }

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // late final Timer timer;

  // List<String> logs = [];

  // Future<void> getLoc() async {
  //   final SharedPreferences sp = await SharedPreferences.getInstance();
  //   await sp.reload();
  //   logs = sp.getStringList('log') ?? [];
  //   if (mounted) {
  //     setState(() {});
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
  //     await getLoc();
  //   });
  // }

  // @override
  // void dispose() {
  //   timer.cancel();
  //   super.dispose();
  // }

  final _locationClient = LocationClient();
  LatLng? _currPosition;
  bool _isServiceRunning = false;

  @override
  void initState() {
    super.initState();
    _locationClient.init();
    _listenLocation();
    Timer.periodic(const Duration(seconds: 3), (_) => _listenLocation());
  }

  void _listenLocation() async {
    if (!_isServiceRunning && await _locationClient.isServiceEnabled()) {
      _isServiceRunning = true;
      _locationClient.locationStream.listen((event) async {
        setState(() {
          _currPosition = event;
        });
        print("Location: $_currPosition");
        if (_currPosition != null) {
          var userId = "-OBdK4jUbqbaOPFI9G6J";
          final ref = FirebaseDatabase.instance.ref("users").child(userId);
          await ref.update({
            "latitude": _currPosition!.latitude,
            "longitude": _currPosition!.longitude,
            "last_updated": DateTime.now().toIso8601String(),
          });
        }
      });
    } else {
      _isServiceRunning = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: "Smart Tracking Patient's Watch",
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.dark,
        ),
        initialRoute: Route.bp.route,
        navigatorKey: GlobalNavigationTimer
            .instance.navigatorKey, // Set the navigator key
        debugShowCheckedModeBanner: false,
        routes: {
          Route.noPulse.route: (BuildContext context) => const NoPulseScreen(),
          Route.bp.route: (BuildContext context) => const BloodPressureScreen(),
          Route.alert.route: (BuildContext context) => const AlertScreen(),
        },
      ),
    );
  }
}

// Singleton class to manage global navigation timer
class GlobalNavigationTimer {
  GlobalNavigationTimer._privateConstructor();
  static final GlobalNavigationTimer instance =
      GlobalNavigationTimer._privateConstructor();

  // Global navigator key to access the navigator from anywhere in the app
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Timer? _timer;

  // Start a 1-minute timer for navigation
  void startTimer() {
    _timer = Timer(Duration(minutes: 1), () {
      // Use navigator key to push a new screen when the timer completes
      navigatorKey.currentState?.push(
        MaterialPageRoute(builder: (context) => const AlertScreen()),
      );
    });
  }

  void snoozeTimer() {
    _timer = Timer(Duration(minutes: 1), () {
      // Use navigator key to push a new screen when the timer completes
      navigatorKey.currentState?.push(
        MaterialPageRoute(builder: (context) => const AlertScreen()),
      );
    });
  }

  void cancelTimer() {
    _timer?.cancel();
  }
}
