class User {
  String fullName;
  String email;
  String avatarUrl;

  User({
    required this.fullName,
    required this.email,
    required this.avatarUrl,
  });

  factory User.fromFireStore(Map<String, dynamic> fireStore) {
    return User(
      fullName: fireStore['fullName'] ?? '',
      email: fireStore['email'] ?? '',
      avatarUrl: fireStore['avatarUrl'] ?? '',
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'email': email,
      'avatarUrl': avatarUrl,
    };
  }
}