import 'package:elite/core/constants.dart';
import 'package:elite/core/theme/palette.dart';
import 'package:flutter/material.dart';

class AdminOrdersPage extends StatefulWidget {
  const AdminOrdersPage({super.key});

  @override
  State<AdminOrdersPage> createState() => _AdminOrdersPageState();
}

class _AdminOrdersPageState extends State<AdminOrdersPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: appbar(context, "Users"),
          body: Expanded(
            child: Column(
              children: [
                // Search Bar
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextField(
                          controller: _searchController,
                          style: const TextStyle(
                            fontFamily: "$font Semi Expanded Black",
                            color: AppPalette.primaryColor,
                          ),
                          onChanged: (value) {
                            setState(() {
                              _searchQuery = value;
                            });
                          },
                          onTapOutside: (PointerDownEvent event) {
                            FocusScope.of(context).unfocus();
                          },
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search,
                                color: AppPalette.textColor),
                            hintText: 'Search users...',
                            filled: true,
                            fillColor: AppPalette.backgroundColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: AppPalette.primaryColor,
                                  width: 1,
                                  style: BorderStyle.solid,
                                  strokeAlign: 1),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 16),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (!(_searchQuery == '' || _searchQuery == ' ')) {
                          setState(() {
                            _searchQuery = '';
                            _searchController.clear();
                          });
                        }
                      },
                      icon: const Icon(Icons.clear_rounded),
                      color: AppPalette.primaryColor,
                      splashColor: AppPalette.primaryColor.withAlpha(20),
                      tooltip: 'Clear',

                    )
                  ],
                ),
                // Tab Bar
                TabBar(
                  overlayColor: WidgetStateProperty.all<Color>(
                      AppPalette.primaryColor.withAlpha(10)),
                  labelStyle:
                  const TextStyle(fontFamily: "$font Semi Expanded Black"),
                  labelColor: AppPalette.primaryColor,
                  unselectedLabelColor:
                  AppPalette.primaryColor.withOpacity(0.5),
                  indicatorColor: AppPalette.primaryColor,
                  tabs: const [
                    Tab(text: 'Customers'),
                    Tab(text: 'Admin'),
                    Tab(text: 'Deleted'),
                  ],
                ),
                // Tab Bar View
                Expanded(
                  child: TabBarView(
                    children: [
                      UserOrder(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }
}
class UserOrder extends StatefulWidget {
  const UserOrder({super.key});

  @override
  State<UserOrder> createState() => _UserOrderState();
}

class _UserOrderState extends State<UserOrder> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
class Order {
  String oid;
  String date;
  String total;

  Order({
    required this.oid,
    required this.date,
    required this.total,
  });
}
