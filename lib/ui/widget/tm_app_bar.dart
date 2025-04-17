import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:task_management_api/ui/controller/auth_controller.dart';
import 'package:task_management_api/ui/screans/login_scren.dart';
import 'package:task_management_api/ui/screans/updateProfileScrean.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TMAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      title: Row(
        children: [
          GestureDetector(
            onTap: () {
              onTapUpdateProfile(context);
            },
            child: CircleAvatar(
              backgroundImage:
                  _shoidlShowImage(AuthController.userModel?.photo)
                      ? MemoryImage(
                        base64Decode(AuthController.userModel?.photo ?? ''),
                      )
                      : null,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AuthController.userModel?.fullName ?? 'Name',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge!.copyWith(color: Colors.white),
                ),
                Text(
                  AuthController.userModel?.email ?? 'Email',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall!.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => _onTapLogoutButton(context),
            icon: Icon(Icons.logout, color: Colors.white),
          ),
        ],
      ),
    );
  }

  bool _shoidlShowImage(String? photo) {
    return photo != null && photo.isNotEmpty;
  }

  onTapUpdateProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return UpdateProfileScrean();
        },
      ),
    );
  }

  Future<void> _onTapLogoutButton(BuildContext context) async {
    await AuthController.clearUserData();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LoginScren();
        },
      ),
      (predicate) => false,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
