import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatDateTimetoDate(dateTime) {
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('EEEE, d MMMM y');
  final String formatted = formatter.format(now);
  return formatted; // something like 2013-04-20
}

String formatDateTimetoTime(dateTime) {
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('Hm');
  final String formatted = formatter.format(now);
  return formatted; // something like 2013-04-20
}

iconPicker(weatherType) {
  return weatherType.contains('cloudy')
      ? Icons.cloud
      : weatherType.contains("clear")
          ? Icons.sunny
          : weatherType.contains("snow")
              ? Icons.snowing
              : weatherType.contains("rain")
                  ? Icons.water
                  : Icons.sunny;
}
