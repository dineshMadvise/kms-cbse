class ResetPasswordReqModel {
  String? userType;
  String? userId;
  String? otp;
  String? password;
  ResetPasswordReqModel._internal();
  static final ResetPasswordReqModel _reqModel =
      ResetPasswordReqModel._internal();

  factory ResetPasswordReqModel() {
    return _reqModel;
  }
  // ResetPasswordReqModel({this.userType, this.userId, this.password, this.otp});

  Map<String, dynamic> toJson() => {
        "action": "resetPassword",
        "user_id": userId,
        "user_type": userType,
        "otp": otp,
        "new_password": password
      };
}
