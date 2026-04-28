class ProfileModel {
  final String fullName;
  final String email;
  final int id;
  final String dob;

  ProfileModel({
    required this.fullName,
    required this.email,
    required this.id,
    required this.dob,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      fullName: json['fullName'] ?? '',
      email: json['u_email'] ?? '',
      id: json['u_id'] ?? 0,
      dob: json['u_dob'] ?? '',
    );
  }
}
