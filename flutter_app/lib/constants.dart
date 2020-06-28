import 'package:flutter/material.dart';

class Constants {
  static DateTime convertDateTime(TimeOfDay time) {
    var today = DateTime.now().toUtc();
    return DateTime.utc(
        today.year, today.month, today.day, time.hour, time.minute);
  }
}
