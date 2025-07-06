import 'package:flutter/material.dart';

/// This function shows a date picker dialog and returns the selected date.
/// If the user cancels the dialog, it returns the original selected date.
///
/// @param context The BuildContext to show the dialog.
/// @param selectedDate The initially selected date.
///
/// @return The selected date or the original selected date if the dialog is cancelled.
Future<DateTime> datePickerDialog({
  required BuildContext context,
  required DateTime selectedDate,
}) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: selectedDate,
    firstDate: DateTime(2000),
    lastDate: DateTime(2101),
  );
  if (picked != null && picked != selectedDate) {
    selectedDate = picked;
  }
  return selectedDate;
}

/// This function shows a success dialog.
///
/// @param context The BuildContext to show the dialog.
/// @param message The message to display in the dialog.
///
/// @return A Future that completes when the dialog is closed.
Future<void> showSuccessDialog({
  required BuildContext context,
  required String message,
}) async {
  return await showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Success'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

/// This function shows an error dialog.
void showErrorDialog({
  required BuildContext context,
  required String message,
  String title = 'Error',
  VoidCallback? onOk,
}) {
  showDialog<void>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: onOk ?? () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
