import 'package:esl/core/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomTabBar({
    super.key,
    required TabController tabController,
    required this.tabs,
  }) : _tabController = tabController;

  final TabController _tabController;
  final List<String> tabs;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: _tabController,
      indicatorColor: Colors.transparent,
      tabs: tabs.map((tab) => Tab(child: Center(child: Skeleton.ignore(child: Text(tab))))).toList(),
      dividerColor: Colors.transparent,
      indicator: const BoxDecoration(color: AppConstants.eslYellow),
      overlayColor: const WidgetStatePropertyAll(AppConstants.eslYellow),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(50);
}
