import 'dart:ui';

import 'package:esl/core/shared/constants.dart';
import 'package:flutter/material.dart';

class RotatingImageWidget extends StatefulWidget {
  final double width;
  final double height;

  const RotatingImageWidget({
    super.key,
    this.width = 100.0,
    this.height = 100.0,
  });

  @override
  State<RotatingImageWidget> createState() => _RotatingImageWidgetState();
}

class _RotatingImageWidgetState extends State<RotatingImageWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    _rotateAnimation = Tween<double>(begin: 0.0, end: 2.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
        reverseCurve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _rotateAnimation,
      child: Image.asset(
        AppConstants.wheel,
        width: widget.width,
        height: widget.height,
      ),
    );
  }
}

class BlurryBackgroundWidget extends StatelessWidget {
  const BlurryBackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Container(color: Colors.white.withValues(alpha: 0.5)),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        BlurryBackgroundWidget(),
        Center(child: RotatingImageWidget()),
      ],
    );
  }
}
