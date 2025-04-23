import 'package:flutter/material.dart';
import 'package:task_management_api/data/models/task_list_model.dart';
import 'package:task_management_api/data/models/task_model.dart';
import 'package:task_management_api/data/models/task_status_count.dart';
import 'package:task_management_api/data/models/task_status_count_model.dart';
import 'package:task_management_api/data/services/network_client.dart';
import 'package:task_management_api/data/urls.dart';
import 'package:task_management_api/ui/screans/add_new_task_screan.dart';
import 'package:task_management_api/ui/screans/task_card.dart';
import 'package:task_management_api/ui/widget/snackBarMessenger.dart';
import 'package:task_management_api/ui/widget/summary_card.dart';

class NewTaskScrean extends StatefulWidget {
  const NewTaskScrean({super.key});

  @override
  State<NewTaskScrean> createState() => _NewTaskScreanState();
}

class _NewTaskScreanState extends State<NewTaskScrean> {
  bool _getStatusCountInProgress = false;
  List<TaskStatusCountModel> _taskStatusCountList = [];
  List<TaskModel> _newTaskList = [];
  bool _getNewTaskInProgress = false;

  @override
  void initState() {
    _getAllTaskStatusCount();
    _getAllNewTaskList();
    print(_newTaskList.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Visibility(
              visible: _getStatusCountInProgress == false,
              replacement: CircularProgressIndicator(),
              child: buildSummarySection(),
            ),
            Visibility(
              visible: _getNewTaskInProgress == false,
              replacement: Center(child: CircularProgressIndicator()),
              child: SizedBox(
                height: 600,
                width: 500,
                child: ListView.separated(
                  // shrinkWrap: true,
                  // primary: false,
                  itemCount: _newTaskList.length,
                  itemBuilder: (context, index) {
                    return TaskCard(
                      task: Taskstatus.snew,
                      taskModel: _newTaskList[index],
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 8),
                ),
              ),
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
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _taskStatusCountList.length,
        itemBuilder: (context, index) {
          return SummaryTask(
            title: _taskStatusCountList[index].status,
            count: _taskStatusCountList[index].count,
          );
        },
      ),
    );
  }

  // Future<void> _getAllStatusCount() async {
  //   _getStatusCountInProgress = true;

  //   setState(() {});
  //   final NetworkResponse response = await NetworkClient.getRequest(
  //     url: Urls.taskStatusCountUrl,
  //   );
  //   if (response.isSuccess) {
  //     TaskStatusCountListModel taskStatusCountListModel =
  //         TaskStatusCountListModel.fromJson(response.data ?? {});
  //     _taskStatusCountList = taskStatusCountListModel.statusCountList;
  //   } else {
  //     showShackBarMessenger(context, response.errorMessage, true);
  //   }
  //   _getStatusCountInProgress = true;

  //   setState(() {});
  // }

  Future<void> _getAllTaskStatusCount() async {
    _getStatusCountInProgress = true;
    setState(() {});
    final NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.taskStatusCountUrl,
    );
    if (response.isSuccess) {
      TaskStatusCountListModel taskStatusCountListModel =
          TaskStatusCountListModel.fromJson(response.data ?? {});
      _taskStatusCountList = taskStatusCountListModel.statusCountList;
    } else {
      showShackBarMessenger(context, response.errorMessage, true);
    }

    _getStatusCountInProgress = false;
    setState(() {});
  }

  Future<void> _getAllNewTaskList() async {
    _getNewTaskInProgress = true;

    setState(() {});
    final NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.newtaskListCountUrl,
    );
    if (response.isSuccess) {
      TaskListModel taskListModel = TaskListModel.formJson(response.data ?? {});
      _newTaskList = taskListModel.taskList;
    } else {
      showShackBarMessenger(context, response.errorMessage, true);
    }
    _getNewTaskInProgress = false;
    setState(() {});
  }
}
