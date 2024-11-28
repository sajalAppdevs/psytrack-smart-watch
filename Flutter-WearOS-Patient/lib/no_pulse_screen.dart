import 'dart:async';

import 'package:flutter/material.dart';
import 'package:android_intent_plus/android_intent.dart';

class NoPulseScreen extends StatefulWidget {
  const NoPulseScreen({super.key});

  @override
  _NoPulseScreenState createState() => _NoPulseScreenState();
}

class _NoPulseScreenState extends State<NoPulseScreen> {
  int countdown = 20;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  void startCountdown() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) async {
      if (countdown > 1) {
        setState(() {
          countdown--;
        });
      } else {
        t.cancel();
        cancelCountdown();
        AndroidIntent intent = const AndroidIntent(
          action: 'android.intent.action.CALL',
          data: 'tel:+918961549292',
        );
        await intent.launch();
        // Action when countdown reaches zero
      }
    });
  }

  void cancelCountdown() {
    timer?.cancel();
    Navigator.pop(context); // Close the screen when cancel is pressed
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
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
          height: MediaQuery.of(context).size.height > 300
              ? 300
              : MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.redAccent,
                    width: 4,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'No pulse\ndetected',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      height: 1.25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Calling emergency services in ',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      children: [
                        TextSpan(
                          text: '$countdown',
                          style: TextStyle(
                            color: Colors.red[200],
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: cancelCountdown,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
