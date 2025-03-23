import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_management_api/ui/widget/screan_Background.dart';

class RegisterScrean extends StatefulWidget {
  const RegisterScrean({super.key});

  @override
  State<RegisterScrean> createState() => _RegisterScreanState();
}

class _RegisterScreanState extends State<RegisterScrean> {
  void onTapSignInButton() {
    Navigator.of(context).pop();
  }

  void onTapSubmitButton() {}

  void onTapForgotButton() {}
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstnameTEController = TextEditingController();
  final TextEditingController _lastnameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _emailTEController.dispose();
    _firstnameTEController.dispose();
    _lastnameTEController.dispose();
    _mobileTEController.dispose();
    _passwordTEController.dispose();
  }

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreanBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 80),
                  Text(
                    'Join with Us',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Email'),
                    controller: _emailTEController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'First Name'),
                    controller: _firstnameTEController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Last Name'),
                    controller: _lastnameTEController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Mobile'),
                    controller: _mobileTEController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 10),

                  TextFormField(
                    decoration: InputDecoration(hintText: 'Password'),
                    controller: _passwordTEController,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: onTapSubmitButton,
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
                              TextSpan(text: 'Already have an account? '),
                              TextSpan(
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                                text: 'Sign Up',
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
      ),
    );
  }
}
