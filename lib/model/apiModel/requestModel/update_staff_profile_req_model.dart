class UpdateStaffProfileReqModel {
  UpdateStaffProfileReqModel({
      this.action, 
      this.userId, 
      this.firstName, 
      this.lastName, 
      this.dob, 
      this.bloodGroup, 
      this.phoneNo, 
      this.mailid, 
      this.password, 
      this.confirmPassword, });

  UpdateStaffProfileReqModel.fromJson(dynamic json) {
    action = json['action'];
    userId = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    dob = json['dob'];
    bloodGroup = json['blood_group'];
    phoneNo = json['phone_no'];
    mailid = json['mailid'];
    password = json['password'];
    confirmPassword = json['confirm_password'];
  }
  String? action;
  String? userId;
  String? firstName;
  String? lastName;
  String? dob;
  String? bloodGroup;
  String? phoneNo;
  String? mailid;
  String? password;
  String? confirmPassword;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['action'] = "updateStaffProfile";
    map['user_id'] = userId;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['dob'] = dob;
    map['blood_group'] = bloodGroup;
    map['phone_no'] = phoneNo;
    map['mailid'] = mailid;
    map['password'] = password;
    map['confirm_password'] = confirmPassword;
    return map;
  }

}