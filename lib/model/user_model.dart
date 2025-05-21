class AppUser{
  final String uid;
  final String name;
  final String email;
  final String phone;
  final String avatarUrl;

  AppUser({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.avatarUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phone': phone,
      'avatarUrl': avatarUrl,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      avatarUrl: map['avatarUrl'] ?? '',
    );
  }
}
