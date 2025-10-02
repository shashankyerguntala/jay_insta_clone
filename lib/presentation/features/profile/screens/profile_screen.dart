import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "Posts", icon: Icon(Icons.article)),
            Tab(text: "Pending", icon: Icon(Icons.access_time)),
            Tab(text: "Declined", icon: Icon(Icons.cancel)),
            Tab(text: "Sign Out", icon: Icon(Icons.logout)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          const Center(child: Text("User Posts will be shown here")),

          const Center(
            child: Text("Pending requests/tasks will be shown here"),
          ),

          const Center(child: Text("Declined requests will be shown here")),

          Center(
            child: ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text("Signed Out")));
              },
              icon: const Icon(Icons.logout),
              label: const Text("Sign Out"),
            ),
          ),
        ],
      ),
    );
  }
}
