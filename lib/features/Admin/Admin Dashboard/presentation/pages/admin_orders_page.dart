import 'package:elite/core/constants.dart';
import 'package:elite/core/theme/palette.dart';
import 'package:flutter/material.dart';

class AdminOrdersPage extends StatefulWidget {
  const AdminOrdersPage({super.key});

  @override
  State<AdminOrdersPage> createState() => _AdminOrdersPageState();
}

class _AdminOrdersPageState extends State<AdminOrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppPalette.backgroundColor,
        title: const Text(
          "Orders",
          style: TextStyle(fontFamily: "$font Expanded Heavy", fontSize: 15),
        ),
        centerTitle: true,
        foregroundColor: AppPalette.textColor,
      ),
    );
  }
}
