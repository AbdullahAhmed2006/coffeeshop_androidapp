import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'providers/coffee_provider.dart';
import 'providers/theme_provider.dart';
import 'intro_page.dart';
import 'utils/app_colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppColors.kBackgroundDark,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CoffeeProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Coffee Shop',
      themeMode: themeProvider.themeMode,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.kBackgroundLight,
        colorScheme: const ColorScheme.light(
          primary: AppColors.kPrimaryOrange,
          surface: AppColors.kCardLight,
          onSurface: AppColors.kTextPrimaryLight,
        ),
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.kBackgroundLight,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.kTextPrimaryLight),
          titleTextStyle: TextStyle(
            color: AppColors.kTextPrimaryLight,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.kBackgroundDark,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.kPrimaryOrange,
          surface: AppColors.kCardDark,
          onSurface: AppColors.kTextPrimaryDark,
        ),
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.kBackgroundDark,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.kTextPrimaryDark),
          titleTextStyle: TextStyle(
            color: AppColors.kTextPrimaryDark,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const IntroPage(),
    );
  }
}
