
import 'package:flutter/material.dart';

class SummaryTask extends StatelessWidget {
  const SummaryTask({super.key, required this.title, required this.count});
  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            Text(
              '$count',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text('$title', style: TextStyle(fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
