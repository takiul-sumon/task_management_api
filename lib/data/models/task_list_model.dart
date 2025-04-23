import 'package:task_management_api/data/models/task_model.dart';

class TaskListModel {
  late final String status;
  late final List<TaskModel> taskList;
  TaskListModel.formJson(Map<String, dynamic> jsonData) {
    status = jsonData['status'];
    if (jsonData['status'] != null) {
      List<TaskModel> list = [];
      for (Map<String, dynamic> data in jsonData['data']) {
        list.add(TaskModel.fromJson(data));
      }
      taskList = list;
    } else {
      taskList = [];
    }
  }
}
