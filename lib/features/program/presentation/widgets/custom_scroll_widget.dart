import 'package:flutter/material.dart';
import 'package:flutter_lexical_reader/flutter_lexical_reader.dart';

class CustomScrollViewWidget extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;
  final bool? primary;
  final ScrollController? controller;

  const CustomScrollViewWidget({
    super.key,
    required this.children,
    this.padding,
    this.physics,
    this.primary,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: controller,
      physics: physics ?? const AlwaysScrollableScrollPhysics(),
      primary: primary ?? true,
      slivers: [
        SliverPadding(
          padding: padding ?? const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return children[index];
            }, childCount: children.length),
          ),
        ),
      ],
    );
  }
}

class NestedScrollableWidget extends StatelessWidget {
  final Widget child;
  final ScrollPhysics? physics;
  final bool? primary;

  const NestedScrollableWidget({
    super.key,
    required this.child,
    this.physics,
    this.primary,
  });

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        return false;
      },
      child: SingleChildScrollView(
        physics: physics ?? const NeverScrollableScrollPhysics(),
        primary: primary ?? false,
        child: child,
      ),
    );
  }
}

class ScrollableLexicalWidget extends StatelessWidget {
  final Map<String, dynamic> sourceMap;
  final double? maxHeight;
  final EdgeInsetsGeometry? padding;

  const ScrollableLexicalWidget({
    super.key,
    required this.sourceMap,
    this.maxHeight,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: maxHeight != null
          ? BoxConstraints(maxHeight: maxHeight!)
          : null,
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Padding(
          padding: padding ?? EdgeInsets.zero,
          child: LexicalParser(
            sourceMap: sourceMap,
            shrinkWrap: true,
            scrollPhysics: const NeverScrollableScrollPhysics(),
          ),
        ),
      ),
    );
  }
}
