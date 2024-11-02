import 'package:elite/core/constants.dart';
import 'package:elite/core/theme/palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminDashboardCard extends StatelessWidget {
  final String title;
  final String value;
  const AdminDashboardCard({super.key, required this.title, required this.value});
  static _textStyle({required bool bold}) => TextStyle(
        color: AppPalette.primaryColor,
        fontSize: bold ? 16 : 12,
        fontFamily: bold ? "$font Expanded Heavy" : "$font Semi Expanded Bold",
      );

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        margin:  const EdgeInsets.symmetric(horizontal: 2),
        decoration: const BoxDecoration(
          color: AppPalette.productCardsBackgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: _textStyle(bold: false),
            ),
            Text(
              value,
              style: _textStyle(bold: true),
            )
          ],
        ),
      ),
    );
  }
}
