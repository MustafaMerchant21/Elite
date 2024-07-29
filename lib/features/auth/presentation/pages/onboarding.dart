import 'package:elite/core/animation/paricle_loader.dart';
import 'package:elite/core/theme/palette.dart';
import 'package:elite/features/auth/presentation/pages/signup_page.dart';
import 'package:elite/features/auth/presentation/pages/wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants.dart';
import 'package:elite/core/theme/palette.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  Future<void> _setOnboardingSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboardingSeen', true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            '$imgPath/back.jpg',
            width: MediaQuery.of(context)
                .size
                .width, // Sets the image to full width
            height: MediaQuery.of(context)
                .size
                .height, // Optionally sets the image to full height
            fit: BoxFit.cover, // Ensures the image covers the whole screen
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0x98000000),
            ),
          ),
          const Center(
            child: RotatedBox(
              quarterTurns: 1,
              child: Text(
                'SHOES ',
                style: TextStyle(
                  fontFamily: '$font Expanded Heavy',
                  color: AppPalette.backgroundColor,
                  fontSize: 150,
                  // fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -(700 * 0.70),
            left: -(700 - (MediaQuery.of(context).size.width)) / 2,
            child: GestureDetector(
              onTap: () async {
                await _setOnboardingSeen();
                // Navigator.push(context, MaterialPageRoute(builder: (context) {
                //   return const SignupPage();
                // }));
                Future.delayed(const Duration(seconds: 1), () {
                  LoadingAnimationWidget.halfTriangleDot(
                      color: AppPalette.textColor, size: 30);
                });

                Navigator.of(context).pushReplacement(
                  CupertinoPageRoute(
                    builder: (context) {
                      return const Wrapper();
                    },
                  ),
                );
              },
              child: Container(
                alignment: Alignment.bottomCenter,
                height: 700,
                width: 700,
                decoration: BoxDecoration(
                  color: AppPalette.textColor,
                  borderRadius: BorderRadius.circular(500),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          "Start",
                          style: TextStyle(
                            fontFamily: '$font Expanded Heavy',
                            color: AppPalette.textColor,
                            fontSize: 60,
                          ),
                        ),
                        Image.asset(
                          '$imgPath/arrow.png',
                          width: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Transform.flip(
              flipX: true,
              child: Image.asset(
                '$imgPath/onboarding shoe.png',
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Center(
          //   child: LoadingAnimationWidget.halfTriangleDot(
          //       color: Colors.black, size: 50),
          // )
        ],
      ),
    );
  }
}
