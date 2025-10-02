import 'package:flutter/material.dart';
import 'package:jay_insta_clone/core%20/constants/color_constants.dart';

import 'package:jay_insta_clone/presentation/features/profile/widgets/posts_grid.dart';
import 'package:jay_insta_clone/presentation/features/profile/widgets/profile_header.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String userRole = "user";
  bool hasRequestedModerator = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Profile",
          style: TextStyle(
            color: ColorConstants.textPrimaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            color: ColorConstants.textPrimaryColor,
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          ProfileHeader(
            userRole: userRole,
            hasRequestedModerator: hasRequestedModerator,
            onModeratorRequest: () =>
                setState(() => hasRequestedModerator = true),
            onSignOut: () => ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text("Signed Out"))),
          ),
          const SizedBox(height: 8),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.white,
              unselectedLabelColor: ColorConstants.textSecondaryColor,
              indicator: BoxDecoration(
                color: ColorConstants.primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              padding: const EdgeInsets.all(4),
              tabs: const [
                Tab(text: "Approved"),
                Tab(text: "Pending"),
                Tab(text: "Declined"),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                PostsGrid(status: 'approved'),
                PostsGrid(status: 'pending'),
                PostsGrid(status: 'declined'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
