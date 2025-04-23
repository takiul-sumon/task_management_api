import 'package:flutter/material.dart';
import 'package:task_management_api/data/models/task_list_model.dart';
import 'package:task_management_api/data/models/task_model.dart';
import 'package:task_management_api/data/services/network_client.dart';
import 'package:task_management_api/data/urls.dart';
import 'package:task_management_api/ui/screans/add_new_task_screan.dart';
import 'package:task_management_api/ui/screans/task_card.dart';
import 'package:task_management_api/ui/widget/snackBarMessenger.dart';

class CompleteTaskScrean extends StatefulWidget {
  const CompleteTaskScrean({super.key});

  @override
  State<CompleteTaskScrean> createState() => _CompleteTaskScreanState();
}

class _CompleteTaskScreanState extends State<CompleteTaskScrean> {
  bool _getCompletedtaskInProgress = false;

  List<TaskModel> _taskInCompleted = [];

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
    super.initState();
    _getAllCancelledTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Visibility(
        visible: _getCompletedtaskInProgress == false,
        replacement: CircularProgressIndicator(),
        child: SizedBox(
          height: 600,
          width: 600,
          child: ListView.separated(
            shrinkWrap: true,
            primary: false,
            itemBuilder: (context, index) {
              return TaskCard(
                task: Taskstatus.snew,
                taskModel: _taskInCompleted[index],
              );
            },
            separatorBuilder: (context, index) => SizedBox(height: 8),
            itemCount: _taskInCompleted.length,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onTapAddNewtask,
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _getAllCancelledTaskList() async {
    _getCompletedtaskInProgress = true;

    setState(() {});
    final NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.completedTaskListUrl,
    );
    if (response.isSuccess) {
      TaskListModel taskListModel = TaskListModel.formJson(response.data ?? {});
      _taskInCompleted = taskListModel.taskList;
    } else {
      showShackBarMessenger(context, response.errorMessage, true);
    }
    _getCompletedtaskInProgress = false;
    setState(() {});
  }
}
