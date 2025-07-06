// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:esl/features/program/presentation/widgets/lexical_description_view.dart';
import 'package:flutter/material.dart';

import 'package:esl/core/shared/constants.dart';
import 'package:esl/core/theme/app_theme.dart';
import 'package:esl/features/program/domain/entities/program.dart';

class ProgramDetailSheet extends StatelessWidget {
  final String title;
  final String price;
  final Map<String, dynamic>? description;
  const ProgramDetailSheet({
    Key? key,
    required this.title,
    required this.price,
    this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Text(title, style: boldTextStyle.copyWith(fontSize: 22)),
            const SizedBox(height: 8),
            Text(
              price,
              style: boldTextStyle.copyWith(
                color: AppConstants.eslGreen,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20),
            if (description != null) ...[
              Text('Overview', style: boldTextStyle.copyWith(fontSize: 18)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: LexicalDescriptionView(description: description),
              ),
            ],
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppConstants.eslGreen,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  'Close',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void show({required BuildContext context, required Program program}) {
    // Format the description to match Lexical JSON structure if it's a string
    Map<String, dynamic>? formattedDescription;
    if (program.description != null) {
      if (program.description is String) {
        formattedDescription = {
          'root': {
            'children': [
              {
                'children': [
                  {'text': program.description},
                ],
                'direction': 'ltr',
                'format': '',
                'indent': 0,
                'type': 'paragraph',
                'version': 1,
              },
            ],
            'direction': 'ltr',
            'format': '',
            'indent': 0,
            'type': 'root',
            'version': 1,
          },
        };
      } else if (program.description is Map<String, dynamic>) {
        formattedDescription = program.description as Map<String, dynamic>;
      }
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ProgramDetailSheet(
        title: program.name ?? 'Program',
        price: program.price ?? 'Price not available',
        description: formattedDescription,
      ),
    );
  }
}
