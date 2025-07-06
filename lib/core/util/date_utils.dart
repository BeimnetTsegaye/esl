import 'package:intl/intl.dart';

  /// This method takes a date string in the format "yyyy-MM-dd" and returns a formatted date string in the format "MMMM dd, yyyy".
  ///
  /// For example, if the input date string is "2023-04-30", the output will be "April 30, 2023".
  ///
  /// @param dateString The date string in the format "yyyy-MM-dd".
  ///
  /// @return The formatted date string in the format "MMMM dd, yyyy".
  String formatDateToMMMMddyyyy(String dateString) {
    final DateTime dateTime = DateTime.parse(dateString);
    return DateFormat('MMMM dd, yyyy').format(dateTime);
  }

  /// This method takes a date string in the format "yyyy-MM-dd" and returns a formatted date string in the format "dd/MM/yyyy".
  ///
  /// For example, if the input date string is "2023-04-30", the output will be "30/04/2023".
  ///
  /// @param dateString The date string in the format "yyyy-MM-dd".
  ///
  /// @return The formatted date string in the format "dd/MM/yyyy".
  String formatDateToDDMMYYYY(String dateString) {
    final DateTime dateTime = DateTime.parse(dateString);
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  /// This method takes a date and returns list of dates for the week starting from that date.
  ///
  /// For example, if the input date is "2025-04-30", the output will be a list of dates from "2025-04-24" to "2025-04-30".
  ///
  /// @param date The date from which to start the week.
  ///
  /// @return A list of dates for the week starting from the input date.
  List<DateTime> getWeekDates(DateTime date) {
    return List.generate(7, (index) => date.add(Duration(days: index)));
  }

  /// This method takes a date and returns a formatted date string in the format "2 days ago", "1 week ago", 'just now' and so on.
  ///
  /// For example, if the input date is "2025-04-30", the output will be "2 days ago" if the current date is "2025-05-02".
  ///
  /// @param date The date to be formatted.
  ///
  /// @return The formatted date string.
  String formatDateToRelative(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inSeconds < 60) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
    } else if (difference.inDays == 1) {
      return '1 day ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 30) {
      return '${(difference.inDays / 7).floor()} week${(difference.inDays / 7).floor() == 1 ? '' : 's'} ago';
    } else if (difference.inDays < 365) {
      return '${(difference.inDays / 30).floor()} month${(difference.inDays / 30).floor() == 1 ? '' : 's'} ago';
    } else {
      return '${(difference.inDays / 365).floor()} year${(difference.inDays / 365).floor() == 1 ? '' : 's'} ago';
    }
  }
