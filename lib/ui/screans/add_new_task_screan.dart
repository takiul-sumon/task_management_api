import 'package:flutter/material.dart';
import 'package:task_management_api/ui/widget/screan_Background.dart';
import 'package:task_management_api/ui/widget/tm_app_bar.dart';

class AddNewTaskScrean extends StatefulWidget {
  const AddNewTaskScrean({super.key});

  @override
  State<AddNewTaskScrean> createState() => _AddNewTaskScreanState();
}

class _AddNewTaskScreanState extends State<AddNewTaskScrean> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: SingleChildScrollView(child: ScreanBackground(child: Column())),
    );
  }
}
