import 'dart:convert';

class UserModel {
  final int uId;
  final String firstName;
  final String middleName;
  final String lastName;
  final String email;
  final String? dob;
  final int confirmEmail;
  final String gender;

  UserModel({
    required this.uId,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.email,
    this.dob,
    required this.confirmEmail,
    required this.gender,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uId: json['u_id'] ?? 0,
      firstName: json['u_firstname'] ?? '',
      middleName: json['u_middlename'] ?? '',
      lastName: json['u_lastname'] ?? '',
      email: json['u_email'] ?? '',
      dob: json['u_DOB'],
      confirmEmail: json['u_confirmEmail'] ?? 0,
      gender: json['u_gender'] ?? 'male',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'u_id': uId,
      'u_firstname': firstName,
      'u_middlename': middleName,
      'u_lastname': lastName,
      'u_email': email,
      'u_DOB': dob,
      'u_confirmEmail': confirmEmail,
      'u_gender': gender,
    };
  }

  String encode() => json.encode(toJson());
  
  factory UserModel.decode(String source) => UserModel.fromJson(json.decode(source));
}
