import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elite/core/secrets/app_secrets.dart';
import 'package:elite/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:elite/features/auth/data/repository/auth_repository_impl.dart';
import 'package:elite/features/auth/domain/repository/auth_repository.dart';
import 'package:elite/features/auth/domain/usecases/user_login.dart';
import 'package:elite/features/auth/domain/usecases/user_signup.dart';
import 'package:elite/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
      url: AppSecrets.supabaseUrl, anonKey: AppSecrets.anonKey);
  // Firebase initialization
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseStorage = FirebaseStorage.instance;
  final firebaseFirestore = FirebaseFirestore.instance;

  /// "registerLazySingleton" is called when we need to use the single instance
  /// of that service throughout the app, instead of creating the new instance
  /// every single time "registerFactory".
  serviceLocator..registerLazySingleton(() => supabase)
  ..registerFactory(() => firebaseAuth)
  ..registerFactory(() => firebaseStorage)
  ..registerFactory(() => firebaseFirestore);
}

void _initAuth() {
  /// "registerFactory" is used because we need to create a new instance
  /// of the below services everytime when the user calls this.
  // Datasource
  serviceLocator
    ..registerFactory<AuthRemoteDatasource>(
      () => AuthRemoteDatasourceImpl(
        serviceLocator<FirebaseAuth>(),
        serviceLocator<FirebaseStorage>(),
      ),
    )
    // Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator(),
      ),
    )
    // Usecases
    ..registerFactory(
      () => UserSignup(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserLogin(
        serviceLocator(),
      ),
    )
    // Bloc
    ..registerLazySingleton(
      () => AuthBloc(
        userSignup: serviceLocator<UserSignup>(),
        userLogin: serviceLocator<UserLogin>(),
      ),
    );
}
