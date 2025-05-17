import 'package:flutter/material.dart';
import 'package:task_management_api/ui/controller/auth_controller.dart';
import 'package:task_management_api/ui/screans/login_scren.dart';
import 'package:task_management_api/ui/screans/main_bottom_nav_screan.dart';
import 'package:task_management_api/ui/utils/assets_path.dart';
import 'package:task_management_api/ui/widget/screan_Background.dart';

class splash_Screan extends StatefulWidget {
  const splash_Screan({super.key});

  @override
  State<splash_Screan> createState() => _splash_ScreanState();
}

class _splash_ScreanState extends State<splash_Screan> {
  @override
  void initState() {
    super.initState();
    _movetoNext();
  }

  Future<void> _movetoNext() async {
    final bool isLoggedIn = await AuthController.checkIfUserLoggedIn();

    await Future.delayed(Duration(seconds: 2));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder:
            (context) =>
                isLoggedIn ? const MainBottomNavScrean() : const LoginScren(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreanBackground(
        child: Image.asset(AssetsPath.logoSvg, fit: BoxFit.contain),
      ),
    );
  }
}
