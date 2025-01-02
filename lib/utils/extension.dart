import 'package:flutter/material.dart';
import 'package:renda_assessment/app.dart';

double get fullHeight =>
    MediaQuery.of(navigatorKey.currentState!.context).size.height;

double get fullWidth =>
    MediaQuery.of(navigatorKey.currentState!.context).size.width;

double get getContainerHeight {
  final mq = MediaQuery.of(navigatorKey.currentState!.context);
  return mq.size.height - AppBar().preferredSize.height - mq.padding.vertical;
}

extension AssetExtensions on String {
  String get png => 'assets/png_files/$this.png';
  String get svg => 'assets/svg_files/$this.svg';
}

extension StringExtension on String {
  String capitalizeFirsLetter() {
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
}
