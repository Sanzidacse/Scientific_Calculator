import 'package:calculator/homepage.dart';
import 'package:flutter/material.dart';
import 'package:day_night_switcher/day_night_switcher.dart';

final _lightTheme = ThemeData(brightness: Brightness.light);
final _darkTheme = ThemeData(
  brightness: Brightness.dark,
);
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  bool _SwitchValue = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _SwitchValue ? _lightTheme : _darkTheme,
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}
