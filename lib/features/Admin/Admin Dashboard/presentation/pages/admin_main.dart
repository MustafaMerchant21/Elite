import 'package:elite/core/theme/palette.dart';
import 'package:elite/features/Admin/Admin%20Dashboard/presentation/pages/admin_analytics_page.dart';
import 'package:elite/features/Admin/Admin%20Dashboard/presentation/pages/admin_dashboard_page.dart';
import 'package:elite/features/Admin/Admin%20Dashboard/presentation/pages/admin_orders_page.dart';
import 'package:elite/features/Admin/Admin%20Dashboard/presentation/pages/admin_settings_page.dart';
import 'package:flutter/material.dart';

const Color bottomNavBgColor = Color(0xFF17203A);

class AdminMain extends StatefulWidget {
  const AdminMain({super.key});

  @override
  State<AdminMain> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminMain> with SingleTickerProviderStateMixin {
  int selectedNavIndex = 0;
  late PageController _pageController;

  List<Widget> pages = [
    const AdminDashboardPage(),
    const AdminOrdersPage(),
    const AdminAnalyticsPage(),
    const AdminSettingsPage(),
  ];

  List<NavModel> bottomNavItems = [
    NavModel(
      src: "assets/images/home_dark.png",
      name: "Dashboard",
    ),
    NavModel(
      src: "assets/images/order_dark.png",
      name: "Orders",
    ),
    NavModel(
      src: "assets/images/analytics_dark.png",
      name: "Analytics",
    ),
    NavModel(
      src: "assets/images/settings_dark.png",
      name: "Settings",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: selectedNavIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNavItemTapped(int index) {
    setState(() {
      selectedNavIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            selectedNavIndex = index;
          });
        },
        children: pages,
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          // padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            // color: AppPalette.primaryColor.withOpacity(0.8),
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: bottomNavBgColor.withOpacity(0.05),
                offset: const Offset(0, 20),
                blurRadius: 20,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              bottomNavItems.length,
                  (index) {
                final navItem = bottomNavItems[index];
                return Expanded(
                  child: Tooltip(
                    message: bottomNavItems[index].name,
                    child: GestureDetector(
                      onTap: () => _onNavItemTapped(index),
                      child: Container(
                        // color: Colors.deepPurple,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        width: double.infinity,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 24,
                              width: 24,
                              child: Opacity(
                                opacity: selectedNavIndex == index ? 1 : 0.5,
                                child: NavIcon(navItem: navItem),
                              ),
                            ),
                            SizedBox(
                              height: selectedNavIndex == index ? 5 : 0,
                            ),
                            AnimatedBar(isActive: selectedNavIndex == index),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class NavModel {
  final String src, name;

  NavModel({
    required this.src,
    required this.name,
  });
}

class NavIcon extends StatelessWidget {
  final NavModel navItem;

  const NavIcon({super.key, required this.navItem});

  @override
  Widget build(BuildContext context) {
    return Image.asset(navItem.src); // Adjust as per your image loading method
  }
}

class AnimatedBar extends StatelessWidget {
  const AnimatedBar({
    super.key,
    required this.isActive,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(bottom: 2),
      height: 4,
      width: isActive ? 20 : 0,
      decoration: const BoxDecoration(
        color: Color(0xFF81B4FF),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
