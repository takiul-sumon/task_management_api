import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_management_api/ui/screans/forget_password_verification.dart';
import 'package:task_management_api/ui/screans/register_screan.dart';
import 'package:task_management_api/ui/widget/screan_Background.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  onTapSignInButton() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return RegisterScrean();
        },
      ),
    );
  }

  void onTapSubmitButton() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return ForgetPasswordVerification();
        },
      ),
    );
  }

  @override
  void dispose() {
    _setnewPasswordTECOntroller.dispose();
    _confirmNewPasswordTEController.dispose();
    super.dispose();
  }

  final TextEditingController _setnewPasswordTECOntroller =
      TextEditingController();
  final TextEditingController _confirmNewPasswordTEController =
      TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

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
                  'Set Password',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),

                Text(
                  'Set a new Password of At least 6 digit',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 10),

                TextFormField(
                  decoration: InputDecoration(hintText: 'Set Password'),
                  controller: _setnewPasswordTECOntroller,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Confirm Password'),
                  controller: _confirmNewPasswordTEController,
                  keyboardType: TextInputType.visiblePassword,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: onTapSubmitButton,
                  child: Text('Confirm', style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(height: 30),
                Center(
                  child: Column(
                    children: [
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black45,
                          ),
                          children: [
                            TextSpan(text: 'Have account? '),
                            TextSpan(
                              text: 'Sign In',
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer:
                                  TapGestureRecognizer()
                                    ..onTap = onTapSignInButton,
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
