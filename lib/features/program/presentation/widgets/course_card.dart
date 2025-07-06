// import 'package:esl/core/shared/constants.dart';
// import 'package:esl/core/theme/app_theme.dart';
// import 'package:esl/features/program/presentation/widgets/lexical_description_view.dart';
// import 'package:flutter/material.dart';

// class CourseCard extends StatelessWidget {
//   const CourseCard({
//     super.key,
//     required this.title,
//     required this.duration,
//     required this.description,
//   });

//   final String title;
//   final String duration;
//   final Map<String, dynamic> description;

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 2,
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//         side: BorderSide(color: Colors.grey.shade200),
//       ),
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12),
//           color: Colors.white,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         title,
//                         style: const TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xFF1E293B),
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       // Course Code/Duration
//                       Text(
//                         duration,
//                         style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//                       ),
//                     ],
//                   ),
//                 ),
//                 // Status indicator (optional)
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 8,
//                     vertical: 4,
//                   ),
//                   decoration: BoxDecoration(
//                     color: AppConstants.eslGreen.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Text(
//                     'In Progress', // You can make this dynamic
//                     style: TextStyle(
//                       color: AppConstants.eslGreen,
//                       fontSize: 12,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 12),
//             // Description section
//             if (description.isNotEmpty)
//               ConstrainedBox(
//                 constraints: const BoxConstraints(maxHeight: 120),
//                 child: LexicalDescriptionView(description: description),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:esl/core/shared/constants.dart';
import 'package:esl/core/theme/app_theme.dart';
import 'package:esl/features/program/presentation/widgets/lexical_description_view.dart';
import 'package:flutter/material.dart';

class CourseCard extends StatefulWidget {
  const CourseCard({
    super.key,
    required this.title,
    required this.duration,
    required this.description,
  });
  
  final String title;
  final String duration;
  final Map<String, dynamic> description;

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: InkWell(
        onTap: () => setState(() => _isExpanded = !_isExpanded),
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with icon and title
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(
                    Icons.schedule,
                    color: AppConstants.eslGreen,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.duration,
                          style: const TextStyle(
                            color: AppConstants.eslGreen,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.title,
                          style: boldTextStyle.copyWith(fontSize: 16),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            // Description that expands/collapses
            if (_isExpanded) ..._buildDescription(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildDescription() {
    // Format the description if it's a string
    final description = {
      'root': {
        'children': [
          {
            'children': [
              {'text': widget.description.toString()}
            ],
            'direction': 'ltr',
            'format': '',
            'indent': 0,
            'type': 'paragraph',
            'version': 1
          }
        ],
        'direction': 'ltr',
        'format': '',
        'indent': 0,
        'type': 'root',
        'version': 1
      }
    };

    return [
      const Divider(height: 1, thickness: 1),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Course Description',
              style: boldTextStyle.copyWith(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 8),
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 300),
              child: SingleChildScrollView(
                child: LexicalDescriptionView(description: description),
              ),
            ),
          ],
        ),
      ),
    ];
  }
}
