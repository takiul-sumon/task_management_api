import 'package:flutter/material.dart';
import 'package:task_management_api/data/models/task_model.dart';
import 'package:task_management_api/data/services/network_client.dart';
import 'package:task_management_api/data/urls.dart';
import 'package:task_management_api/ui/widget/snackBarMessenger.dart';

enum Taskstatus { snew, progress, complete, cancle }

class TaskCard extends StatefulWidget {
  const TaskCard({super.key, required this.task, required this.taskModel});
  final Taskstatus task;
  final TaskModel taskModel;


  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  void showUpdateStatusDialogue() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () {
                  if (isSelected('New')) return;
                  _changeTaskStatus('New');
                  popDialogue();
                },
                title: Text("New"),
                trailing: isSelected('Completed') ? Icon(Icons.done) : null,
              ),
              ListTile(
                onTap: () {
                  if (isSelected('Progress')) return;
                  _changeTaskStatus('Progress');
                  popDialogue();
                },
                title: Text("Progress"),
                trailing: isSelected('New') ? Icon(Icons.done) : null,
              ),
              ListTile(
                onTap: () {
                  if (isSelected('Completed')) return;
                  _changeTaskStatus('Completed');
                  popDialogue();
                },
                title: Text("Completed"),
                trailing: isSelected('Completed') ? Icon(Icons.done) : null,
              ),
              ListTile(
                onTap: () {
                  if (isSelected('Cancelled')) return;
                  _changeTaskStatus('Cancelled');
                  popDialogue();
                },
                title: Text("Cancelled"),
                trailing: isSelected('Completed') ? Icon(Icons.done) : null,
              ),
            ],
          ),
        );
      },
    );
  }

  bool inProgress = false;
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
              widget.taskModel.title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(widget.taskModel.description),
            Text('Date : ${widget.taskModel.createData}'),
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
                IconButton(onPressed: _deleteTask, icon: Icon(Icons.delete)),
                IconButton(
                  onPressed: showUpdateStatusDialogue,
                  icon: Icon(Icons.edit),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void popDialogue() {
    Navigator.pop(context);
  }

  Future<void> _changeTaskStatus(String status) async {
    inProgress = true;
    setState(() {});
    final NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.updateTaskStatusUrl(widget.taskModel.id, status),
    );
    inProgress = false;
    setState(() {});
    if (response.isSuccess) {
    } else {
      showShackBarMessenger(context, response.errorMessage, true);
    }
  }

  Future<void> _deleteTask() async {
    inProgress = true;
    setState(() {});
    final NetworkResponse response = await NetworkClient.getRequest(
        url: Urls.deleteTaskUrl(widget.taskModel.id));

    inProgress = false;
    if (response.isSuccess) {
      // widget.refreshList();
    } else {
      setState(() {});
      showShackBarMessenger(context, response.errorMessage, true);
    }
  }

  bool isSelected(String status) => widget.taskModel.status == status;
  Color chooseColor() {
    if (widget.task == Taskstatus.snew) {
      return Colors.blue;
    } else if (widget.task == Taskstatus.progress) {
      return Colors.red;
    } else if (widget.task == Taskstatus.complete) {
      return Colors.orange;
    } else if (widget.task == Taskstatus.cancle) {
      return Colors.green;
    } else {
      return Colors.transparent;
    }
  }
}
