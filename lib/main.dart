import 'package:expense_tracker/widgets/expenses_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// var kColorScheme = ColorScheme.fromSeed(
//   seedColor: const Color.fromARGB(255, 96, 59, 181),
// );

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 0, 2, 12),
  // seedColor: Color.fromARGB(255, 119, 76, 219),
);

// var kDarkColorScheme = ColorScheme.fromSeed(
//   brightness: Brightness.dark,
//   seedColor: const Color.fromARGB(255, 5, 99, 125),
// );

var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  // seedColor: Color.fromARGB(255, 119, 76, 219),
  seedColor: const Color.fromARGB(255, 0, 2, 12),
);

void main() {
  // WidgetsFlutterBinding
  //     .ensureInitialized(); //this is used to make sure the below code works as it is supposed to
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp
  // ]) // this is used to lock the device orientation for the app and then run the app
  //     .then((function){});

  runApp(
    MaterialApp(
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
          // centerTitle: true
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.primaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 4.0),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.secondaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.bold,
                color: kColorScheme.onPrimaryContainer,
              ),
            ),
        iconTheme: ThemeData().iconTheme.copyWith(
              color: kColorScheme.onPrimaryContainer,
            ),
        snackBarTheme: ThemeData().snackBarTheme.copyWith(
              backgroundColor: kColorScheme.onPrimaryContainer,
            ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kDarkColorScheme,
        cardTheme: const CardTheme().copyWith(
          color: kDarkColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 4.0),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.secondaryContainer,
            foregroundColor: kDarkColorScheme.onPrimaryContainer,
          ),
        ),
        snackBarTheme: ThemeData().snackBarTheme.copyWith(
              backgroundColor: kDarkColorScheme.onSecondaryContainer,
            ),
      ),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const ExpensesApp(),
    ),
  );
}
