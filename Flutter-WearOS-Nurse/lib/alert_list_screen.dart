import 'package:flutter/material.dart';

import 'model/alert_model.dart';

class AlertListScreen extends StatelessWidget {
  const AlertListScreen({Key? key}) : super(key: key);

  static List<Alert> sampleAlerts = [
    Alert(
      message: "Patient inside restricted area",
      patient: "John Doe",
      priority: "critical",
    ),
    Alert(
      message: "Scheduled appointment reminder",
      patient: "Jane Roe",
      priority: "normal",
    ),
    Alert(
      message: "Patient missed therapy session",
      patient: "Alice Blue",
      priority: "critical",
    ),
    Alert(
      message: "Regular health checkup reminder",
      patient: "Bob Brown",
      priority: "normal",
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
                  'Alerts',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                centerTitle: true,
              ),
              body: ListWheelScrollView(
                itemExtent: height * 0.35,
                children: [
                  for (var alert in sampleAlerts)
                    Stack(
                      children: [
                        Card(
                          color: alert.priority == "critical"
                              ? Colors.red[100]
                              : Colors.grey[200],
                          margin:
                              EdgeInsets.symmetric(horizontal: width * 0.05),
                          child: ListTile(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: width * 0.05),
                            title: Text(
                              alert.message,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              "Patient: ${alert.patient}",
                              style: const TextStyle(
                                fontSize: 11,
                              ),
                            ),
                            textColor: alert.priority == "critical"
                                ? Colors.red
                                : Colors.black,
                            leading: Icon(
                              alert.priority == "critical"
                                  ? Icons.warning
                                  : Icons.info,
                              color: alert.priority == "critical"
                                  ? Colors.red
                                  : Colors.blue,
                            ),
                          ),
                        ),
                        Positioned(
                          top: height * 0.03,
                          right: width * 0.08,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(4),
                            child: const Icon(
                              Icons.done,
                              color: Colors.white,
                              size: 14,
                            ),
                          ),
                        )
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
