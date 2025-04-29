import 'package:get/get.dart';
import 'package:task_management_api/data/models/task_list_model.dart';
import 'package:task_management_api/data/models/task_model.dart';
import 'package:task_management_api/data/services/network_client.dart';
import 'package:task_management_api/data/urls.dart';

class Newtaskcontroller extends GetxController {
  bool _NewTaskInProgress = false;
  bool get getNewTaskInProgress => _NewTaskInProgress;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  List<TaskModel> _newTaskList = [];
  List<TaskModel> get newTaskModel => _newTaskList;

  Future<bool> getAllNewTaskList() async {
    bool isSuccess = false;

    _NewTaskInProgress = true;

    update();

    final NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.newtaskListCountUrl,
    );
    if (response.isSuccess) {
      TaskListModel taskListModel = TaskListModel.formJson(response.data ?? {});
      _newTaskList = taskListModel.taskList;
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }
    _NewTaskInProgress = false;
    update();
    return isSuccess;
  }
}
