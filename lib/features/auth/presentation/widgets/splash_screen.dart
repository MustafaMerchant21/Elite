import 'package:flutter/material.dart';
import 'package:elite/core/constants.dart';
import 'package:elite/core/theme/palette.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            LoadingAnimationWidget.halfTriangleDot(
            color: Colors.white,
            size: 30,
          ),
            const SizedBox(height: 40),
            Image.asset(
              '$imgPath/logo white.png',
              width: 150,
              height: 150,
            ),
          ],
        ),
      ),
    );
  }
}
