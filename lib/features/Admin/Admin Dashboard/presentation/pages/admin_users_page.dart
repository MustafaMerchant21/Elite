import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elite/core/constants.dart';
import 'package:elite/core/theme/palette.dart';
import 'package:elite/features/auth/presentation/widgets/dialogue_box.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AdminUsersPage extends StatefulWidget {
  const AdminUsersPage({super.key});

  @override
  State<AdminUsersPage> createState() => _AdminUsersPageState();
}

class _AdminUsersPageState extends State<AdminUsersPage> {
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
                      UsersList(
                          isAdmin: false,
                          isDeleted: false,
                          searchQuery: _searchQuery),
                      UsersList(
                          isAdmin: true,
                          isDeleted: false,
                          searchQuery: _searchQuery),
                      UsersList(
                          isAdmin: true,
                          isDeleted: true,
                          searchQuery: _searchQuery),
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

class UsersList extends StatefulWidget {
  final bool isAdmin;
  final bool isDeleted;
  final String searchQuery;

  const UsersList(
      {super.key,
      required this.isAdmin,
      required this.isDeleted,
      required this.searchQuery});

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  late Future<void> _fetchDataFuture;
  final List<DocumentSnapshot> _data = [];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final Set<String> _deletingUsers = {}; // Track users being deleted

  @override
  void initState() {
    super.initState();
    _fetchDataFuture = _fetchData();
  }

  @override
  void didUpdateWidget(covariant UsersList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.searchQuery != widget.searchQuery) {
      _fetchDataFuture = _fetchData();
    }
  }

  Future<void> _fetchData() async {
    QuerySnapshot snapshot;
    try {
      if (widget.isDeleted) {
        snapshot =
            await FirebaseFirestore.instance.collection('deleted_users').get();
      } else {
        snapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('admin', isEqualTo: widget.isAdmin)
            .get();
      }

      List<DocumentSnapshot> filteredDocs = snapshot.docs;
      if (widget.searchQuery.isNotEmpty) {
        filteredDocs = filteredDocs.where((doc) {
          final name = doc['name'].toString().toLowerCase();
          final email = doc['email'].toString().toLowerCase();
          final query = widget.searchQuery.toLowerCase();
          return name.contains(query) || email.contains(query);
        }).toList();
      }

      setState(() {
        _data.clear();
        for (var doc in filteredDocs) {
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
    setState(() {
      _deletingUsers.add(doc.id);
    });
    try {
      await FirebaseFirestore.instance.collection('users').doc(doc.id).delete();
      widget.isDeleted
          ? await FirebaseFirestore.instance
              .collection('deleted_users')
              .doc(doc.id)
              .delete()
          : await FirebaseFirestore.instance
              .collection('deleted_users')
              .doc(doc.id)
              .set(doc.data() as Map<String, Object?>);

      setState(() {
        _listKey.currentState?.removeItem(
          index,
          (context, animation) =>
              _buildItem(doc, animation, index, isRemoving: true),
          duration: const Duration(milliseconds: 600),
        );
        _data.removeAt(index);
        _deletingUsers.remove(doc.id);
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

  void _showDeleteConfirmationDialog(DocumentSnapshot doc, int index) {
    showDialog(
      barrierDismissible: true,
      useSafeArea: true,
      context: context,
      builder: (BuildContext context) {
        return CustomDialogue(
          title: 'Delete User',
          content: 'Are you sure you want to delete this user?',
          onConfirm: () {
            Navigator.of(context).pop(); // Close the dialog
            _deleteUser(doc, index);
          }, isLoading: false,
        );
      },
    );
  }


  Widget _buildItem(
      DocumentSnapshot doc, Animation<double> animation, int index,
      {bool isRemoving = false}) {
    final bool isDeleting = _deletingUsers.contains(doc.id);

    return SizeTransition(
      sizeFactor: animation,
      child: Stack(
        children: [
          // User Card
          Row(
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
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: doc['profileImage'] != null &&
                                doc['profileImage'].isNotEmpty
                            ? NetworkImage(doc['profileImage'])
                            : const AssetImage(
                                    'assets/images/logo_full_circle.png')
                                as ImageProvider,
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
                                  fontSize: 14,
                                  color: AppPalette.primaryColor),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
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
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => _showDeleteConfirmationDialog(doc,index),
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
          if (isDeleting)
            Positioned.fill(
              child: Container(
                color: AppPalette.backgroundColor.withOpacity(0.5),
                child: Center(
                  child: LoadingAnimationWidget.horizontalRotatingDots(
                      color: AppPalette.textColor, size: 30),
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
      backgroundColor: AppPalette.primaryColor,
      color: AppPalette.backgroundColor,
      onRefresh: _refresh,
      child: FutureBuilder<void>(
        future: _fetchDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: LoadingAnimationWidget.horizontalRotatingDots(
                  color: AppPalette.textColor, size: 50),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(
                    color: AppPalette.primaryColor,
                    fontFamily: "$font Expanded Heavy"),
              ),
            );
          } else if (_data.isEmpty) {
            return Center(
              child: Text(
                'No users found',
                style: TextStyle(
                    color: AppPalette.primaryColor.withAlpha(80),
                    fontFamily: "$font Semi Expanded Heavy"),
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
                  return const SizedBox.shrink();
                }
              },
            );
          }
        },
      ),
    );
  }
}
