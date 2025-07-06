import 'package:flutter/material.dart';
import 'package:esl/core/shared/constants.dart';

class ScrollableDotsIndicator extends StatelessWidget {
  final int dotsCount;
  final double position;
  final int visibleDots;
  final double dotSize;
  final double activeDotWidth;
  final double dotSpacing;
  final Color activeColor;
  final Color inactiveColor;

  const ScrollableDotsIndicator({
    super.key,
    required this.dotsCount,
    required this.position,
    this.visibleDots = 3,
    this.dotSize = 12.0,
    this.activeDotWidth = 30.0,
    this.dotSpacing = 8.0,
    this.activeColor = AppConstants.eslGreen,
    this.inactiveColor = AppConstants.eslGreyTint,
  });

  @override
  Widget build(BuildContext context) {
    if (dotsCount <= visibleDots) {
      // If total dots are less than or equal to visible dots, show all
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(dotsCount, (index) {
          final isActive = index == position.round();
          return _buildDot(index, isActive);
        }),
      );
    }

    // Calculate which dots to show
    final startIndex = _calculateStartIndex();
    final endIndex = startIndex + visibleDots;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(visibleDots, (index) {
          final actualIndex = startIndex + index;
          final isActive = actualIndex == position.round();
          return _buildDot(actualIndex, isActive);
        }),
      ),
    );
  }

  int _calculateStartIndex() {
    final maxStartIndex = dotsCount - visibleDots;
    final currentPosition = position.round();
    
    // If current position is in the first visibleDots, start from 0
    if (currentPosition < visibleDots) {
      return 0;
    }
    
    // If current position is in the last visibleDots, start from maxStartIndex
    if (currentPosition >= maxStartIndex) {
      return maxStartIndex;
    }
    
    // Otherwise, center the current position
    return currentPosition - (visibleDots ~/ 2);
  }

  Widget _buildDot(int index, bool isActive) {
    return Container(
      margin: EdgeInsets.only(right: index < dotsCount - 1 ? dotSpacing : 0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: isActive ? activeDotWidth : dotSize,
        height: dotSize,
        decoration: BoxDecoration(
          color: isActive ? activeColor : inactiveColor,
          borderRadius: BorderRadius.circular(dotSize / 2),
        ),
      ),
    );
  }
} 