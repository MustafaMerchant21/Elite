import 'package:elite/core/error/failure.dart';
import 'package:elite/core/usecase/usecase.dart';
import 'package:elite/features/auth/domain/entity/user.dart';
import 'package:elite/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserLogin implements UseCase<User, UserLoginParams> {
  final AuthRepository authRepository;

  UserLogin(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserLoginParams params) async {
    return await authRepository.loginWithEmailPassword(
        email: params.email, password: params.password);
  }
}

class UserLoginParams {
  final String email;
  final String password;

  const UserLoginParams({
    required this.email,
    required this.password,
  });
}
