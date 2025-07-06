import 'package:flutter/material.dart';
final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>();

// AppBar appBar(BuildContext context) {
//     return AppBar(
//       leading: Padding(
//         padding: const EdgeInsets.only(left: 10.0), // Add space from the edge
//         child: IconButton(
//           icon: const Icon(Icons.menu),
//           onPressed: () {
//             scaffoldKey.currentState
//                 ?.openDrawer(); // Use the GlobalKey to open the drawer
//           },
//         ),
//       ),
//       title: const Padding(
//         padding: EdgeInsets.only(left: 10.0), // Add space from the edge
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Icon(FluentIcons.weather_partly_cloudy_day_24_regular),
//                 SizedBox(width: 5),
//                 Text('Partly Cloudy, 27°C'),
//               ],
//             ),
//             Text('Hello, Dagmawi Esayas', style: boldTextStyle),
//           ],
//         ),
//       ),
//       actions: [
//         Padding(
//           padding: const EdgeInsets.only(
//             right: 10.0,
//           ), // Add space from the edge
//           child: CircleAvatar(
//             backgroundColor: AppConstants.eslGreyTint,
//             child: IconButton(
//               onPressed:
//                   () => {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const NotificationsPage(),
//                       ),
//                     ),
//                   },
//               icon: const Icon(
//                 FluentIcons.alert_badge_16_filled,
//                 color: AppConstants.eslGreen,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }


/*
//custom app bar
import 'package:esl/core/shared/constants.dart';
import 'package:esl/core/theme/app_theme.dart';
import 'package:esl/features/home/presentation/pages/notifications_page.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

// Wholistic AppBar
AppBar customAppBar({
  required BuildContext context,
  Widget? title,
  bool centerTitle = false,
  bool showBackButton = false,
  bool showDrawerButton = false,
  VoidCallback? onBackPressed,
  VoidCallback? onDrawerPressed,
  List<Widget>? actions,
}) {
  return AppBar(
    leading: showBackButton
        ? IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: onBackPressed ?? () => Navigator.pop(context),
          )
        : showDrawerButton
            ? IconButton(
                icon: const Icon(Icons.menu),
                onPressed: onDrawerPressed ?? () => scaffoldKey.currentState?.openDrawer(),
              )
            : null,
    title: title,
    centerTitle: centerTitle,
    actions: actions,
  );
}

// AppBar with Drawer and Title
AppBar appBarWithDrawer(BuildContext context, Widget title) {
  return customAppBar(
    context: context,
    title: title,
    showDrawerButton: true,
    actions: [
      IconButton(
        icon: const Icon(FluentIcons.alert_badge_16_filled, color: AppConstants.eslGreen),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NotificationsPage()),
          );
        },
      ),
    ],
  );
}

// AppBar with Back Button
AppBar appBarWithBackButton(BuildContext context, Widget title) {
  return customAppBar(
    context: context,
    title: title,
    showBackButton: true,
  );
}

// AppBar with Search Icon
AppBar appBarWithSearch(BuildContext context, Widget title, VoidCallback onSearchPressed) {
  return customAppBar(
    context: context,
    title: title,
    actions: [
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: onSearchPressed,
      ),
    ],
  );
}

// AppBar with Custom Actions
AppBar appBarWithCustomActions(BuildContext context, Widget title, List<Widget> actions) {
  return customAppBar(
    context: context,
    title: title,
    actions: actions,
  );
}

// AppBar with Centered Title
AppBar appBarWithCenteredTitle(BuildContext context, Widget title) {
  return customAppBar(
    context: context,
    title: title,
    centerTitle: true,
  );
}

 */
