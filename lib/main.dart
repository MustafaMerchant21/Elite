import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elite/core/secrets/app_secrets.dart';
import 'package:elite/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:elite/features/auth/data/repository/auth_repository_impl.dart';
import 'package:elite/features/auth/domain/usecases/user_login.dart';
import 'package:elite/features/auth/domain/usecases/user_signup.dart';
import 'package:elite/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:elite/features/auth/presentation/pages/wrapper.dart';
import 'package:elite/features/auth/presentation/widgets/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:elite/core/theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'features/auth/presentation/pages/onboarding.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Supabase initialization
  final supabase = await Supabase.initialize(
      url: AppSecrets.supabaseUrl, anonKey: AppSecrets.anonKey);
  // Firebase initialization
  await Firebase.initializeApp();
  final firebaseAuth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => AuthBloc(
          userSignup: UserSignup(
            AuthRepositoryImpl(
              AuthRemoteDatasourceImpl(firebaseAuth),
            ),
          ),
          userLogin: UserLogin(
          AuthRepositoryImpl(
            AuthRemoteDatasourceImpl(firebaseAuth)
          )
        ),
        ),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Elite',
      theme: AppTheme.lightThemeMode,
      home: const SplashScreenWrapper(),
    );
  }
}

class SplashScreenWrapper extends StatefulWidget {
  const SplashScreenWrapper({super.key});

  @override
  _SplashScreenWrapperState createState() => _SplashScreenWrapperState();
}

class _SplashScreenWrapperState extends State<SplashScreenWrapper> {
  @override
  void initState() {
    super.initState();
    _navigateToWrapper();
  }

  Future<void> _navigateToWrapper() async {
    await Future.delayed(const Duration(seconds: 3)); // Adjust the duration if needed
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const Wrapper()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
