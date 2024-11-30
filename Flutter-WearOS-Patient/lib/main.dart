import 'dart:async';
import "package:firebase_core/firebase_core.dart";
import "package:firebase_database/firebase_database.dart";
import "package:flutter/material.dart";
import "package:latlong2/latlong.dart";
import "package:psytrack_patient/secret_data.dart";
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
  GlobalNavigationTimer.instance.startTimer();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      appId: "1:88837193658:android:b58e43f02db3afc341a783",
      apiKey: apiKey,
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
