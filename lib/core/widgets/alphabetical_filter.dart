import 'package:esl/core/shared/constants.dart';
import 'package:esl/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AlphabeticalFilter extends StatefulWidget {
  const AlphabeticalFilter({super.key,
    required this.selectedOption,
    required this.onOptionSelected,
  });
  final String? selectedOption;
  final void Function(String) onOptionSelected;

  @override
  State<AlphabeticalFilter> createState() => _AlphabeticalFilterState();
}

class _AlphabeticalFilterState extends State<AlphabeticalFilter> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(26, (index) {
          final letter = String.fromCharCode(65 + index);
          final isSelected = widget.selectedOption == letter;

          return GestureDetector(
            onTap: () {
              widget.onOptionSelected(letter);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                letter,
                style: TextStyle(
                  color:
                      isSelected ? AppConstants.eslGreen : currentThemeNotifier.value == lightMode ? AppConstants.eslGrey : AppConstants.eslGreyTint,
                  decoration:
                      isSelected
                          ? TextDecoration.underline
                          : TextDecoration.none,
                  decorationColor:
                      isSelected ? AppConstants.eslGreen : AppConstants.eslGrey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
