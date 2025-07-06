import 'package:esl/core/shared/app_bar_widget.dart';
import 'package:esl/core/shared/constants.dart';
import 'package:esl/core/widgets/common_widgets.dart';
import 'package:esl/core/widgets/drawer_widget.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BasePage extends StatefulWidget {
  final bool useCustomAppBar;
  final Widget child;

  const BasePage({super.key, this.useCustomAppBar = true, required this.child});

  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  @override
  Widget build(BuildContext context) {
    final String currentLocation = GoRouterState.of(context).matchedLocation;
    final bool isHomePage = currentLocation == AppConstants.homeRoute;
    final bool hideAppBar = currentLocation == AppConstants.profileRoute || isHomePage;

    return Scaffold(
      key: scaffoldKey,
      appBar: widget.useCustomAppBar ? const CustomAppBar() : null,
      body: hideAppBar
          ? widget.child
          : Padding(padding: const EdgeInsets.all(10), child: widget.child),
      drawer: const DrawerWidget(),
      floatingActionButton: widget.useCustomAppBar && isHomePage
          ? FloatingActionButton(
              onPressed: () => context.push(AppConstants.chatbotRoute),
              child: const Icon(FluentIcons.chat_multiple_24_filled),
            )
          : null,
    );
  }
}
