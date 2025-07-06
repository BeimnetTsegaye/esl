import 'dart:math';

import 'package:esl/core/util/date_utils.dart';
import 'package:esl/core/widgets/custom_tab_bar.dart';
import 'package:esl/features/home/presentation/widgets/notification_tile.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
        title: const Text('Notifications'),
        centerTitle: true,
        bottom: CustomTabBar(tabController: _tabController, tabs: const ['General', 'Academics']),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ListView.separated(
            itemCount: 10,
            separatorBuilder: (context, index) => const SizedBox(height: 3),
            itemBuilder: (context, index) {
              return NotificationTile(
                title: 'Registration Now Open',
                date: formatDateToMMMMddyyyy('2025-05-12'),
                description:
                    'course registration for the 2025/26 academic year is now open. please visit the registration page for more details.',
                isRead: Random().nextBool(),
              );
            },
          ),
          ListView.separated(
            itemCount: 10,
            separatorBuilder: (context, index) => const SizedBox(height: 3),
            itemBuilder: (context, index) {
              return NotificationTile(
                title: 'Registration Now Open',
                date: formatDateToMMMMddyyyy('2025-05-12'),
                description:
                    'course registration for the 2025/26 academic year is now open. please visit the registration page for more details.',
                isRead: Random().nextBool(),
              );
            },
          ),
        ],
      ),
    );
  }
}
