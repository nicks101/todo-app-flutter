import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String id;
  final String email;
  final String displayName;
  final String photoURL;
  final String createdAt;
  final String updatedAt;
  final String city;
  final String pinCode;

  UserModel({
    required this.id,
    required this.email,
    required this.displayName,
    required this.photoURL,
    required this.createdAt,
    required this.updatedAt,
    this.city = '',
    this.pinCode = '',
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? '',
        email = json['email'] ?? '',
        displayName = json['displayName'] ?? '',
        photoURL = json['photoURL'] ?? '',
        createdAt = json['createdAt'] ?? '',
        updatedAt = json['updatedAt'] ?? '',
        city = json['city'] ?? '',
        pinCode = json['pinCode'] ?? '';

  UserModel.fromFirebaseUser(User user)
      : id = user.uid,
        email = user.email ?? '',
        displayName = user.displayName ?? '',
        photoURL = user.photoURL ?? '',
        createdAt = user.metadata.creationTime?.toIso8601String() ?? '',
        updatedAt = user.metadata.lastSignInTime?.toIso8601String() ?? '',
        city = '',
        pinCode = '';

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'displayName': displayName,
        'photoURL': photoURL,
        'createdAt': createdAt,
        'updatedAt': DateTime.now().toIso8601String(),
        'city': city,
        'pinCode': pinCode,
      };

  Map<String, dynamic> fromFirebaseUserToMap(User user) => {
        'id': user.uid,
        'email': user.email,
        'displayName': user.displayName,
        'photoURL': user.photoURL,
        'createdAt': user.metadata.creationTime?.toIso8601String(),
        'updatedAt': DateTime.now().toIso8601String(),
      };

  UserModel copyWith({
    String? id,
    String? email,
    String? displayName,
    String? photoURL,
    String? createdAt,
    String? updatedAt,
    String? city,
    String? pinCode,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoURL: photoURL ?? this.photoURL,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      city: city ?? this.city,
      pinCode: pinCode ?? this.pinCode,
    );
  }

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, displayName: $displayName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.email == email &&
        other.displayName == displayName &&
        other.photoURL == photoURL &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.city == city &&
        other.pinCode == pinCode;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        displayName.hashCode ^
        photoURL.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        city.hashCode ^
        pinCode.hashCode;
  }
}
