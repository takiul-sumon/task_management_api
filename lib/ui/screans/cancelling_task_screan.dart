import 'package:flutter/material.dart';
import 'package:task_management_api/ui/screans/add_new_task_screan.dart';
import 'package:task_management_api/ui/screans/task_card.dart';

class CancelTaskScrean extends StatefulWidget {
  const CancelTaskScrean({super.key});

  @override
  State<CancelTaskScrean> createState() => _CancelTaskScreanState();
}

class _CancelTaskScreanState extends State<CancelTaskScrean> {
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
          return TaskCard(task: Taskstatus.cancle);
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
