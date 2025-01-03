import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:renda_assessment/app.dart';
import 'package:renda_assessment/res/cache_storage.dart';

GetIt locator = GetIt.instance;
void main() {
  locator.registerLazySingleton<SharedPrefs>(SharedPrefs.new);
   locator.get<SharedPrefs>().init();
  runApp(const ProviderScope(child: MyApp()));
}
