import 'package:flutter/material.dart';
import 'package:jay_insta_clone/core%20/constants/color_constants.dart';
import 'package:jay_insta_clone/core%20/constants/theme_constants.dart';
import 'package:jay_insta_clone/presentation/features/add_admin.dart/screen/add_admin_screen.dart';

class SuperAdminScreen extends StatefulWidget {
  const SuperAdminScreen({super.key});

  @override
  State<SuperAdminScreen> createState() => _SuperAdminScreenState();
}

class _SuperAdminScreenState extends State<SuperAdminScreen> {
  int _postFilter = 0;
  int _commentFilter = 0;
  int _moderatorFilter = 0;
  int _adminFilter = 0;

  final List<String> _statusFilters = ['Pending', 'Approved', 'Declined'];
  final List<String> _userFilters = ['Active', 'Inactive'];

  Widget _buildFilterRow(
    int selectedIndex,
    ValueChanged<int> onChanged, {
    List<String>? filters,
  }) {
    final f = filters ?? _statusFilters;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
        spacing: 8,
        children: List.generate(f.length, (i) {
          return ChoiceChip(
            label: Text(f[i]),
            selected: selectedIndex == i,
            selectedColor: ColorConstants.primaryColor.withAlpha(15),
            labelStyle: TextStyle(
              color: selectedIndex == i
                  ? ColorConstants.primaryColor
                  : ColorConstants.textSecondaryColor,
              fontWeight: FontWeight.w600,
            ),
            onSelected: (_) => onChanged(i),
          );
        }),
      ),
    );
  }

  Widget _buildList(String prefix, int filterIndex, {List<String>? filters}) {
    final f = filters ?? _statusFilters;
    final items = List.generate(
      12,
      (i) => '$prefix #${i + 1} — ${f[filterIndex]}',
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.separated(
        padding: const EdgeInsets.only(top: 8),
        itemBuilder: (_, idx) => Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 1,
          child: ListTile(
            title: Text(items[idx], style: ThemeConstants.bodyMedium),
            subtitle: Text(
              'Some meta info here',
              style: ThemeConstants.bodySmall.copyWith(
                color: ColorConstants.textSecondaryColor,
              ),
            ),
            trailing: PopupMenuButton<String>(
              onSelected: (choice) {},
              itemBuilder: (_) => [
                const PopupMenuItem(value: 'approve', child: Text('Approve')),
                const PopupMenuItem(value: 'decline', child: Text('Decline')),
                const PopupMenuItem(value: 'view', child: Text('View')),
              ],
            ),
          ),
        ),
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemCount: items.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Super Admin', style: ThemeConstants.headingMedium),
          bottom: TabBar(
            isScrollable: true,
            indicator: BoxDecoration(
              color: ColorConstants.primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(30),
            ),
            labelColor: ColorConstants.primaryColor,
            unselectedLabelColor: ColorConstants.textSecondaryColor,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            tabs: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                child: const Tab(text: 'Posts'),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                child: const Tab(text: 'Comments'),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                child: const Tab(text: 'Moderators'),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                child: const Tab(text: 'Admins'),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Column(
              children: [
                _buildFilterRow(
                  _postFilter,
                  (i) => setState(() => _postFilter = i),
                ),
                Expanded(child: _buildList('Post', _postFilter)),
              ],
            ),

            Column(
              children: [
                _buildFilterRow(
                  _commentFilter,
                  (i) => setState(() => _commentFilter = i),
                ),
                Expanded(child: _buildList('Comment', _commentFilter)),
              ],
            ),

            Column(
              children: [
                _buildFilterRow(
                  _moderatorFilter,
                  (i) => setState(() => _moderatorFilter = i),
                  filters: _userFilters,
                ),
                Expanded(
                  child: _buildList(
                    'Moderator',
                    _moderatorFilter,
                    filters: _userFilters,
                  ),
                ),
              ],
            ),

            Column(
              children: [
                _buildFilterRow(
                  _adminFilter,
                  (i) => setState(() => _adminFilter = i),
                  filters: _userFilters,
                ),
                Expanded(
                  child: _buildList(
                    'Admin',
                    _adminFilter,
                    filters: _userFilters,
                  ),
                ),
              ],
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddAdminPage()),
            );
          },
          icon: const Icon(Icons.add, color: Colors.white),
          label: const Text('Add Admin', style: TextStyle(color: Colors.white)),
          backgroundColor: ColorConstants.primaryColor,
        ),
      ),
    );
  }
}
