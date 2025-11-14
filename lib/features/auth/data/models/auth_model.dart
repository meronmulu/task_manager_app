// auth_model.dart
import 'package:task_manager_app/features/auth/domain/entities/auth_entities.dart';

class AuthModel extends AuthEntities {
  final String? token;

  AuthModel({
    required super.userId,
    required super.name,
    required super.email,
    required super.role,
    required super.password,
    required super.createdAt,
    required super.updatedAt,
    this.token,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      userId: json['userId'] is int
          ? json['userId']
          : int.tryParse(json['userId'].toString()) ?? 0,
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      password: json['password']?.toString() ?? '',
      role: json['role']?.toString() ?? '',
      createdAt:
          DateTime.tryParse(json['createdAt'].toString()) ?? DateTime.now(),
      updatedAt:
          DateTime.tryParse(json['updatedAt'].toString()) ?? DateTime.now(),
      token: json['token']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "name": name,
    "email": email,
    "password": password,
    "role": role,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "token": token,
  };
}
