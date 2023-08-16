class SendOtpReqModel {
  String? userType;
  String? userName;
  SendOtpReqModel._internal();
  static final SendOtpReqModel _sendOtpReqModel = SendOtpReqModel._internal();

  factory SendOtpReqModel() {
    return _sendOtpReqModel;
  }
  // SendOtpReqModel.SendOtpReqModel({this.userName, this.userType});

  Map<String, dynamic> toJson() => {
        "action": "forgotpwdsendotp",
        "username": userName,
        "user_type": userType
      };
}
