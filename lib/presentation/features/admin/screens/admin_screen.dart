import 'package:flutter/material.dart';
import 'package:jay_insta_clone/core%20/constants/color_constants.dart';
import 'package:jay_insta_clone/core%20/constants/theme_constants.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  int _postFilter = 0;
  int _commentFilter = 0;
  int _requestFilter = 0;

  final List<String> _filters = ['Pending', 'Approved', 'Declined'];

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

  Widget _buildFilterRow(int selectedIndex, ValueChanged<int> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Wrap(
        spacing: 8,
        children: List.generate(_filters.length, (i) {
          return ChoiceChip(
            label: Text(_filters[i]),
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

  Widget _buildList(String prefix, int filterIndex) {
    final items = List.generate(
      12,
      (i) => '$prefix #${i + 1} — ${_filters[filterIndex]}',
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.separated(
        padding: const EdgeInsets.only(top: 8),
        itemBuilder: (c, idx) {
          return Card(
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
          );
        },
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemCount: items.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Admin Dashboard', style: ThemeConstants.headingMedium),
          bottom: TabBar(
            controller: _tabController,
            labelColor: Colors.white,
            unselectedLabelColor: ColorConstants.textSecondaryColor,
            indicator: BoxDecoration(
              color: ColorConstants.primaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: const [
              Tab(text: 'Posts'),
              Tab(text: 'Comments'),
              Tab(text: 'Moderators'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            Column(
              children: [
                _buildFilterRow(_postFilter, (i) {
                  setState(() => _postFilter = i);
                }),
                Expanded(child: _buildList('Post', _postFilter)),
              ],
            ),
            Column(
              children: [
                _buildFilterRow(_commentFilter, (i) {
                  setState(() => _commentFilter = i);
                }),
                Expanded(child: _buildList('Comment', _commentFilter)),
              ],
            ),
            Column(
              children: [
                _buildFilterRow(_requestFilter, (i) {
                  setState(() => _requestFilter = i);
                }),
                Expanded(
                  child: _buildList('Moderator Request', _requestFilter),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
