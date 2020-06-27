import 'package:flutter/material.dart';

class Constants {
  static DateTime convertDateTime(TimeOfDay time) {
    var today = DateTime.now();
    return DateTime.utc(
        today.year, today.month, today.day, time.hour, time.minute);
  }
}
