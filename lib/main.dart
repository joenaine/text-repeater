import 'package:flutter/material.dart';
import 'package:text_repeater/home.dart';

import 'constants/app_colors_const.dart';
import 'constants/app_styles_const.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          scaffoldBackgroundColor: AppColors.white,
          appBarTheme: const AppBarTheme(
              centerTitle: false,
              elevation: 0,
              backgroundColor: AppColors.white,
              toolbarTextStyle: AppStyles.s14w400,
              titleTextStyle: AppStyles.s16w500,
              iconTheme: IconThemeData(color: AppColors.dark)),
          primarySwatch: Colors.blue,
          primaryColor: AppColors.primary,
          fontFamily: 'Nunito',
          iconTheme: const IconThemeData(color: AppColors.dark)),
      home: const Home(),
    );
  }
}
