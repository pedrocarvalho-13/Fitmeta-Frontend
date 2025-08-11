class UserProfile {
  final String id;
  final String email;
  final String message;

  UserProfile({
    required this.id,
    required this.email,
    required this.message,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      email: json['email'],
      message: json['message'],
    );
  }
}