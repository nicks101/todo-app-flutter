import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String id;
  final String email;
  final String displayName;
  final String photoURL;
  final String createdAt;
  final String updatedAt;

  UserModel({
    required this.id,
    required this.email,
    required this.displayName,
    required this.photoURL,
    required this.createdAt,
    required this.updatedAt,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? '',
        email = json['email'] ?? '',
        displayName = json['displayName'] ?? '',
        photoURL = json['photoURL'] ?? '',
        createdAt = json['createdAt'] ?? '',
        updatedAt = json['updatedAt'] ?? '';

  UserModel.fromFirebaseUser(User user)
      : id = user.uid,
        email = user.email ?? '',
        displayName = user.displayName ?? '',
        photoURL = user.photoURL ?? '',
        createdAt = user.metadata.creationTime?.toIso8601String() ?? '',
        updatedAt = user.metadata.lastSignInTime?.toIso8601String() ?? '';

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'displayName': displayName,
        'photoURL': photoURL,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };

  UserModel copyWith({
    String? id,
    String? email,
    String? displayName,
    String? photoURL,
    String? createdAt,
    String? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoURL: photoURL ?? this.photoURL,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
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
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        displayName.hashCode ^
        photoURL.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
