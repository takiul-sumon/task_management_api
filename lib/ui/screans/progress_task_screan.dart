import 'package:flutter/material.dart';
import 'package:task_management_api/data/models/task_list_model.dart';
import 'package:task_management_api/data/models/task_model.dart';
import 'package:task_management_api/data/services/network_client.dart';
import 'package:task_management_api/data/urls.dart';
import 'package:task_management_api/ui/screans/add_new_task_screan.dart';
import 'package:task_management_api/ui/screans/task_card.dart';
import 'package:task_management_api/ui/widget/snackBarMessenger.dart';

class ProgressTaskScrean extends StatefulWidget {
  const ProgressTaskScrean({super.key});

  @override
  State<ProgressTaskScrean> createState() => _ProgressTaskScreanState();
}

class _ProgressTaskScreanState extends State<ProgressTaskScrean> {
  bool _getNewTaskInProgress = false;

  List<TaskModel> _taskInProgress = [];

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
  void initState() {
    _getAllNewTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Visibility(
        visible: _getNewTaskInProgress == false,
        replacement: CircularProgressIndicator(),
        child: SizedBox(
          height: 600,
          width: 600,
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: _taskInProgress.length,
            primary: false,
            itemBuilder: (context, index) {
              return TaskCard(
                task: Taskstatus.snew,
                taskModel: _taskInProgress[index],
              );
            },
            separatorBuilder: (context, index) => SizedBox(height: 8),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onTapAddNewtask,
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _getAllNewTaskList() async {
    _getNewTaskInProgress = true;

    setState(() {});
    final NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.progresstaskListCountUrl,
    );
    if (response.isSuccess) {
      TaskListModel taskListModel = TaskListModel.formJson(response.data ?? {});
      _taskInProgress = taskListModel.taskList;
    } else {
      showShackBarMessenger(context, response.errorMessage, true);
    }
    _getNewTaskInProgress = false;
    setState(() {});
  }
}
