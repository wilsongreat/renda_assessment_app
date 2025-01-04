import 'package:flutter/material.dart';
import 'package:renda_assessment/app.dart';

double get fullHeight =>
    MediaQuery.of(navigatorKey.currentState!.context).size.height;

double get fullWidth =>
    MediaQuery.of(navigatorKey.currentState!.context).size.width;


extension AssetExtensions on String {
  String get png => 'assets/png_files/$this.png';
  String get svg => 'assets/svg_files/$this.svg';
}

