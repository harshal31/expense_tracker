import 'package:first_expense_tracker/theme/theme.dart';
import 'package:first_expense_tracker/widgets/expenses.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    SafeArea(
      child: _MyApp(),
    ),
  );
}

class _MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark().copyWith(
          useMaterial3: true,
          colorScheme: kDarkColorScheme,
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kDarkColorScheme.primaryContainer,
            foregroundColor: kDarkColorScheme.onPrimaryContainer,
          ),
          cardTheme: const CardTheme().copyWith(
            margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
            elevation: 6.0,
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              foregroundColor: kDarkColorScheme.onPrimaryContainer,
            ),
          ),
          textTheme: GoogleFonts.jetBrainsMonoTextTheme(
            ThemeData.dark()
                .copyWith(brightness: Brightness.dark)
                .textTheme, //dark or white depends on usuage
          ),
          snackBarTheme: const SnackBarThemeData().copyWith(
            backgroundColor: kDarkColorScheme.background,
            actionTextColor: kDarkColorScheme.onPrimaryContainer,
            actionBackgroundColor:
                kColorScheme.primaryContainer.withOpacity(0.4),
          ),
          datePickerTheme: const DatePickerThemeData().copyWith()),
      theme: ThemeData().copyWith(
        brightness: Brightness.light,
        useMaterial3: true,
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.primaryContainer,
          foregroundColor: kColorScheme.onPrimaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
          elevation: 6.0,
        ),
        textTheme:
            GoogleFonts.jetBrainsMonoTextTheme(Theme.of(context).textTheme),
      ),
      home: const Expenses(),
    );
  }
}
