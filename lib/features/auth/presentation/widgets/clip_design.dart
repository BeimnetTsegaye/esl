import 'package:esl/core/shared/constants.dart';
import 'package:flutter/material.dart';

class ClipDesign extends StatelessWidget {
  const ClipDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(height: 100, color: Colors.white),

        // Green diagonal (bottom layer)
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Stack(
            children: [
              // Clipped container
              ClipPath(
                clipper: GreenDiagonalClipper(),
                child: Container(
                  height: 85,
                  color: AppConstants.eslGreen,
                ),
              ),
              // Shadow on top (only top edge)
              CustomPaint(
                painter: InwardShadowPainter(
                  clipper: GreenDiagonalClipper(),
                  shadow: BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ),
                size: const Size(double.infinity, 85),
              ),
            ],
          ),
        ),
        // Yellow diagonal (top layer)
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Stack(
            children: [
              // Clipped container
              ClipPath(
                clipper: YellowDiagonalClipper(),
                child: Container(
                  height: 60,
                  color: AppConstants.eslYellow,
                ),
              ),
              // Shadow on top (only top edge)
              CustomPaint(
                painter: InwardShadowPainter(
                  clipper: YellowDiagonalClipper(),
                  shadow: BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ),
                size: const Size(double.infinity, 60),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class YellowDiagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.moveTo(size.width, 0); // Top-right
    path.lineTo(0, size.height * 0.7); // Bottom-left
    path.lineTo(size.width, size.height * 0.7); // Bottom-right
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class GreenDiagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0, size.height * 0.5); // Top-left
    path.lineTo(size.width * 0.7, size.height * 0.4); // Top-right
    path.lineTo(0, size.height); // Bottom-left
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class InwardShadowPainter extends CustomPainter {
  final CustomClipper<Path> clipper;
  final BoxShadow shadow;

  InwardShadowPainter({required this.clipper, required this.shadow});

  @override
  void paint(Canvas canvas, Size size) {
    // Create a paint object for the shadow
    final Paint shadowPaint = Paint()
      ..color = shadow.color
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, shadow.blurRadius)
      ..style = PaintingStyle.stroke
      ..strokeWidth = shadow.spreadRadius * 2; // Adjust thickness of the shadow

    // Create a new path for only the top edge
    final Path topEdgePath = Path();

    if (clipper is GreenDiagonalClipper) {
      // For GreenDiagonalClipper: Top edge from (0, 0) to (0, height * 0.5) to (width * 0.7, height * 0.4)
      topEdgePath.moveTo(0, 0);
      topEdgePath.lineTo(0, size.height * 0.5);
      topEdgePath.lineTo(size.width * 0.7, size.height * 0.4);
    } else if (clipper is YellowDiagonalClipper) {
      // For YellowDiagonalClipper: Top edge from (width, 0) to (0, height * 0.7)
      topEdgePath.moveTo(size.width, 0);
      topEdgePath.lineTo(0, size.height * 0.7);
    }

    // Draw shadow only along the top edge
    canvas.drawPath(topEdgePath, shadowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
