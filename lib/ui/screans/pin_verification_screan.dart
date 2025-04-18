import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_management_api/ui/screans/login_scren.dart';
import 'package:task_management_api/ui/screans/reset_password.dart';
import 'package:task_management_api/ui/widget/screan_Background.dart';

class ForgetPinVerification extends StatefulWidget {
  const ForgetPinVerification({super.key, required this.email});
  final String email;

  @override
  State<ForgetPinVerification> createState() => _ForgetPinVerificationState();
}

class _ForgetPinVerificationState extends State<ForgetPinVerification> {
  onTapSignInButton() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LoginScren();
        },
      ),
      (pre) => false,
    );
  }

  onTapSubmitButton() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) {
          return ResetPassword();
        },
      ),
      (pre) => false,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pincodeTEController.dispose();
  }

  void onTapForgotButton() {}

  final TextEditingController _pincodeTEController = TextEditingController();
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
                  'Pin Verification',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                Text(
                  'A Verification Code will be Sent to your email',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 10),
                PinCodeTextField(
                  appContext: context,
                  controller: _pincodeTEController,
                  pastedTextStyle: TextStyle(
                    color: Colors.green.shade600,
                    fontWeight: FontWeight.bold,
                  ),
                  length: 6,
                  keyboardType: TextInputType.number,

                  backgroundColor: Colors.transparent,
                  blinkWhenObscuring: true,
                  animationType: AnimationType.fade,
                  validator: (v) {
                    if (v!.length < 3) {
                      return "I'm from validator";
                    } else {
                      return null;
                    }
                  },
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.white,
                  ),
                ),

                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: onTapSubmitButton,
                  child: Text('Verify'),
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
