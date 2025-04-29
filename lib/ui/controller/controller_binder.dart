import 'package:get/get.dart';
import 'package:task_management_api/ui/controller/login_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
  }
}
