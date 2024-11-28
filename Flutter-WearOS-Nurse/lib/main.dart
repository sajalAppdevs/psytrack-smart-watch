import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "alert_list_screen.dart";
import "geolocator_widget.dart";
import "patients_screen.dart";
import "schedule_screen.dart";

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import "services/background_service.dart";

enum Route {
  mainMenu,
  patient,
  geoLocator,
  schedule,
  alert;

  String get route => "/$this";
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Start the background monitoring when the app starts
    BackgroundRestrictedAreaService().startMonitoring(context);
    return ProviderScope(
      child: MaterialApp(
        navigatorKey: navigatorKey, // Set the global key here
        title: "Smart Tracking Watch",
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.dark,
        ),
        initialRoute: Route.mainMenu.route,
        debugShowCheckedModeBanner: false,
        routes: {
          Route.mainMenu.route: (BuildContext context) => const MainMenu(),
          Route.patient.route: (BuildContext context) =>
              const PatientListScreen(),
          Route.geoLocator.route: (BuildContext context) =>
              const GeolocatorWidget(),
          Route.schedule.route: (BuildContext context) =>
              const ScheduleListView(),
          Route.alert.route: (BuildContext context) => const AlertListScreen(),
        },
      ),
    );
  }
}

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: SafeArea(
        child: Center(
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Container(
                            color: Colors.amber,
                            padding: const EdgeInsets.only(top: 30, left: 10),
                            child: const PackageButton(
                              text: "Patients",
                              route: Route.patient,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(top: 30, right: 10),
                            color: Colors.cyan,
                            child: const PackageButton(
                              text: "Location",
                              route: Route.geoLocator,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Container(
                            color: Colors.lightGreen,
                            padding:
                                const EdgeInsets.only(bottom: 30, left: 10),
                            child: const PackageButton(
                              text: "Schedule",
                              route: Route.schedule,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            color: Colors.pinkAccent,
                            padding:
                                const EdgeInsets.only(bottom: 30, right: 10),
                            child: const PackageButton(
                              text: "Alerts",
                              route: Route.alert,
                            ),
                          ),
                        ),
                      ],
                    ),
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

class PackageButton extends StatelessWidget {
  final String text;
  final Route route;

  const PackageButton({super.key, required this.text, required this.route});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(Colors.white),
      ),
      onPressed: () {
        Navigator.of(context).pushNamed(route.route);
      },
      child: Text(text),
    );
  }
}

class FlutterWearOSLocation extends StatelessWidget {
  const FlutterWearOSLocation({super.key}) : super();

  @override
  Widget build(BuildContext context) {
    return const Card(
      color: Colors.white,
      child: Center(
        child: Card(
          elevation: 4,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: GeolocatorWidget(),
          ),
        ),
      ),
    );
  }
}
