import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onTap;

  const CustomBottomNavigationBar({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
          label: 'Home',
          icon: Icon(
            currentIndex == 0
                ? FluentIcons.home_24_filled
                : FluentIcons.home_24_regular,
          ),
        ),
        BottomNavigationBarItem(
          label: 'Courses',
          icon: Icon(
            currentIndex == 1
                ? FluentIcons.book_24_filled
                : FluentIcons.book_24_regular,
          ),
        ),
        BottomNavigationBarItem(
          label: 'Library',
          icon: Icon(
            currentIndex == 2
                ? FluentIcons.library_24_filled
                : FluentIcons.library_24_regular,
          ),
        ),
        BottomNavigationBarItem(
          label: 'Profile',
          icon: Icon(
            currentIndex == 3
                ? FluentIcons.person_24_filled
                : FluentIcons.person_24_regular,
          ),
        ),
      ],
    );
  }
}
