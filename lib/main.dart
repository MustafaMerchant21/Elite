import 'package:elite/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:elite/features/auth/presentation/pages/wrapper.dart';
import 'package:elite/features/auth/presentation/widgets/splash_screen.dart';
import 'package:elite/init-dependencies.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:elite/core/theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => serviceLocator<AuthBloc>(),
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
    await Future.delayed(
        const Duration(seconds: 3)); // Adjust the duration if needed
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const Wrapper()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
