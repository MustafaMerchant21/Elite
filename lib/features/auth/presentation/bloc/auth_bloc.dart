import 'package:elite/features/auth/domain/usecases/user_login.dart';
import 'package:elite/features/auth/domain/usecases/user_signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignup _userSignup;
  final UserLogin _userLogin;

  AuthBloc({
    required UserSignup userSignup,
    required UserLogin userLogin,
  })  : _userSignup = userSignup,
        _userLogin = userLogin,
        super(AuthInitial()) {
    // SignUp Bloc
    on<AuthSignUp>((event, emit) async {
      // Get user data & fetch the response from the remote database
      final res = await _userSignup(UserSignupParams(
          name: event.name, email: event.email, password: event.password));
      // Based on the response, update the STATE
      res.fold((onLeft) => emit(AuthFailure(onLeft.message)),
          (onRight) => AuthSuccess(onRight));
    });

    // Login Bloc
    on<AuthLogin>((event, emit) async {
      // Get user data & fetch the response from the remote database
      final res = await _userLogin(UserLoginParams(
          email: event.email, password: event.password));
      // Based on the response, update the state
      res.fold((onLeft) => emit(AuthFailure(onLeft.message)),
              (onRight) => emit(AuthSuccess(onRight)));
    });
  }
}
