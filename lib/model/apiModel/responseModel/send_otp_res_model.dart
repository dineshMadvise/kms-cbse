/// user_id : "0"
/// data : "OTP sent to your email"
/// status : "OK"

class SendOtpResModel {
  SendOtpResModel({
    this.userId,
    this.data,
    this.status,
  });

  SendOtpResModel.fromJson(dynamic json) {
    userId = json['user_id'];
    data = json['data'];
    status = json['status'];
  }
  String? userId;
  String? data;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = userId;
    map['data'] = data;
    map['status'] = status;
    return map;
  }
}
