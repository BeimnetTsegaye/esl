import 'package:esl/core/shared/constants.dart';
import 'package:esl/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class TableWithYellowColumn extends StatelessWidget {
  const TableWithYellowColumn({
    super.key,
    required this.data,
  });

  final Map<String, List<String>> data;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: TableBorder.all(color: AppConstants.eslGreyText),
        defaultColumnWidth: const IntrinsicColumnWidth(),
        children:
            data.entries.map((entry) {
              final rows = [entry.key, ...entry.value];
              return TableRow(
                children:
                    rows.map((cell) {
                      final isFirstColumn = rows.first == cell;
                        final isFirstRow = data.entries.first.key == entry.key;
                      return Container(
                        color:
                            isFirstColumn
                                ? AppConstants.eslYellow
                                : isFirstRow ? AppConstants.eslGreyTint.withAlpha(150) : null,
                          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                        child: Text(
                          cell,
                          style:
                              isFirstColumn || isFirstRow
                                  ? boldTextStyle
                                  : null,
                        ),
                      );
                    }).toList(),
              );
            }).toList(),
      ),
    );
  }
}
