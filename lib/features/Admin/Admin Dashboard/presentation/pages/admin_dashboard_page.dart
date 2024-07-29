import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elite/core/constants.dart';
import 'package:elite/core/theme/palette.dart';
import 'package:elite/features/Admin/Admin%20Dashboard/presentation/widgets/admin_dashboard_card.dart';
import 'package:elite/features/auth/presentation/pages/admin_users_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

const Color bottomNavBgColor = Color(0xFF17203A);

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  late Future<void> _fetchDataFuture;
  List<DocumentSnapshot> _data = [];

  static _rActivityItem([String event = 'New Order', String date = '01/07/22', String time = '10:10']) => Row(
    children: [
      Column(
        children: [
          // Container(
          //   width: 5,
          //   height: 8,
          //   decoration: BoxDecoration(
          //       color: AppPalette.primaryColor.withAlpha(30),
          //       borderRadius: BorderRadius.all(Radius.circular(100))
          //   ),
          // ),
          const Padding(
            padding: EdgeInsets.all(8),
            child: Image(
              image: AssetImage('assets/images/new_order.png'),
              width: 24,
              height: 24,
            ),
          ),
          Container(
            width: 4,
            height: 26,
            decoration: BoxDecoration(
                color: AppPalette.primaryColor.withAlpha(30),
                borderRadius: BorderRadius.all(Radius.circular(100))),
          ),

          /// Images based on event
        ],
      ),
       Expanded(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  event,
                  style: TextStyle(
                      color: AppPalette.primaryColor,
                      fontFamily: "$font Semi Expanded Black",
                      fontSize: 16),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "$date • $time",
                  style: TextStyle(
                      color: AppPalette.primaryColor,
                      fontFamily: "$font Semi Expanded Bold",
                      fontSize: 16),
                ),
              )
            ],
          ),
        ),
      )
    ],
  );

  @override
  void initState() {
    super.initState();
    _fetchDataFuture = _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('users').get();

      setState(() {
        _data = snapshot.docs;
      });
    } catch (e) {
      // Handle errors
      print(e);
    }
  }

  Future<void> _refresh() async {
    await _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: signOut,
        backgroundColor: AppPalette.primaryColor,
        foregroundColor: AppPalette.backgroundColor,
        child: const Icon(Icons.logout_rounded),
      ),
      backgroundColor: AppPalette.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppPalette.backgroundColor,
        title: const Text(
          "Dashboard",
          style: TextStyle(fontFamily: "$font Expanded Heavy", fontSize: 15),
        ),
        centerTitle: true,
        foregroundColor: AppPalette.textColor,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AdminUsersPage()),);
            }, icon: Icon(Icons.supervised_user_circle_rounded)),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        color: AppPalette.backgroundColor,
        backgroundColor: AppPalette.primaryColor,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: FutureBuilder<void>(
                future: _fetchDataFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LoadingAnimationWidget.horizontalRotatingDots(
                              color: AppPalette.textColor, size: 30),
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text(
                        "Error Fetching data",
                        style: TextStyle(color: AppPalette.textColor),
                      ),
                    );
                  } else {
                    return _dashboardBody(FirebaseAuth.instance.currentUser!);
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _dashboardBody(User user) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 16,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Welcome, ${user.displayName.toString().split(" ")[0]} 👋",
            style: const TextStyle(
              color: AppPalette.textColor,
              fontFamily: "$font Semi Expanded Heavy",
              fontSize: 22,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        const Row(
          children: [
            AdminDashboardCard(title: "Total Sales", value: "\$5000"),
            SizedBox(
              width: 8,
            ),
            AdminDashboardCard(title: "Products Sold", value: "1000"),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        const Row(
          children: [
            AdminDashboardCard(title: "User", value: "1200"),
            SizedBox(
              width: 8,
            ),
            AdminDashboardCard(title: "Reviews", value: "350"),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        const Row(
          children: [
            AdminDashboardCard(title: "Orders", value: "400"),
            SizedBox(
              width: 8,
            ),
            AdminDashboardCard(title: "Sign Ups", value: "500"),
          ],
        ),

        const SizedBox(
          height: 24,
        ),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Recent Activity",
            style: TextStyle(
              color: AppPalette.textColor,
              fontFamily: "$font Semi Expanded Heavy",
              fontSize: 22,
            ),
          ),
        ),

        const SizedBox(
          height: 8,
        ),

        // =====
        /// Todo: Recent Activities such as:
        /// [1. New Signup]
        /// [2. New Login]
        /// [3. New Order]
        /// [4. New Review]
        ///
        /// Row > Column*2 > Column*2
        // =====

        Column(
          children: [
            _rActivityItem(),
            _rActivityItem(),
          ],
        )
      ],
    );
  }

  signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
