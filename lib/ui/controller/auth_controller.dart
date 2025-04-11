import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management_api/data/models/user_model.dart';

class AuthController {
  static String? token;
  static UserModel? userModel;

  static const String _tokenKey = 'token';
  static const String _userDataKey = 'token';

  static Future<void> saveUserInformation(
    String accessToken,
    UserModel userModel,
  ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_tokenKey, accessToken);
    sharedPreferences.setString(_userDataKey, jsonEncode(userModel.toJson()));

    token = accessToken;
    userModel = userModel;
  }

  static Future<void> getUserInformation() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? accessToken = sharedPreferences.getString(_tokenKey);
    String? saveUserModelString = sharedPreferences.getString(_userDataKey);
    if (saveUserModelString != null) {
      UserModel savedUserModel = UserModel.fromJson(
        jsonDecode(saveUserModelString),
      );
      userModel = savedUserModel;
    }
    token = accessToken;
  }
}
