import 'package:flutter/material.dart';
import 'package:task_management_api/data/services/network_client.dart';
import 'package:task_management_api/data/urls.dart';
import 'package:task_management_api/ui/widget/screan_Background.dart';
import 'package:task_management_api/ui/widget/snackBarMessenger.dart';
import 'package:task_management_api/ui/widget/tm_app_bar.dart';

class AddNewTaskScrean extends StatefulWidget {
  const AddNewTaskScrean({super.key});

  @override
  State<AddNewTaskScrean> createState() => _AddNewTaskScreanState();
}

class _AddNewTaskScreanState extends State<AddNewTaskScrean> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  bool _addNewProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: ScreanBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _fromKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 32),
                  Text(
                    'Add New Task',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(hintText: 'Title'),
                    controller: _titleTEController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Enter a title';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _descriptionTEController,
                    maxLines: 6,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Enter a Despecription';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Description',
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Visibility(
                    visible: _addNewProgress == false,
                    replacement: CircularProgressIndicator(),
                    child: ElevatedButton(
                      onPressed: onTapSubmitButton,
                      child: Icon(
                        Icons.arrow_forward_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _addnewTask() async {
    _addNewProgress = true;
    setState(() {});
    Map<String, dynamic> requestBody = {
      "title": _titleTEController.text.trim(),
      "description": _descriptionTEController.text.trim(),
      "status": "new",
    };
    NetworkResponse response = await NetworkClient.postRequest(
      url: Urls.createTask,
      body: requestBody,
    );
    if (response.isSuccess) {
      showShackBarMessenger(context, "New task added!");
    } else {
      showShackBarMessenger(context, response.errorMessage);
    }
  }

  @override
  void dispose() {
    _titleTEController.dispose();
    _descriptionTEController.dispose();

    super.dispose();
  }

  void _clearTextFields() {
    _titleTEController.clear();
    _descriptionTEController.clear();
  }

  onTapSubmitButton() {
    if (_fromKey.currentState!.validate()) {
      _addnewTask();
    }
  }
}
