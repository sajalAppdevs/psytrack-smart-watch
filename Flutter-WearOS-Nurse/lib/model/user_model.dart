class UserModel {
  final String userType; // "patient" or "doctor"
  final String name;
  final int age;
  final int? wardNumber; // Null for doctors
  final String? disorder; // Null for doctors
  final String? nurse; // Null for doctors
  final double latitude;
  final double longitude;
  final String? alertMessage; // Null if no alert message

  UserModel({
    required this.userType,
    required this.name,
    required this.age,
    this.wardNumber,
    this.disorder,
    this.nurse,
    required this.latitude,
    required this.longitude,
    this.alertMessage,
  });

  // Convert UserModel to a Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'userType': userType,
      'name': name,
      'age': age,
      'wardNumber': wardNumber,
      'disorder': disorder,
      'nurse': nurse,
      'latitude': latitude,
      'longitude': longitude,
      'alertMessage': alertMessage,
    };
  }

  // Construct UserModel from Firestore Document
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userType: map['userType'],
      name: map['name'],
      age: map['age'],
      wardNumber: map['wardNumber'],
      disorder: map['disorder'],
      nurse: map['nurse'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      alertMessage: map['alertMessage'],
    );
  }
}
