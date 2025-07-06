import 'package:flutter/material.dart';

class BulletText extends StatelessWidget {
  const BulletText({
    super.key,
    required this.text,
    this.space,
  });
  final double? space;

  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 4,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (space != null) SizedBox(width: space),
        const Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: Icon(Icons.circle, size: 4),
        ),
        Expanded(child: Text(text)),
      ],
    );
  }
}
