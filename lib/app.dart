
import 'package:flutter/material.dart';
import 'package:task_management_api/ui/screans/splash_screan.dart';

class TaskManager extends StatelessWidget {
  const TaskManager({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(fontWeight: FontWeight.w400, color: Colors.grey),
          border: _zeroOutlinedBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: _zeroOutlinedBorder(),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            // foregroundColor: Colors.white,
            fixedSize: Size.fromWidth(double.maxFinite),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          bodyLarge: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ).copyWith(color: Colors.grey),
        ),
      ),
      home: splash_Screan(),
    );
  }
}

OutlineInputBorder _zeroOutlinedBorder() {
  return OutlineInputBorder(borderSide: BorderSide.none);
}
