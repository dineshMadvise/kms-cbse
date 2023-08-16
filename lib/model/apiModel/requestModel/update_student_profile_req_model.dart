class UpdateStudentProfileReqModel {
  UpdateStudentProfileReqModel({
      this.action, 
      this.userId, 
      this.name, 
      this.dob, 
      this.bloodGroup, 
      this.fatherName, 
      this.fatherMailid, 
      this.fatherPhonenumber, 
      this.password, 
      this.confirmPassword,});

  UpdateStudentProfileReqModel.fromJson(dynamic json) {
    action = json['action'];
    userId = json['user_id'];
    name = json['name'];
    dob = json['dob'];
    bloodGroup = json['blood_group'];
    fatherName = json['father_name'];
    fatherMailid = json['father_mailid'];
    fatherPhonenumber = json['father_phonenumber'];
    password = json['password'];
    confirmPassword = json['confirm_password'];
  }
  String? action;
  String? userId;
  String? name;
  String? dob;
  String? bloodGroup;
  String? fatherName;
  String? fatherMailid;
  String? fatherPhonenumber;
  String? password;
  String? confirmPassword;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['action'] = "updateStudentProfile";
    map['user_id'] = userId;
    map['name'] = name;
    map['dob'] = dob;
    map['blood_group'] = bloodGroup;
    map['father_name'] = fatherName;
    map['father_mailid'] = fatherMailid;
    map['father_phonenumber'] = fatherPhonenumber;
    map['password'] = password;
    map['confirm_password'] = confirmPassword;
    return map;
  }

}