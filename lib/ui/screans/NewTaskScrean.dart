import 'package:flutter/material.dart';
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
      body: Column(
        children: [
          buildSummarySection(),
          TaskCard(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
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

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
  });

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
                  label: Text(
                    'data',
                    style: TextStyle(color: Colors.white),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  backgroundColor: Colors.blue,
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
}
