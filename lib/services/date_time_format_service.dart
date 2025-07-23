import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

dateFormatService({required String date, required BuildContext context}) {
  try {
    if (date.isEmpty) {
      return date;
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
