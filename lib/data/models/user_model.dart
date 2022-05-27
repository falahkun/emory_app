import 'package:emory_app/domain/entities/user_entity.dart';

class UserModel {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;

  /// userModel constructor
  const UserModel(
      {required this.id,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.avatar});

  const UserModel.fill({
    this.id = 0,
    required this.avatar,
    required this.email,
    required this.firstName,
    required this.lastName,
  });

  /// factory untuk membuat object usermodel secara otomatis dari json
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'],
      email: json['email'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      avatar: json['avatar'] ?? '');

  /// factory untuk membuat object usermodel secara otomatis dari user entity
  factory UserModel.fromEntity(UserEntity user) => UserModel(
      id: user.id,
      email: user.email,
      firstName: user.firstName,
      lastName: user.lastName,
      avatar: user.avatar);

  /// function [toEntity] untuk generate dari Model ke Entity secara otomatis
  UserEntity toEntity() => UserEntity(
      id: id,
      email: email,
      firstName: firstName,
      lastName: lastName,
      avatar: avatar);

  /// function [toJson] untuk generate Map object dari class UserModel
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['id'] = id;
    data['email'] = email;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['avatar'] = avatar;
    return data;
  }
}
