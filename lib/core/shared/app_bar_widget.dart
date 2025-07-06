import 'package:esl/core/di/service_locator.dart';
import 'package:esl/core/shared/constants.dart';
import 'package:esl/core/theme/app_theme.dart';
import 'package:esl/core/widgets/common_widgets.dart';
import 'package:esl/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const curveHeight = 20.0;
    final path = Path();
    path.lineTo(0, size.height - curveHeight);
    path.quadraticBezierTo(
      size.width / 2,
      size.height + curveHeight,
      size.width,
      size.height - curveHeight,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, this.scrollController});

  final ScrollController? scrollController;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(
    kToolbarHeight * 1.5 + (sl<AuthBloc>().state is! Authenticated ? 44.0 : 0),
  );
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool _isScrolled = false;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController ?? ScrollController();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void didUpdateWidget(CustomAppBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.scrollController != oldWidget.scrollController) {
      _scrollController.removeListener(_handleScroll);
      _scrollController = widget.scrollController ?? ScrollController();
      _scrollController.addListener(_handleScroll);
    }
  }

  void _handleScroll() {
    final isScrolled = _scrollController.position.pixels > 10;
    if (isScrolled != _isScrolled) {
      setState(() => _isScrolled = isScrolled);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    if (widget.scrollController == null) {
      _scrollController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      backgroundColor: AppConstants.eslGreen.withOpacity(0.1),
      elevation: 0,
      automaticallyImplyLeading: false,
      centerTitle: false,
      leading: Container(
        margin: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
        decoration: BoxDecoration(
          color: theme.brightness == Brightness.light
              ? Colors.transparent
              : Colors.grey[800],
          borderRadius: BorderRadius.circular(12),
        ),
        child: IconButton(
          icon: const Icon(FluentIcons.line_horizontal_3_20_regular, size: 25),
          onPressed: () {
            scaffoldKey.currentState?.openDrawer();
          },
          style: IconButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is Authenticated) {
                final user = state.user;
                return Text('Hello, ${user.firstName}', style: boldTextStyle);
              }
              return const Text('Hello, Guest', style: boldTextStyle);
            },
          ),
        ],
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
          decoration: BoxDecoration(
            color: theme.brightness == Brightness.light
                ? Colors.transparent
                : Colors.grey[800],
            borderRadius: BorderRadius.circular(12),
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.black.withOpacity(0.05),
            //     blurRadius: 4,
            //     offset: const Offset(0, 2),
            //   ),
            // ],
          ),
          child: CircleAvatar(
            backgroundColor: AppConstants.eslWhite,
            child: IconButton(
              onPressed: () => context.push(AppConstants.notificationsRoute),

              icon: const Icon(
                FluentIcons.alert_badge_16_filled,
                color: AppConstants.eslGreen,
              ),
            ),
          ),
        ),
        // BlocBuilder<AuthBloc, AuthState>(
        //   builder: (context, state) {
        //     final isAuthenticated = state is Authenticated;

        //     return IconButton(
        //       onPressed: () {
        //         if (isAuthenticated) {
        //           context.push(AppConstants.profileRoute);
        //         } else {
        //           context.push(AppConstants.loginRoute);
        //         }
        //       },
        //       icon: CircleAvatar(
        //         // radius: 25,
        //         backgroundColor: AppConstants.eslWhite,
        //         child: const Icon(
        //           FluentIcons.person_24_regular,
        //           color: AppConstants.eslGreen,
        //           // size: 40,
        //         ),
        //       ),
        //       style: IconButton.styleFrom(
        //         shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(12),
        //         ),
        //       ),
        //     );
        //   },
        // ),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(
          context.watch<AuthBloc>().state is! Authenticated ? 44.0 : 0,
        ),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is! Authenticated) {
              return Container(
                height: 44,
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                color: AppConstants.eslYellow,
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'login',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () =>
                                context.push(AppConstants.loginRoute),
                          style: boldTextStyle.copyWith(
                            color: AppConstants.eslGreen,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        TextSpan(
                          text: ' for full access',
                          style: boldTextStyle.copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
