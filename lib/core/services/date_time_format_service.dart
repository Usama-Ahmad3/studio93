import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

dateFormatService({required String date, required BuildContext context}) {
  try {
    if (date.isEmpty) {
      return date;
    }
    // Ensure time is in proper format (e.g. '0:17' ➝ '00:17')
    if (RegExp(r'\d{4}-\d{2}-\d{2} \d{1}:\d{2}').hasMatch(date)) {
      date = date.replaceFirstMapped(
        RegExp(r' (\d{1}):'),
        (match) => ' 0${match.group(1)}:',
      );
    }
    DateTime dateTime = DateTime.parse(date);

    return DateFormat("d MMMM 'at' h:mm a").format(dateTime);
  } catch (e) {
    if (kDebugMode) {
      print("Error parsing date: $e");
    }
    return date;
  }
}
