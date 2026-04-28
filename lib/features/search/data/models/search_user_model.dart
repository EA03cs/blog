class SearchUserModel {
  final int id;
  final String firstName;
  final String middleName;
  final String lastName;
  final String email;
  final String? dob;
  final String gender;

  SearchUserModel({
    required this.id,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.email,
    this.dob,
    required this.gender,
  });

  factory SearchUserModel.fromJson(Map<String, dynamic> json) {
    return SearchUserModel(
      id: json['u_id'],
      firstName: json['u_firstname'],
      middleName: json['u_middlename'],
      lastName: json['u_lastname'],
      email: json['u_email'],
      dob: json['u_DOB'],
      gender: json['u_gender'] ?? 'male',
    );
  }
}
