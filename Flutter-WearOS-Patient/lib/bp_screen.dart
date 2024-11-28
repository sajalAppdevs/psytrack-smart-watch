import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'dart:async';
import 'dart:math';
import 'no_pulse_screen.dart';

class BloodPressureScreen extends StatefulWidget {
  const BloodPressureScreen({super.key});

  @override
  State<BloodPressureScreen> createState() => _BloodPressureScreenState();
}

class _BloodPressureScreenState extends State<BloodPressureScreen> {
  String systolic = '--';
  String diastolic = '--';
  String heartRate = '--';
  bool isLoading = false;
  final _random = Random();

  late Timer timer;

  @override
  void initState() {
    super.initState();
    // _requestLocationPermission();
    Future.delayed(const Duration(seconds: 2));
    fetchBloodPressure();
    timer = Timer.periodic(
        const Duration(seconds: 5), (Timer t) => fetchBloodPressure());
  }

  // Future<void> _requestLocationPermission() async {
  //   LocationPermission permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //   }
  //   if (permission == LocationPermission.deniedForever) {
  //     print("Location permissions are permanently denied.");
  //   }
  // }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  // Simulated function to fetch blood pressure data
  Future<void> fetchBloodPressure() async {
    int fetchedSystolic = 110 + _random.nextInt(120 - 110); // systolic value
    int fetchedDiastolic = 70 + _random.nextInt(80 - 70); // diastolic value
    int heartBeats = 80 + _random.nextInt(90 - 80); // heart rate value

    setState(() {
      systolic = fetchedSystolic.toString();
      diastolic = fetchedDiastolic.toString();
      heartRate = heartBeats.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width > 300
              ? 300
              : MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black,
          ),
          child: Center(
            child: GestureDetector(
              onTap: () {
                // Navigate to NoPulseScreen when tapped, when heart rate is zero
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const NoPulseScreen()));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SYS and DIA labels
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'SYS',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 17,
                        ),
                      ),
                      Text(
                        'DIA',
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                  // Blood pressure readings (e.g., 133/88)
                  Text(
                    '$systolic / $diastolic',
                    style: const TextStyle(
                      fontSize: 36,
                      color: Colors.white,
                    ),
                  ),
                  // Unit label (mmHg)
                  const Text(
                    'mmHg',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/heartbeat.gif',
                        width: 24,
                        height: 24,
                      ),
                      SizedBox(width: 5),
                      Text(
                        '$heartRate bpm',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
