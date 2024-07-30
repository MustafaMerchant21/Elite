import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elite/core/constants.dart';
import 'package:elite/core/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

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
                  style: const TextStyle(
                    fontFamily: "$font Semi Expanded Black",
                    color: AppPalette.primaryColor,
                  ),
                  onTapOutside: (PointerDownEvent event) {
                    FocusScope.of(context).unfocus();
                  },
                  decoration: InputDecoration(
                    prefixIcon:
                    const Icon(Icons.search, color: AppPalette.textColor),
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
                    contentPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                  ),
                ),
              ),
              // Tab Bar
              TabBar(
                overlayColor: WidgetStateProperty.all<Color>(
                    AppPalette.primaryColor.withAlpha(10)),
                labelStyle:
                const TextStyle(fontFamily: "$font Semi Expanded Black"),
                labelColor: AppPalette.primaryColor,
                unselectedLabelColor: AppPalette.primaryColor.withOpacity(0.5),
                indicatorColor: AppPalette.primaryColor,
                tabs: [
                  const Tab(text: 'Customers'),
                  const Tab(text: 'Admin'),
                  const Tab(text: 'Deleted'),
                ],
              ),
              // Tab Bar View
              const Expanded(
                child: TabBarView(
                  children: [
                    _Customers(),
                    // _AdminUsers(),
                    // _DeletedUsers(),
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

class _Customers extends StatefulWidget {
  const _Customers();

  @override
  State<_Customers> createState() => _CustomersState();
}

class _CustomersState extends State<_Customers> {
  late Future<void> _fetchDataFuture;
  final List<DocumentSnapshot> _data = [];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

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
        _data.clear();  // Clear the data list to prevent duplication
        for (var doc in snapshot.docs) {
          _data.add(doc);
          _listKey.currentState?.insertItem(_data.length - 1);
        }
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _refresh() async {
    await _fetchData();
  }

  Future<void> _deleteUser(DocumentSnapshot doc, int index) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(doc.id).delete();
      setState(() {
        _listKey.currentState?.removeItem(
          index,
              (context, animation) => _buildItem(doc, animation, index),
          duration: const Duration(milliseconds: 600),
        );
        _data.removeAt(index);
      });
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error deleting user: $e'),
        ),
      );
    }
  }

  Widget _buildItem(DocumentSnapshot doc, Animation<double> animation, int index) {
    return SizeTransition(
      sizeFactor: animation,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppPalette.productCardsBackgroundColor,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(
                        'assets/images/logo_full_circle.png'),
                    backgroundColor: AppPalette.productCardsBackgroundColor,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doc['name'].toString(),
                          style: const TextStyle(
                              fontFamily: '$font Expanded Black',
                              fontSize: 12,
                              color: AppPalette.primaryColor),
                        ),
                        const SizedBox(height: 5,),
                        Text(
                          doc['email'].toString(),
                          style: TextStyle(
                            fontFamily: '$font Expanded Black',
                            fontSize: 10,
                            color: AppPalette.primaryColor.withAlpha(90),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Image.asset(
                      'assets/images/arrow_right.png',
                      width: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              await _deleteUser(doc, index);
            },
            child: Container(
              width: 25,
              height: double.minPositive + 82,
              decoration: const BoxDecoration(
                color: AppPalette.removeCartItemColor,
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(200),
                  right: Radius.circular(50),
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    '$imgPath/cross.png',
                    width: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      color: AppPalette.backgroundColor,
      backgroundColor: AppPalette.primaryColor,
      child: FutureBuilder(
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
            return AnimatedList(
              key: _listKey,
              initialItemCount: _data.length,
              itemBuilder: (context, index, animation) {
                if (index < _data.length) {
                  return _buildItem(_data[index], animation, index);
                } else {
                  return const SizedBox.shrink();  // Return an empty widget if index is out of bounds
                }
              },
            );
          }
        },
      ),
    );
  }
}
