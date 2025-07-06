import 'package:esl/core/shared/constants.dart';
import 'package:esl/core/theme/app_theme.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class DropdownWithTitle extends StatelessWidget {
  const DropdownWithTitle({super.key, required this.title, required this.items});
  final String title;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: boldTextStyle),

        DropdownButtonFormField(
          value: items.first,
          icon: const Icon(FluentIcons.chevron_down_12_regular),
          items: items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item,),
          );
        }).toList(),
          onChanged: (value) {},
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: AppConstants.eslGrey),
            ),
          ),
        ),
      ],
    );
  }
}
