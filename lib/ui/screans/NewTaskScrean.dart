import 'package:flutter/material.dart';
import 'package:task_management_api/ui/screans/add_new_task_screan.dart';
import 'package:task_management_api/ui/screans/task_card.dart';
import 'package:task_management_api/ui/widget/summary_card.dart';

class NewTaskScrean extends StatefulWidget {
  const NewTaskScrean({super.key});

  @override
  State<NewTaskScrean> createState() => _NewTaskScreanState();
}

class _NewTaskScreanState extends State<NewTaskScrean> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildSummarySection(),
            ListView.separated(
              shrinkWrap: true,
              primary: false,
              itemBuilder: (context, index) {
                return TaskCard(task: Taskstatus.snew);
              },
              separatorBuilder: (context, index) => SizedBox(height: 8),
              itemCount: 6,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onTapAddNewtask,
        child: Icon(Icons.add),
      ),
    );
  }

  onTapAddNewtask() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return AddNewTaskScrean();
        },
      ),
    );
  }

  Widget buildSummarySection() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          SummaryTask(title: 'new', count: 10),
          SummaryTask(title: 'Progress', count: 10),
          SummaryTask(title: 'Complete', count: 10),
          SummaryTask(title: 'Cancelled', count: 10),
        ],
      ),
    );
  }
}
