import 'package:elite/core/constants.dart';
import 'package:elite/core/theme/palette.dart';
import 'package:flutter/material.dart';

class AdminAnalyticsPage extends StatefulWidget {
  const AdminAnalyticsPage({super.key});

  @override
  State<AdminAnalyticsPage> createState() => _AdminAnalyticsPageState();
}

class _AdminAnalyticsPageState extends State<AdminAnalyticsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: AppPalette.backgroundColor,
      title: const Text(
        "Analytics",
        style: TextStyle(fontFamily: "$font Expanded Heavy", fontSize: 15),
      ),
      centerTitle: true,
      foregroundColor: AppPalette.textColor,
    ),
    );
  }
}
