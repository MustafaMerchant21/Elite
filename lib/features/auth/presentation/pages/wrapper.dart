import 'package:elite/core/theme/palette.dart';
import 'package:elite/features/Admin/Admin%20Dashboard/presentation/pages/admin_dashboard_page.dart';
import 'package:elite/features/Admin/Admin%20Dashboard/presentation/pages/admin_main.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'signup_page.dart';
import 'onboarding.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  Future<bool> _checkOnboardingSeen() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('onboardingSeen') ?? false; // ?? is "if-null" operator
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkOnboardingSeen(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: LoadingAnimationWidget.halfTriangleDot(
              color: AppPalette.textColor, size: 30));
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading app'));
        } else {
          if (snapshot.data == false) {
            return const Onboarding();
          } else {
            return StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.uid == 'bgC5H0OFYJfgNed6Mg766zt4Fmd2'){
                    return const AdminMain();
                  }
                  return const HomePage();
                } else if (snapshot.connectionState == ConnectionState.waiting){
                  return LoadingAnimationWidget.halfTriangleDot(
                      color: AppPalette.textColor, size: 30);
                } else {
                  return const SignupPage();
                }
              },
            );
          }
        }
      },
    );
  }
}
