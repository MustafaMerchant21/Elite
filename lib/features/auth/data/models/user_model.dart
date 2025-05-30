import 'package:elite/features/auth/data/models/user_model.dart';
import 'package:elite/features/auth/domain/entity/user.dart';

class UserModel extends User {
  UserModel({required super.id, required super.email, required super.name});

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
        id: map['id'] ?? '',
        email: map['email'] ?? '',
        name: map['name' ?? '']
    );
  }
}
