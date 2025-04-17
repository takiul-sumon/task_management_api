import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_management_api/ui/screans/pin_verification_screan.dart';
import 'package:task_management_api/ui/widget/screan_Background.dart';

class ForgetPasswordVerification extends StatefulWidget {
  const ForgetPasswordVerification({super.key});

  @override
  State<ForgetPasswordVerification> createState() =>
      _ForgetPasswordVerificationState();
}

class _ForgetPasswordVerificationState
    extends State<ForgetPasswordVerification> {
  onTapSignInButton() {
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    super.dispose();
  }

  void onTapSigninButton() {}

  final TextEditingController _emailTEController = TextEditingController();
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
                  'Your Email Address',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                Text(
                  'A Verification Code will be Sent to your email',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Email'),
                  controller: _emailTEController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return ForgetPinVerification(
                            email: _emailTEController.toString(),
                          );
                        },
                      ),
                    );
                  },
                  child: Icon(
                    Icons.arrow_forward_outlined,
                    color: Colors.white,
                  ),
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
