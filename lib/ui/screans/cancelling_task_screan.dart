import 'package:flutter/material.dart';
import 'package:task_management_api/data/models/task_list_model.dart';
import 'package:task_management_api/data/models/task_model.dart';
import 'package:task_management_api/data/services/network_client.dart';
import 'package:task_management_api/data/urls.dart';
import 'package:task_management_api/ui/screans/add_new_task_screan.dart';
import 'package:task_management_api/ui/screans/task_card.dart';
import 'package:task_management_api/ui/widget/snackBarMessenger.dart';

class CancelTaskScrean extends StatefulWidget {
  const CancelTaskScrean({super.key});

  @override
  State<CancelTaskScrean> createState() => _CancelTaskScreanState();
}

class _CancelTaskScreanState extends State<CancelTaskScrean> {
  bool _getCancelledaskInProgress = false;

  List<TaskModel> _taskInCancelled = [];
  @override
  void initState() {
    super.initState();
    _getAllCancelledTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Visibility(
        visible: _getCancelledaskInProgress == false,
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
                taskModel: _taskInCancelled[index],
              );
            },
            separatorBuilder: (context, index) => SizedBox(height: 8),
            itemCount: _taskInCancelled.length,
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
    _getCancelledaskInProgress = true;

    setState(() {});
    final NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.cancelledTaskListUrl,
    );
    if (response.isSuccess) {
      TaskListModel taskListModel = TaskListModel.formJson(response.data ?? {});
      _taskInCancelled = taskListModel.taskList;
    } else {
      showShackBarMessenger(context, response.errorMessage, true);
    }
    _getCancelledaskInProgress = false;
    setState(() {});
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
}
