import 'package:flutter/material.dart';

import 'model/schedule_model.dart';

class ScheduleListView extends StatelessWidget {
  const ScheduleListView({Key? key}) : super(key: key);

  static List<Schedule> sampleSchedules = [
    Schedule(
      patient: 'John Doe',
      wardNumber: '103',
      doctor: 'Dr. Smith',
      doctorRoom: '302, Health Centre',
      time: '3:00pm',
      date: '20-10-2024',
      appointmentType: 'Therapy',
    ),
    Schedule(
      patient: 'Jane Roe',
      wardNumber: '105',
      doctor: 'Dr. Green',
      doctorRoom: '305, Health Centre',
      time: '4:00pm',
      date: '20-10-2024',
      appointmentType: 'Checkup',
    ),
    Schedule(
      patient: 'Alice Blue',
      wardNumber: '106',
      doctor: 'Dr. Wilson',
      doctorRoom: '308, Health Centre',
      time: '11:00am',
      date: '21-10-2024',
      appointmentType: 'Therapy',
    ),
    Schedule(
      patient: 'Bob Brown',
      wardNumber: '108',
      doctor: 'Dr. White',
      doctorRoom: '310, Health Centre',
      time: '2:00pm',
      date: '21-10-2024',
      appointmentType: 'Consultation',
    ),
    Schedule(
      patient: 'Charlie Black',
      wardNumber: '109',
      doctor: 'Dr. Adams',
      doctorRoom: '312, Health Centre',
      time: '9:00am',
      date: '22-10-2024',
      appointmentType: 'Therapy',
    ),
    Schedule(
      patient: 'Eve Green',
      wardNumber: '111',
      doctor: 'Dr. Baker',
      doctorRoom: '315, Health Centre',
      time: '10:00am',
      date: '22-10-2024',
      appointmentType: 'Therapy',
    ),
    Schedule(
      patient: 'Tom White',
      wardNumber: '112',
      doctor: 'Dr. Collins',
      doctorRoom: '317, Health Centre',
      time: '12:00pm',
      date: '22-10-2024',
      appointmentType: 'Checkup',
    ),
    Schedule(
      patient: 'Lucy Grey',
      wardNumber: '114',
      doctor: 'Dr. Murphy',
      doctorRoom: '320, Health Centre',
      time: '1:30pm',
      date: '23-10-2024',
      appointmentType: 'Consultation',
    ),
    Schedule(
      patient: 'Dan Brown',
      wardNumber: '115',
      doctor: 'Dr. Lee',
      doctorRoom: '322, Health Centre',
      time: '11:30am',
      date: '23-10-2024',
      appointmentType: 'Therapy',
    ),
    Schedule(
      patient: 'Sam Red',
      wardNumber: '116',
      doctor: 'Dr. Fox',
      doctorRoom: '325, Health Centre',
      time: '4:30pm',
      date: '23-10-2024',
      appointmentType: 'Checkup',
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
                  '\nPatient Schedules',
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
                  for (var schedule in sampleSchedules)
                    Card(
                      color: Colors.grey[200],
                      margin: EdgeInsets.symmetric(horizontal: width * 0.1),
                      child: ListTile(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: width * 0.05),
                        title: Text(
                          '${schedule.patient} (${schedule.wardNumber})',
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
                              'Appointment: ${schedule.appointmentType}',
                              style: const TextStyle(
                                fontSize: 9,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'Doctor: ${schedule.doctor}',
                              style: const TextStyle(
                                fontSize: 9,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'Venue: ${schedule.doctorRoom}',
                              style: const TextStyle(
                                fontSize: 9,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'Reporting: ${schedule.time}, ${schedule.date}',
                              style: const TextStyle(
                                fontSize: 9,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        isThreeLine: true,
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
