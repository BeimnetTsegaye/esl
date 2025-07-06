import 'package:esl/core/shared/constants.dart';
import 'package:esl/core/theme/app_theme.dart';
import 'package:esl/core/widgets/bullet_text.dart';
import 'package:flutter/material.dart';

class PartnerCard extends StatelessWidget {
  const PartnerCard({
    super.key,
    required this.partnerName,
    required this.partnerDetails,
    this.isExpanded = false,
  });

  final String partnerName;
  final Map<String, dynamic> partnerDetails;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        initiallyExpanded: isExpanded,
        title: Text(
          partnerName,
          style: boldTextStyle.copyWith(color: AppConstants.eslGreen),
        ),
        subtitle: Text(
          partnerDetails['location'] as String,
          style: boldTextStyle.copyWith(color: AppConstants.eslGreen),
        ),
        children: [
           Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Divider(color: currentThemeNotifier.value == lightMode ? AppConstants.eslGreyTint : AppConstants.eslDarkGreyTint, thickness: 2),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(partnerDetails['description'] as String),
          ),
          ListTile(
            title: const Text('Services', style: boldTextStyle),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  (partnerDetails['services'] as List<String>)
                      .map(
                        (service) => BulletText(text: service),
                      )
                      .toList(),
            ),
          ),
          ListTile(
            title: const Text('Vacancies', style: boldTextStyle),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  (partnerDetails['vacancies'] as List<String>).map((vacancy) {
                    final String title = vacancy.split(':')[0];
                    final String salary = vacancy.split(':')[1];
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(title),
                        Text(
                          salary,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppConstants.eslGreen,
                          ),
                        ),
                      ],
                    );
                  }).toList(),
            ),
          ),
          //apply now text button
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () {
                // Handle apply now action
              },
              child: const Text('Apply Now', style: boldTextStyle),
            ),
          ),
        ],
      ),
    );
  }
}
