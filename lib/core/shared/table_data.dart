class TableData<T> {
  final List<String> columnHeaders; // Header row (e.g., time slots)
  final List<TableRowData<T>> rows; // Rows with label and cell values

  TableData({required this.columnHeaders, required this.rows});

  // Convert to Map<String, List<String>> for compatibility with TableWithYellowColumn
  Map<String, List<String>> toMapString() {
    final map = <String, List<String>>{};
    // Add header row
    map[''] = columnHeaders;
    // Add data rows
    for (final row in rows) {
      map[row.label] = row.values.map((value) => value.toString()).toList();
    }
    return map;
  }
}

class TableRowData<T> {
  final String label; // First column label (e.g., day of week)
  final List<T> values; // Cell values for the row

  TableRowData({required this.label, required this.values});
}
