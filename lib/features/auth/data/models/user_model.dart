import 'package:equatable/equatable.dart';
import 'package:esl/features/auth/domain/entities/user.dart';
import 'package:floor/floor.dart';

@entity
class UserModel extends Equatable {
  @PrimaryKey(autoGenerate: true)
  final String id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneNumber;
  final String? role;

  const UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'] as String? ?? '',
    firstName: json['firstName'] as String? ?? '',
    lastName: json['lastName'] as String? ?? '',
    email: json['email'] as String? ?? '',
    phoneNumber: json['phoneNumber'] as String? ?? '',
    role: json['role'] as String? ?? '',
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
    'phoneNumber': phoneNumber,
    'role': role,
  };

  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      firstName: user.firstName,
      lastName: user.lastName,
      email: user.email,
      phoneNumber: user.phoneNumber,
      role: user.role,
    );
  }

  User toEntity() {
    return User(
      id: id,
      firstName: firstName ?? '',
      lastName: lastName ?? '',
      email: email ?? '',
      phoneNumber: phoneNumber ?? '',
      role: role ?? '',
    );
  }

  @override
  List<Object?> get props => [
    id,
    firstName,
    lastName,
    email,
    phoneNumber,
    role,
  ];
}
