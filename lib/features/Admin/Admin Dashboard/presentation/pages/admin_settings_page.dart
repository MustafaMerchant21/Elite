import 'package:elite/core/constants.dart';
import 'package:elite/core/theme/palette.dart';
import 'package:flutter/material.dart';

class AdminSettingsPage extends StatefulWidget {
  const AdminSettingsPage({super.key});

  @override
  State<AdminSettingsPage> createState() => _AdminSettingsPageState();
}

class _AdminSettingsPageState extends State<AdminSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppPalette.backgroundColor,
        title: const Text(
          "Settings",
          style: TextStyle(fontFamily: "$font Expanded Heavy", fontSize: 15),
        ),
        centerTitle: true,
        foregroundColor: AppPalette.textColor,
      ),
    );
  }
}
