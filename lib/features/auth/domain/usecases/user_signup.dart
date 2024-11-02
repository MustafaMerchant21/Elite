import 'package:elite/core/error/failure.dart';
import 'package:elite/core/usecase/usecase.dart';
import 'package:elite/features/auth/domain/entity/user.dart';
import 'package:elite/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignup implements UseCase<User, UserSignupParams> {
  final AuthRepository authRepository;
  UserSignup(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserSignupParams params) async{
    return await authRepository.signUpWithEmailPassword(
        name: params.name, email: params.email, password: params.password);
  }
}

class UserSignupParams {
  final String name;
  final String email;
  final String password;

  const UserSignupParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
