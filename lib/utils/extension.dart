import 'package:flutter/material.dart';
import 'package:renda_assessment/app.dart';
import 'package:intl/intl.dart';

double get fullHeight =>
    MediaQuery.of(navigatorKey.currentState!.context).size.height;

double get fullWidth =>
    MediaQuery.of(navigatorKey.currentState!.context).size.width;


extension AssetExtensions on String {
  String get png => 'assets/png_files/$this.png';
  String get svg => 'assets/svg_files/$this.svg';
}

String formatSystemDate(DateTime value, ) {
  // Parse the input date string

  // Format the date
  String formattedDate = DateFormat("d MMMM, y - h:mm a").format(value);

  return formattedDate;
}

String formatSystemDateShort(String value) {
  // Parse the input date string
  DateTime dateTime = DateTime.parse(value).toLocal(); // Convert to local time

  // Format the date
  String formattedDate = DateFormat("d MMM, y - h:mm a").format(dateTime);

  return formattedDate;
}
