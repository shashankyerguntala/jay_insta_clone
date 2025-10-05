import 'package:flutter/material.dart';
import 'package:jay_insta_clone/core%20/constants/color_constants.dart';
import 'package:jay_insta_clone/core%20/constants/theme_constants.dart';

class ModeratorScreen extends StatefulWidget {
  const ModeratorScreen({super.key});

  @override
  State<ModeratorScreen> createState() => _ModeratorScreenState();
}

class _ModeratorScreenState extends State<ModeratorScreen> {
  int _postFilter = 0;
  int _commentFilter = 0;

  final List<String> _filters = ['Pending', 'Approved', 'Declined'];

  Widget _buildFilterRow(int selectedIndex, ValueChanged<int> onChanged) {
    return Wrap(
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
    );
  }

  Widget _buildList(String prefix, int filterIndex) {
    final items = List.generate(
      12,
      (i) => '$prefix #${i + 1} — ${_filters[filterIndex]}',
    );

    return ListView.separated(
      padding: const EdgeInsets.all(8),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          titleSpacing: 0,
          title: Text('Moderator', style: ThemeConstants.headingMedium),
          bottom: TabBar(
            indicatorPadding: EdgeInsetsGeometry.symmetric(horizontal: 20),
            labelStyle: TextStyle(color: ColorConstants.primaryColor),
            unselectedLabelColor: ColorConstants.textSecondaryColor,
            indicator: BoxDecoration(
              color: ColorConstants.primaryColor.withAlpha(30),
              borderRadius: BorderRadius.circular(20),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: const [
              Tab(text: 'Posts'),
              Tab(text: 'Comments'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: _buildFilterRow(_postFilter, (i) {
                    setState(() => _postFilter = i);
                  }),
                ),
                Expanded(child: _buildList('Post', _postFilter)),
              ],
            ),

            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: _buildFilterRow(_commentFilter, (i) {
                    setState(() => _commentFilter = i);
                  }),
                ),
                Expanded(child: _buildList('Comment', _commentFilter)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
