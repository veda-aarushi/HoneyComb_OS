import 'package:flutter/cupertino.dart';

class Teacher {
  final String uid;         // Unique identifier for the teacher
  final String? firstName;  // First name of the teacher
  final String? lastName;   // Last name of the teacher
  final String? nickName;   // Nickname of the teacher
  final String? email;      // Email address of the teacher

  // Constructor
  Teacher({
    required this.uid,
    this.firstName,
    this.lastName,
    this.nickName,
    this.email,
  });

  // Factory constructor to create a Teacher instance from a JSON map
  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      uid: json['uid'] as String,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      nickName: json['nickName'] as String?,
      email: json['email'] as String?,
    );
  }

  // Method to convert a Teacher instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'nickName': nickName,
      'email': email,
    };
  }

  // String representation for debugging
  @override
  String toString() {
    return 'Teacher(uid: $uid, firstName: $firstName, lastName: $lastName, nickName: $nickName, email: $email)';
  }
}
