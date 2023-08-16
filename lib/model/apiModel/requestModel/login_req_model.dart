import 'package:msp_educare_demo/utils/shared_preference_utils.dart';

class LoginReqModel {
  String? userName;
  String? password;
  String? userType;

  LoginReqModel({
    this.userName,
    this.password,
    this.userType,
  });

  Map<String, dynamic> toJson() => {
        "action": "login",
        "username": userName,
        "password": password,
        "user_type": userType,
        "mobile_token": PreferenceManagerUtils.getFcmToken()
      };
}
