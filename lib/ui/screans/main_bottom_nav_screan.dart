import 'package:flutter/material.dart';
import 'package:task_management_api/ui/screans/NewTaskScrean.dart';
import 'package:task_management_api/ui/widget/tm_app_bar.dart';

class MainBottomNavScrean extends StatefulWidget {
  const MainBottomNavScrean({super.key});

  @override
  State<MainBottomNavScrean> createState() => _MainBottomNavScreanState();
}

class _MainBottomNavScreanState extends State<MainBottomNavScrean> {
  int _selected_index = 0;
  final List<Widget> _screans = [
    NewTaskScrean(),
    NewTaskScrean(),
    NewTaskScrean(),
    NewTaskScrean(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: _screans[_selected_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selected_index,
        onDestinationSelected: (value) {
          _selected_index = value;
          setState(() {});
        },
        destinations: [
          NavigationDestination(icon: Icon(Icons.new_label), label: 'New'),
          NavigationDestination(
            icon: Icon(Icons.ac_unit_sharp),
            label: 'Progress',
          ),
          NavigationDestination(icon: Icon(Icons.done), label: 'Complete'),
          NavigationDestination(
            icon: Icon(Icons.cancel_outlined),
            label: 'Cancelled',
          ),
        ],
      ),
    );
  }
}
