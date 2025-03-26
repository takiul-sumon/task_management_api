import 'package:flutter/material.dart';
import 'package:task_management_api/ui/screans/add_new_task_screan.dart';
import 'package:task_management_api/ui/screans/task_card.dart';

class ProgressTaskScrean extends StatefulWidget {
  const ProgressTaskScrean({super.key});

  @override
  State<ProgressTaskScrean> createState() => _ProgressTaskScreanState();
}

class _ProgressTaskScreanState extends State<ProgressTaskScrean> {
  onTapAddNewtask() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return AddNewTaskScrean();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        shrinkWrap: true,
        primary: false,
        itemBuilder: (context, index) {
          return TaskCard(task: Taskstatus.progress);
        },
        separatorBuilder: (context, index) => SizedBox(height: 8),
        itemCount: 6,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onTapAddNewtask,
        child: Icon(Icons.add),
      ),
    );
  }
}
