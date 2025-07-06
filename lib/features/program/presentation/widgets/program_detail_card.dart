import 'package:esl/core/shared/constants.dart';
import 'package:esl/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ProgramDetailCard extends StatelessWidget {
  const ProgramDetailCard({
    super.key,
    required this.title,
    required this.price,
    this.description,
    this.onViewDetails,
  });

  final String title;
  final String price;
  final Map<String, dynamic>? description;
  final VoidCallback? onViewDetails;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: AppConstants.eslGreyText),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: boldTextStyle.copyWith(fontSize: 20)),
          Text(
            '\$${price.replaceAll(RegExp(r'[^\d.]'), '')}',
            style: boldTextStyle.copyWith(
              color: AppConstants.eslGreen,
              fontSize: 20,
            ),
          ),
          if (description != null) ...[
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: TextButton.icon(
                onPressed: onViewDetails,
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF3A006C),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: Color(0xFF3A006C)),
                  ),
                ),
                icon: const Icon(Icons.info_outline, size: 20),
                label: const Text('View Details'),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
// import 'package:esl/core/shared/constants.dart';
// import 'package:esl/core/theme/app_theme.dart';
// import 'package:esl/features/program/presentation/widgets/lexical_description_view.dart';
// import 'package:flutter/material.dart';

// class ProgramDetailCard extends StatelessWidget {
//   const ProgramDetailCard({
//     super.key,
//     required this.title,
//     required this.price,
//     this.description,
//   });

//   final String title;
//   final String price;
//   final Map<String, dynamic>? description;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         border: Border.all(color: AppConstants.eslGreyText),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(title, style: boldTextStyle.copyWith(fontSize: 20)),
//           Text(
//             price,
//             style: boldTextStyle.copyWith(color: AppConstants.eslGreen),
//           ),
//           if (description != null) ...[
//             const SizedBox(height: 10),
//             SizedBox(
//               height: 200,
//               child: LexicalDescriptionView(description: description),
//             ),
//           ],
//         ],
//       ),
//     );
//   }
// }
