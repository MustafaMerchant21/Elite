import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elite/core/error/exceptions.dart';
import 'package:elite/core/error/failure.dart';
import 'package:elite/features/auth/data/datasources/auth_remote_datasource.dart';

import 'package:fpdart/fpdart.dart';

import 'package:elite/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;

  AuthRepositoryImpl(this.authRemoteDatasource);

  @override
  Future<Either<Failure, String>> loginWithEmailPassword({
    required String email,
    required String password
  }) async {
    try {
      final userId = await authRemoteDatasource.loginWithEmailPassword(
          email: email, password: password);
      return right(userId);
    } on ServerException catch (e) {
      return left(Failure("*** ${e.message} ***"));
    }
  }

  @override
  Future<Either<Failure, String>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password
  }) async {
    try {
      final userId = await authRemoteDatasource.signUpWithEmailPassword(
          name: name, email: email, password: password);
      return right(userId);
    } catch (e) {
      return left(Failure("*** ${e.toString()} ***"));
    }
  }
}
