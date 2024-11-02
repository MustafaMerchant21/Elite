import 'package:elite/core/error/failure.dart';
import 'package:elite/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:elite/features/auth/domain/entity/user.dart';

import 'package:fpdart/fpdart.dart';

import 'package:elite/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;

  AuthRepositoryImpl(this.authRemoteDatasource);

  @override
  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password
  }) async {
    try {
      final user = await authRemoteDatasource.loginWithEmailPassword(
          email: email, password: password);
      return right(user);
    } catch (e) {
      return left(Failure(e.toString()));
    }
    // return _getUser(() async => authRemoteDatasource.loginWithEmailPassword(
    //     email: email, password: password));
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password
  }) async {
    return _getUser(() async => authRemoteDatasource.signUpWithEmailPassword(
        name: name, email: email, password: password));
  }

  // Wrapper fn
  Future<Either<Failure, User>> _getUser(Future<User> Function() fn) async {
    try {
      final user = await fn();
      return right(user);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
