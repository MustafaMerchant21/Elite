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
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppPalette.backgroundColor,
            title: const Text(
              "Users",
              style:
                  TextStyle(fontFamily: "$font Expanded Heavy", fontSize: 15),
            ),
            centerTitle: true,
            foregroundColor: AppPalette.textColor,
            leading: IconButton(
              constraints: const BoxConstraints(),
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: AppPalette.primaryColor,
              ),
              onPressed: () => Navigator.of(context).pop(),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(
                    AppPalette.productCardsBackgroundColor),
              ),
            ),
          ),
          body: Column(
            children: [
              // Search Bar
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  style: TextStyle(
                    fontFamily: "$font Semi Expanded Black",
                    color: AppPalette.primaryColor,
                  ),
                  onTapOutside: (PointerDownEvent event) {
                    FocusScope.of(context).unfocus();
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search, color: AppPalette.textColor),
                    hintText: 'Search users...',
                    filled: true,
                    fillColor: AppPalette.backgroundColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                          color: AppPalette.primaryColor,
                          width: 1,
                          style: BorderStyle.solid,
                          strokeAlign: 1),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                  ),
                ),
              ),
              // Tab Bar
              TabBar(
                overlayColor: WidgetStateProperty.all<Color>(
                    AppPalette.primaryColor.withAlpha(10)),
                labelStyle: TextStyle(fontFamily: "$font Semi Expanded Black"),
                labelColor: AppPalette.primaryColor,
                unselectedLabelColor: AppPalette.primaryColor.withOpacity(0.5),
                indicatorColor: AppPalette.primaryColor,
                tabs: [
                  Tab(text: 'All'),
                  Tab(text: 'Deleted'),
                ],
              ),
              // Tab Bar View
              Expanded(
                child: TabBarView(
                  children: [
                    Center(child: Text('All Users Content')),
                    Center(child: Text('Deleted Users Content')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
