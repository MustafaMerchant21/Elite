import 'package:elite/core/constants.dart';
import 'package:elite/core/theme/palette.dart';
import 'package:flutter/material.dart';

class AdminUsersPage extends StatefulWidget {
  const AdminUsersPage({super.key});

  @override
  State<AdminUsersPage> createState() => _AdminUsersPageState();
}

class _AdminUsersPageState extends State<AdminUsersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppPalette.backgroundColor,
        title: const Text(
          "Users",
          style: TextStyle(fontFamily: "$font Expanded Heavy", fontSize: 15),
        ),
        centerTitle: true,
        foregroundColor: AppPalette.textColor,
        leading: IconButton(
          constraints: BoxConstraints(),
          icon: Icon(Icons.arrow_back_rounded, color: AppPalette.primaryColor,),
          onPressed: () => Navigator.of(context).pop(),
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(
                  AppPalette.productCardsBackgroundColor),
          ),
        ),
      ),
    );
  }
}
