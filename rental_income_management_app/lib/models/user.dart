import 'package:cloud_firestore/cloud_firestore.dart';

import '../utility/enums.dart';
import '../utility/formatter.dart';

class UserModel {
  final String id;
  String firstName, lastName;
  final String email;
  String phoneNumber;
  int totalRentMonthly;
  int pendingRentDuesMonthly;
  List<String> properties;
  DateTime createdOn, updatedOn;
  // String profilePicture;
  // String userName;
  final Role role;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.totalRentMonthly,
    required this.pendingRentDuesMonthly,
    required this.properties,
    required this.createdOn,
    required this.updatedOn,
    required this.role,
  });

  // Helper function to get full name
  String get fullName => '$firstName $lastName';

  // Helper function to format Phone Number
  String get formattedPhoneNumber => TFormatter.formatPhoneNumber(phoneNumber);

  // static function to split full name into first and last name
  static List<String> nameParts(fullName) => fullName.split(" ");

  // static function to generate the username from  the full name
  static String getUsername(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCaseUserName =
        "$firstName$lastName"; // combine the first name and last name
    String userNameWithPrefix = "cwt_$camelCaseUserName"; // Add cwt_ prefix
    return userNameWithPrefix;
  }

  // static function to create a empty user model
  static UserModel empty() => UserModel(
        id: "",
        firstName: "",
        lastName: "",
        email: "",
        phoneNumber: "",
        pendingRentDuesMonthly: 0,
        totalRentMonthly: 0,
        createdOn: DateTime.now(),
        updatedOn: DateTime.now(),
        properties: [],
        role: Role.visitor,
      );

  // convert model to JSON structure for String data in Firebase
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "phoneNumber": phoneNumber,
      "pendingDueMonthly": pendingRentDuesMonthly,
      "totalRevenueMonthly": totalRentMonthly,
      "createdOn": createdOn,
      "updatedOn": updatedOn,
      "properties": properties,
      "Role": role.toString().split('.').last,
    };
  }

  // Factory method to create a UserModel from Firebase document Snapshot
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        firstName: data["firstName"] ?? "",
        lastName: data["lastName"] ?? "",
        email: data["email"] ?? "",
        phoneNumber: data["phoneNumber"] ?? "",
        role: _roleFromString(data["role"] ?? "visitor"),
        totalRentMonthly: data["totalRentMonthly"] ?? 0,
        pendingRentDuesMonthly: data["pendingRentDuesMonthly"] ?? 0,
        properties: (data["properties"] as List<dynamic>?)?.cast<String>() ?? [],
        createdOn: (data['createdOn'] as Timestamp?)?.toDate() ?? DateTime.now(),
        updatedOn: (data['updatedOn'] as Timestamp?)?.toDate() ?? DateTime.now(),
      );
    }
    return empty();
  }

  // Create UserModel from Map
  factory UserModel.fromJson(Map<String, dynamic> json) { 
    return UserModel(
      id: json['id'],
      firstName: json['FirstName'],
      lastName: json['LastName'],
      email: json['Email'],
      phoneNumber: json['PhoneNumber'],
      role: _roleFromString(json['role']),
      totalRentMonthly: json['totalRentMonthly'],
      pendingRentDuesMonthly: json['pendingRentDuesMonthly'],
      properties: json['properties'],
      createdOn: json['createdOn'],
      updatedOn: json['updatedOn'],
    );
  }

  static Role _roleFromString(String role) {
    switch (role) {
      case 'owner':
        return Role.owner;
      case 'manager':
        return Role.manager;
      case 'admin':
        return Role.admin;
      default:
        return Role.visitor;
    }
  }
}
