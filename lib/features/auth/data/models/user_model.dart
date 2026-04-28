class UserModel {
  final int uId;
  final String firstName;
  final String middleName;
  final String lastName;
  final String email;
  final String dob;
  final int confirmEmail;
  final String gender;

  UserModel({
    required this.uId,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.email,
    required this.dob,
    required this.confirmEmail,
    required this.gender,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uId: json['u_id'],
      firstName: json['u_firstname'],
      middleName: json['u_middlename'],
      lastName: json['u_lastname'],
      email: json['u_email'],
      dob: json['u_DOB'],
      confirmEmail: json['u_confirmEmail'],
      gender: json['u_gender'],
    );
  }
}
