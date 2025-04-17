import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_management_api/data/models/user_model.dart';
import 'package:task_management_api/data/services/network_client.dart';
import 'package:task_management_api/data/urls.dart';
import 'package:task_management_api/ui/controller/auth_controller.dart';
import 'package:task_management_api/ui/widget/screan_Background.dart';
import 'package:task_management_api/ui/widget/snackBarMessenger.dart';
import 'package:task_management_api/ui/widget/tm_app_bar.dart';

class UpdateProfileScrean extends StatefulWidget {
  const UpdateProfileScrean({super.key});

  @override
  State<UpdateProfileScrean> createState() => _UpdateProfileScreanState();
}

class _UpdateProfileScreanState extends State<UpdateProfileScrean> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  XFile? _pickedImage;

  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstnameTEController = TextEditingController();
  final TextEditingController _lastnameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  bool _updateInProgress = false;

  void onTapSubmitButton() {
    if (_formKey.currentState!.validate()) {
      _updateUser();
    }
  }

  Future<void> _updateUser() async {
    _updateInProgress = true;
    setState(() {});
    Map<String, dynamic> requestBody = {
      "email": _emailTEController.text.trim(),
      "firstName": _firstnameTEController.text.trim(),
      "lastName": _lastnameTEController.text.trim(),
      "mobile": _mobileTEController.text.trim(),
    };

    if (_passwordTEController.text.isNotEmpty) {
      requestBody['password'] = _passwordTEController.text;
    }
    if (_pickedImage != null) {
      List<int> imageBytes = await _pickedImage!.readAsBytes();
      String encodedImage = base64Encode(imageBytes);
      requestBody['photo'] = encodedImage;
    }
    NetworkResponse response = await NetworkClient.postRequest(
      url: Urls.updaterProfileUrl,
      body: requestBody,
    );
    _updateInProgress = false;
    setState(() {});
    if (response.isSuccess) {
      // _clearTextFields();
      _passwordTEController.clear();
      showShackBarMessenger(context, "Successful");
    } else {
      showShackBarMessenger(context, response.errorMessage.toString(), true);
    }
  }

  @override
  void initState() {
    UserModel userModel = AuthController.userModel!;
    _emailTEController.text = userModel.email;
    _firstnameTEController.text = userModel.firstName;
    _lastnameTEController.text = userModel.lastName;
    _mobileTEController.text = userModel.mobile;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: ScreanBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 32),
                  Text(
                    'Update Profile',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () => onTapGetImage(),
                    child: buildPhotoPickerWidget(context),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    enabled: false,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(hintText: 'Email'),
                    controller: _emailTEController,
                    validator: (String? value) {
                      String email = value?.trim() ?? '';
                      if (EmailValidator.validate(email) == false ||
                          email.isEmpty == true) {
                        return "Enter a Valid Email";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(hintText: 'First Name'),
                    controller: _firstnameTEController,
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(hintText: 'Last Name'),
                    controller: _lastnameTEController,
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter a last Name";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(hintText: 'Mobile'),
                    controller: _mobileTEController,
                    validator: (String? value) {
                      String number = value?.trim() ?? '';
                      RegExp regEx = RegExp(r"^(?:\+?88|088)?01[1-9]\d{8}$");

                      if (regEx.hasMatch(number)) {
                        return "Enter Your Valid Mobile Number";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    textInputAction: TextInputAction.none,
                    obscureText: true,
                    decoration: InputDecoration(hintText: 'Password'),
                    controller: _passwordTEController,
                    // validator: (String? value) {
                    //   if (value?.isEmpty == true || value!.length < 6) {
                    //     return "Enter a Valid Password";
                    //   }
                    //   return null;
                    // },
                  ),
                  const SizedBox(height: 8),

                  const SizedBox(height: 24),
                  Visibility(
                    visible: _updateInProgress == false,
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

  Widget buildPhotoPickerWidget(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 60,
          width: 100,
          child: Center(
            child: Text('Photos', style: TextStyle(color: Colors.white)),
          ),

          decoration: BoxDecoration(
            color: Colors.black45,
            borderRadius: BorderRadius.horizontal(left: Radius.circular(10)),
          ),
        ),
        SizedBox(width: 5),
        Text(
          _pickedImage?.name ?? 'Select your Photo',
          style: TextTheme.of(
            context,
          ).titleMedium!.copyWith(color: Colors.black45),
        ),
      ],
    );
  }

  onTapPhotoSubmitButton() {
    ImageSource.camera;
  }

  onTapPhotoPicker() {
    ImageSource.camera;
  }

  Future<void> onTapGetImage() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      _pickedImage = image;
      setState(() {});
    }
  }
}
