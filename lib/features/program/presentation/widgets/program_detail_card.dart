// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import 'package:esl/core/shared/constants.dart';
import 'package:esl/core/theme/app_theme.dart';
import 'package:esl/features/program/presentation/widgets/lexical_description_view.dart';

class ProgramDetailCard extends StatelessWidget {
  const ProgramDetailCard({
    Key? key,
    required this.title,
    required this.price,
    this.description,
    required this.passPoint,
  }) : super(key: key);

  final String title;

  final String price;
  final Map<String, dynamic>? description;
  final int? passPoint;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: AppConstants.eslGreyText,
            height: 250,
            child: Center(
              child: Image.asset(
                color: AppConstants.eslGrey,
                height: 100,
                AppConstants.engHorizontalGrey$GreyLOGO,
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInfoBox(
                icon: FluentIcons.hat_graduation_12_filled,
                label: '${passPoint.toString()}%',
                suffix: '-Pass Point',
              ),
              if (passPoint != null)
                _buildInfoBox(
                  icon: FluentIcons.wallet_16_filled,
                  label: price,
                  suffix: 'USD',
                ),
            ],
          ),
          if (description != null) ...[
            const SizedBox(height: 10),
            SizedBox(
              height: 700,
              child: LexicalDescriptionView(description: description),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoBox({
    required IconData icon,
    required String label,
    required String suffix,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 40,
      width: 180,
      decoration: BoxDecoration(
        color: AppConstants.eslGreyText,
        // borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppConstants.eslGreen, size: 25),
          const SizedBox(width: 6),
          Text(
            label,
            style: boldTextStyle.copyWith(
              fontSize: 15,
              color: AppConstants.eslGrey,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            suffix,
            style: boldTextStyle.copyWith(color: AppConstants.eslGrey),
          ),
        ],
      ),
    );
  }
}
