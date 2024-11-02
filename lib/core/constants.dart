import 'dart:ui';

import 'package:elite/core/theme/palette.dart';
import 'package:elite/features/Admin/Admin%20Dashboard/presentation/pages/admin_settings_page.dart';
import 'package:flutter/material.dart';

const String imgPath = 'assets/images';
const String font = 'Britanica';

Route createRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var offsetAnimation = animation
          .drive(Tween(begin: begin, end: end).chain(CurveTween(curve: curve)));

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}

AppBar appbar(BuildContext context, String title) => AppBar(
      elevation: 0,
      backgroundColor: AppPalette.backgroundColor.withAlpha(200),
      title: Text(
        title,
        style: const TextStyle(fontFamily: "$font Expanded Heavy", fontSize: 15),
      ),
      scrolledUnderElevation: 0.0,
      surfaceTintColor: Colors.transparent,
      forceMaterialTransparency: true,
      flexibleSpace: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            color: Colors.transparent,
            child: const FlexibleSpaceBar(),
          ),
        ),
      ),
      centerTitle: true,
      foregroundColor: AppPalette.textColor,
      actions: [
        IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => const AdminSettingsPage()),
              );
            },
            splashRadius: 10,
            tooltip: "Settings",
            padding: const EdgeInsets.all(16),
            icon: const Icon(Icons.settings))
      ],
// bottom: ,
    );
