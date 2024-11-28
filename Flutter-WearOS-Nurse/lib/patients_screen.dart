import 'package:flutter/material.dart';
import 'model/user_model.dart';

class PatientListScreen extends StatelessWidget {
  const PatientListScreen({super.key});
  static List<UserModel> users = [
    UserModel(
      userType: 'patient',
      name: 'John Doe',
      age: 17,
      wardNumber: 103,
      disorder: 'Anxiety',
      nurse: 'Nurse Alice',
      latitude: 12.842758,
      longitude: 80.157516,
      alertMessage: 'Doctor appointment at 3pm',
    ),
    UserModel(
      userType: 'patient',
      name: 'Jane Smith',
      age: 18,
      wardNumber: 104,
      disorder: 'Depression',
      nurse: 'Nurse Bob',
      latitude: 12.841777,
      longitude: 80.157378,
    ),
    UserModel(
      userType: 'patient',
      name: 'Tom White',
      age: 19,
      wardNumber: 105,
      disorder: 'PTSD',
      nurse: 'Nurse Clara',
      latitude: 12.842110,
      longitude: 80.155785,
      alertMessage: 'Medication checkup at 4pm',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height > 250
        ? 250
        : MediaQuery.of(context).size.height;
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
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.green,
                toolbarHeight: 40,
                title: const Text(
                  'My Patients',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                ),
                centerTitle: true,
              ),
              body: ListWheelScrollView(
                itemExtent: height * 0.4,
                children: [
                  for (var user in users)
                    Card(
                      color: Colors.grey[200],
                      margin: EdgeInsets.symmetric(
                          horizontal: width * 0.08, vertical: height * 0.02),
                      child: ListTile(
                        leading: const Icon(Icons.person),
                        title: Text(
                          user.name,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ward: ${user.wardNumber}\nDisorder: ${user.disorder}\nAge: ${user.age}',
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        isThreeLine: true,
                        onTap: () {
                          // Handle patient details on tap
                        },
                      ),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
