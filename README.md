# Psytrack - Smart Watch for Mental Health Patients

Psytrack is an innovative WearOS-based solution designed to help mental health professionals monitor and support their patients through smart watch technology. The system consists of two main applications: one for patients and another for healthcare providers.

## Project Components

### 1. Patient Application (Flutter-WearOS-Patient)

A WearOS application designed for mental health patients that provides:

- Real-time location tracking
- Blood pressure monitoring
- Heart rate monitoring
- Emergency alert system
- Patient health status visualization

### 2. Healthcare Provider Application (Flutter-WearOS-Nurse)

A companion WearOS application for healthcare providers that offers:

- Real-time patient location monitoring
- Patient health status alerts
- Emergency response coordination
- Patient schedule management
- Alert history tracking

## Technical Stack

- **Framework:** Flutter (^3.19.2)
- **SDK:** Dart (^3.3.0)
- **Key Dependencies:**
  - `geolocator`: Real-time location tracking
  - `google_maps_flutter`: Map visualization
  - `firebase_core & firebase_database`: Real-time data synchronization
  - `hooks_riverpod`: State management
  - `location`: Enhanced location services
  - `permission_handler`: Device permissions management (Patient app)

## Features

- **Real-time Location Tracking**: Continuous monitoring of patient location with different status indicators
- **Health Monitoring**: Track vital signs including blood pressure and heart rate
- **Emergency Alert System**: Quick access to emergency assistance
- **Secure Data Sync**: Real-time data synchronization between patient and healthcare provider devices
- **Intuitive UI**: Material Design-based interface optimized for WearOS devices

## Getting Started

### Prerequisites

- Flutter SDK (^3.19.2)
- Dart SDK (^3.3.0)
- Android Studio with WearOS emulator or physical WearOS device
- Firebase account and project setup

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/psytrack-smart-watch.git
   ```

2. Install dependencies for both applications:
   ```bash
   cd Flutter-WearOS-Patient
   flutter pub get
   
   cd ../Flutter-WearOS-Nurse
   flutter pub get
   ```

3. Configure Firebase:
   - Create a new Firebase project
   - Add Android apps in Firebase console
   - Download and add google-services.json to respective app directories
   - Enable Realtime Database in Firebase console

4. Run the applications:
   ```bash
   flutter run
   ```

## Project Structure

```
├── Flutter-WearOS-Nurse/    # Healthcare provider application
│   ├── lib/
│   │   ├── alert_list_screen.dart
│   │   ├── alert_screen.dart
│   │   ├── patients_screen.dart
│   │   ├── schedule_screen.dart
│   │   └── services/
│   └── assets/
│
├── Flutter-WearOS-Patient/   # Patient application
│   ├── lib/
│   │   ├── alert_screen.dart
│   │   ├── bp_screen.dart
│   │   ├── no_pulse_screen.dart
│   │   └── services/
│   └── assets/
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Flutter team for the excellent WearOS support
- Firebase for real-time data synchronization
- All contributors who help improve this project
