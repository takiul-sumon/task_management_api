import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_api/ui/controller/login_controller.dart';
import 'package:task_management_api/ui/screans/forget_password_email_verification.dart';
import 'package:task_management_api/ui/screans/main_bottom_nav_screan.dart';
import 'package:task_management_api/ui/screans/register_screan.dart';
import 'package:task_management_api/ui/widget/class%20CenterCircularProgressIndicator%20extends%20StatelessWidget.dart';
import 'package:task_management_api/ui/widget/screan_Background.dart';
import 'package:task_management_api/ui/widget/snackBarMessenger.dart';

class LoginScren extends StatefulWidget {
  const LoginScren({super.key});

  @override
  State<LoginScren> createState() => _LoginScrenState();
}

class _LoginScrenState extends State<LoginScren> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final LoginController _loginController = Get.find<LoginController>();

  onTapSignInButton() {
    if (_formkey.currentState!.validate()) {
      _login();
      print('Hello World');
    }
  }

  onTapSignUpButton() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return RegisterScrean();
        },
      ),
    );
  }

  Future<void> _login() async {
    final bool isSuccess = await _loginController.login(
      _emailTEController.text.trim(),
      _passwordTEController.text,
    );

    if (isSuccess) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) {
            return MainBottomNavScrean();
          },
        ),
        (predicate) => false,
      );
    } else {
      showShackBarMessenger(context, _loginController.errorMessage!, true);
    }
  }

  void onTapForgotButton() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return ForgotPasswordVerifyEmailScreen();
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailTEController.dispose();
    _passwordTEController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreanBackground(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80),
                Text(
                  'Get Started With',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Email'),
                  controller: _emailTEController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  validator: (String? value) {
                    String email = value?.trim() ?? '';
                    if (EmailValidator.validate(email) == false) {
                      return "Enter a Valid Email";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Password'),
                  controller: _passwordTEController,
                  keyboardType: TextInputType.visiblePassword,
                ),
                const SizedBox(height: 20),
                GetBuilder<LoginController>(
                  builder:
                      (controller) => Visibility(
                        visible: controller.loginInProgress == false,
                        replacement: CenterCircularProgressIndicator(),
                        child: ElevatedButton(
                          onPressed: onTapSignInButton,
                          child: Icon(
                            Icons.arrow_forward_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: Column(
                    children: [
                      TextButton(
                        onPressed: onTapForgotButton,
                        child: Text('Forget Password?'),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black45,
                          ),
                          children: [
                            TextSpan(text: 'Don\'t have account? '),
                            TextSpan(
                              text: 'Sign Up',
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer:
                                  TapGestureRecognizer()
                                    ..onTap = onTapSignUpButton,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
