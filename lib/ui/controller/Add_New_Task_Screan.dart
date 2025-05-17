import 'package:get/get.dart';
import 'package:task_management_api/data/services/network_client.dart';
import 'package:task_management_api/data/urls.dart';

class AddNewTaskScreanController extends GetxController {
  bool _addNewProgress = false;
  bool get addNewProgress => _addNewProgress;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> addnewTask(String title, String description) async {
    _addNewProgress = true;
    bool isSuccess = false;

    update();
    Map<String, dynamic> requestBody = {
      "title": title,
      "description": description,
      "status": "new",
    };
    NetworkResponse response = await NetworkClient.postRequest(
      url: Urls.createTask,
      body: requestBody,
    );
    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = null;
    } else {
      response.errorMessage;
    }

    _addNewProgress = false;
    update();
    return isSuccess;
  }
}
