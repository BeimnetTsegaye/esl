import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RefreshableWidget<T extends BlocBase<S>, S> extends StatelessWidget {
  final Widget child;
  final Future<void> Function() onRefresh;
  final bool Function(S state)? shouldRefresh;
  final Color? color;
  final Color? backgroundColor;
  final double displacement;
  final double strokeWidth;
  final String? semanticsLabel;
  final String? semanticsValue;

  const RefreshableWidget({
    super.key,
    required this.child,
    required this.onRefresh,
    this.shouldRefresh,
    this.color,
    this.backgroundColor,
    this.displacement = 40.0,
    this.strokeWidth = 2.0,
    this.semanticsLabel,
    this.semanticsValue,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<T, S>(
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: onRefresh,
          color: color,
          backgroundColor: backgroundColor,
          displacement: displacement,
          strokeWidth: strokeWidth,
          semanticsLabel: semanticsLabel,
          semanticsValue: semanticsValue,
          child: child,
        );
      },
    );
  }
}

class RefreshableListView<T extends BlocBase<S>, S> extends StatelessWidget {
  final List<Widget> children;
  final Future<void> Function() onRefresh;
  final bool Function(S state)? shouldRefresh;
  final EdgeInsetsGeometry? padding;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final double? cacheExtent;
  final ScrollController? controller;
  final bool? primary;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final Color? color;
  final Color? backgroundColor;
  final double displacement;
  final double strokeWidth;
  final String? semanticsLabel;
  final String? semanticsValue;

  const RefreshableListView({
    super.key,
    required this.children,
    required this.onRefresh,
    this.shouldRefresh,
    this.padding,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.color,
    this.backgroundColor,
    this.displacement = 40.0,
    this.strokeWidth = 2.0,
    this.semanticsLabel,
    this.semanticsValue,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<T, S>(
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: onRefresh,
          color: color,
          backgroundColor: backgroundColor,
          displacement: displacement,
          strokeWidth: strokeWidth,
          semanticsLabel: semanticsLabel,
          semanticsValue: semanticsValue,
          child: ListView(
            padding: padding,
            addAutomaticKeepAlives: addAutomaticKeepAlives,
            addRepaintBoundaries: addRepaintBoundaries,
            addSemanticIndexes: addSemanticIndexes,
            cacheExtent: cacheExtent,
            controller: controller,
            primary: primary,
            physics: physics ?? const AlwaysScrollableScrollPhysics(),
            shrinkWrap: shrinkWrap,
            children: children,
          ),
        );
      },
    );
  }
}

class RefreshableScrollView<T extends BlocBase<S>, S> extends StatelessWidget {
  final Widget child;
  final Future<void> Function() onRefresh;
  final bool Function(S state)? shouldRefresh;
  final ScrollController? controller;
  final bool? primary;
  final ScrollPhysics? physics;
  final bool reverse;
  final Color? color;
  final Color? backgroundColor;
  final double displacement;
  final double strokeWidth;
  final String? semanticsLabel;
  final String? semanticsValue;

  const RefreshableScrollView({
    super.key,
    required this.child,
    required this.onRefresh,
    this.shouldRefresh,
    this.controller,
    this.primary,
    this.physics,
    this.reverse = false,
    this.color,
    this.backgroundColor,
    this.displacement = 40.0,
    this.strokeWidth = 2.0,
    this.semanticsLabel,
    this.semanticsValue,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<T, S>(
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: onRefresh,
          color: color,
          backgroundColor: backgroundColor,
          displacement: displacement,
          strokeWidth: strokeWidth,
          semanticsLabel: semanticsLabel,
          semanticsValue: semanticsValue,
          child: SingleChildScrollView(
            controller: controller,
            primary: primary,
            physics: physics ?? const AlwaysScrollableScrollPhysics(),
            reverse: reverse,
            child: child,
          ),
        );
      },
    );
  }
}
