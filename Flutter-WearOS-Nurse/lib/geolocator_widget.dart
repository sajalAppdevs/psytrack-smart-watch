import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'geolocator_provider.dart';
import 'model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'services/background_service.dart';

class GeolocatorWidget extends HookConsumerWidget {
  const GeolocatorWidget({super.key});

  // static List<UserModel> sampleUsers = [
  //   UserModel(
  //     userType: 'patient',
  //     name: 'Emily Clark',
  //     age: 20,
  //     wardNumber: 106,
  //     disorder: 'Bipolar Disorder',
  //     nurse: 'Nurse David',
  //     latitude: 12.843026,
  //     longitude: 80.156539,
  //     alertMessage: 'Inside Restricted Area',
  //   ),
  //   UserModel(
  //     userType: 'doctor',
  //     name: 'Dr. Martin',
  //     age: 45,
  //     latitude: 12.841427,
  //     longitude: 80.156682,
  //     alertMessage: 'On call for emergencies',
  //   ),
  // ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final position = ref.watch(geolocatorProvider);

    return Scaffold(
      backgroundColor: Colors.white70,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width > 300
              ? 300
              : MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height > 300
              ? 300
              : MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(300),
            child: StreamBuilder<List<UserModel>>(
              stream: _getUsersFromFirebase(),
              builder: (context, snapshot) {
                // if (snapshot.connectionState == ConnectionState.waiting) {
                //   return const Center(child: CircularProgressIndicator());
                // }

                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }

                final users = snapshot.data ?? [];
                return Scaffold(
                  body: position.when(
                    data: (position) {
                      final currentPosition =
                          LatLng(position.latitude, position.longitude);

                      // Check if the current position is within the restricted area
                      // CheckRestrictedArea()
                      //     .checkForRestrictedArea(context, currentPosition);

                      return GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target:
                              currentPosition, // Set to the current user's position
                          zoom: 17,
                        ),
                        markers: _createMarkers(users, position),
                        circles:
                            _createRestrictedAreaCircle(), // Add restricted area circle
                      );
                    },
                    error: (error, stackTrace) {
                      debugPrint(
                          "The following error occurred: ${error.toString()}");
                      debugPrintStack(stackTrace: stackTrace);
                      return Center(child: Text("Error: ${error.toString()}"));
                    },
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  // Add red glowing circle for restricted area
  Set<Circle> _createRestrictedAreaCircle() {
    return {
      Circle(
        circleId: const CircleId('restricted_area'),
        center: BackgroundRestrictedAreaService().restrictedLocation,
        radius: BackgroundRestrictedAreaService().restrictedRadius,
        strokeColor: Colors.red.withOpacity(0.2),
        fillColor: Colors.red.withOpacity(0.4), // Base opacity
        strokeWidth: 4,
      ),
    };
  }

  // Function to generate map markers from the user list
  Set<Marker> _createMarkers(
      List<UserModel> users, Position currentUserPosition) {
    final userMarkers = users.map((user) {
      // Select the appropriate icon based on the user type
      final icon = user.userType == 'doctor'
          ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)
          : BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);

      return Marker(
        markerId: MarkerId(user.name),
        position: LatLng(
            user.latitude, user.longitude), // Marker position from user data
        icon: icon, // Use the appropriate icon
        infoWindow: InfoWindow(
          title: user.userType == 'doctor'
              ? "${user.name} (Doctor)"
              : "${user.name} (${user.wardNumber})",
          snippet: _getMarkerDescription(user),
        ),
      );
    }).toSet();

    // Add current user marker with a custom rounded icon (could be different from doctor/patient)
    userMarkers.add(
      Marker(
        markerId: const MarkerId('current_user'),
        position:
            LatLng(currentUserPosition.latitude, currentUserPosition.longitude),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: const InfoWindow(
          title: 'Nurse Diksha (You)',
        ),
      ),
    );

    return userMarkers;
  }

  // Function to get the marker description based on the user type
  String _getMarkerDescription(UserModel user) {
    if (user.userType == 'doctor') {
      return user.alertMessage ?? "";
    } else {
      return user.alertMessage ?? 'Disorder: ${user.disorder}';
    }
  }

  // Function to continuously fetch users from Firebase
  Stream<List<UserModel>> _getUsersFromFirebase() {
    return FirebaseDatabase.instance.ref('users').onValue.map((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>? ?? {};
      return data.entries.map((entry) {
        final user = entry.value as Map;
        return UserModel(
          userType: user['userType'],
          name: user['name'],
          age: user['age'],
          wardNumber: user['wardNumber'],
          disorder: user['disorder'],
          nurse: user['nurse'],
          latitude: user['latitude'],
          longitude: user['longitude'],
          alertMessage: user['alertMessage'],
        );
      }).toList();
    });
  }
}
