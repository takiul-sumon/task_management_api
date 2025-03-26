import 'package:flutter/material.dart';

enum Taskstatus { snew, progress, complete, cancle }

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.task});
  final Taskstatus task;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title will be here',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text('Description will be here'),
            Text('Date will be here:11/22/2025'),
            Row(
              children: [
                Chip(
                  label: Text('data', style: TextStyle(color: Colors.white)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  backgroundColor: chooseColor(),
                ),
                Spacer(),
                IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
                IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color chooseColor() {
    if (task == Taskstatus.snew) {
      return Colors.blue;
    } else if (task == Taskstatus.progress) {
      return Colors.red;
    } else if (task == Taskstatus.complete) {
      return Colors.orange;
    } else if (task == Taskstatus.cancle) {
      return Colors.green;
    } else {
      return Colors.transparent;
    }
  }
}
