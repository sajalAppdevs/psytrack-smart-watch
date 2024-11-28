import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../alert_screen.dart';
import '../main.dart';
import '../model/user_model.dart';

class BackgroundRestrictedAreaService {
  // Last alert timestamp to control the 1-minute gap
  DateTime? _lastAlertTime;

  // Define restricted location
  final LatLng restrictedLocation = const LatLng(12.844046, 80.155027); // AB3
  // 12.842293, 80.157097 -> Near my room
  // 12.842526, 80.157959 -> B to C block pathway
  // 12.843026, 80.156539 -> AB2

  final double restrictedRadius = 20.0; // 20 meters radius

  static final BackgroundRestrictedAreaService _instance =
      BackgroundRestrictedAreaService._internal();
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref("users");

  // Singleton pattern to ensure only one instance
  factory BackgroundRestrictedAreaService() => _instance;
  BackgroundRestrictedAreaService._internal();

  // Method to start listening for user location changes
  void startMonitoring(BuildContext context) {
    _databaseRef.onValue.listen((DatabaseEvent event) {
      if (event.snapshot.exists) {
        // Explicitly cast the Firebase data to Map<String, dynamic>
        final usersData = Map<String, dynamic>.from(
            event.snapshot.value as Map<Object?, Object?>);

        usersData.forEach((key, value) {
          // Parse user data into UserModel

          final user = UserModel(
            userType: value['userType'],
            name: value['name'],
            age: value['age'],
            wardNumber: value['wardNumber'],
            disorder: value['disorder'],
            nurse: value['nurse'],
            latitude: value['latitude'],
            longitude: value['longitude'],
            alertMessage: value['alertMessage'],
          );
          // Simulating periodic checks (every 1 second in this case)
          Timer.periodic(const Duration(seconds: 1), (timer) {
            _checkForRestrictedArea(context, user);
          });
          _checkForRestrictedArea(context, user);
        });
      }
    });
  }

  // Restricted area check function
  void _checkForRestrictedArea(BuildContext context, UserModel user) {
    final double distance = Geolocator.distanceBetween(
      user.latitude,
      user.longitude,
      restrictedLocation.latitude,
      restrictedLocation.longitude,
    );

    // Check if the user is within the restricted area
    if (distance <= restrictedRadius) {
      // Only show the alert if 1 minute has passed since the last alert
      if (_shouldShowAlert()) {
        _showRestrictedAreaAlert();
      }
    }
  }

  // Determine if an alert should be shown (1-minute gap)
  bool _shouldShowAlert() {
    final currentTime = DateTime.now();

    if (_lastAlertTime == null ||
        currentTime.difference(_lastAlertTime!).inMinutes >= 1) {
      // Update the last alert time and allow showing the alert
      _lastAlertTime = currentTime;
      return true;
    }
    // Do not show alert if it's less than 1 minute since the last alert
    return false;
  }

  // Show the alert screen (using the global navigator key)
  void _showRestrictedAreaAlert() {
    if (navigatorKey.currentState != null) {
      navigatorKey.currentState?.push(MaterialPageRoute(
        builder: (context) => const AlertScreen(),
      ));
    }
  }
}
