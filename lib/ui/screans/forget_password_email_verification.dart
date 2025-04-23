import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_management_api/data/services/network_client.dart';
import 'package:task_management_api/data/urls.dart';

import 'package:task_management_api/ui/screans/forget_password_pin_verification.dart';
import 'package:task_management_api/ui/widget/screan_Background.dart';
import 'package:task_management_api/ui/widget/snackBarMessenger.dart';

class ForgotPasswordVerifyEmailScreen extends StatefulWidget {
  const ForgotPasswordVerifyEmailScreen({super.key});

  @override
  State<ForgotPasswordVerifyEmailScreen> createState() =>
      _ForgotPasswordVerifyEmailScreenState();
}

class _ForgotPasswordVerifyEmailScreenState
    extends State<ForgotPasswordVerifyEmailScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _getNewTaskInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreanBackground(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80),
                Text(
                  'Your Email Address',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  'A 6 digit verification pin will be sent to your email.',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailTEController,
                  decoration: const InputDecoration(hintText: 'Email'),
                  validator: (String? value) {
                    String email = value?.trim() ?? '';
                    if (EmailValidator.validate(email) == false) {
                      return "Enter a Valid Email";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _onTapSubmitButton,
                  child: Icon(
                    Icons.arrow_circle_right_outlined,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 32),
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      children: [
                        const TextSpan(text: "Have account? "),
                        TextSpan(
                          text: 'Sign In',
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer:
                              TapGestureRecognizer()
                                ..onTap = _onTapSignInButton,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _getAllNewTaskList() async {
    _getNewTaskInProgress = true;

    setState(() {});
    final NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.recoveryEmail(_emailTEController.text),
    );
    if (response.isSuccess) {
      showShackBarMessenger(
        context,
        "Successfully Sent 6 digit pin to your email",
      );
    } else {
      showShackBarMessenger(context, response.errorMessage, true);
    }
    _getNewTaskInProgress = false;
    setState(() {});
  }

  void _onTapSubmitButton() {
    _getAllNewTaskList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => ForgetPinVerification(email: _emailTEController.text),
      ),
    );
  }

  void _onTapSignInButton() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    super.dispose();
  }
}
