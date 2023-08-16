class TeacherDetailResModel {
  TeacherDetailResModel({
    this.data,
    this.status,
  });

  TeacherDetailResModel.fromJson(dynamic json) {
    if (json['DATA'] != null) {
      if (json['DATA'] is List<dynamic>) {
        json['DATA'].forEach((v) {
          data?.add(TeacherData.fromJson(v));
        });
      } else {
        msg = json['DATA'];
      }
    }
    status = json['status'];
  }

  List<TeacherData>? data = [];
  String? status;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['DATA'] = data?.map((v) => v.toJson()).toList();
    }
    map['status'] = status;
    return map;
  }
}

class TeacherData {
  TeacherData(
      {this.id,
      this.employeeCode,
      this.firstName,
      this.lastName,
      this.dob,
      this.mailid,
      this.phonenumber,
      this.password,
      this.profileImage,
      this.bloodGroup});

  TeacherData.fromJson(dynamic json) {
    id = json['id'];
    employeeCode = json['employee_code'];
    firstName = json['first_name'] ?? '';
    lastName = json['last_name'] ?? "";
    dob = json['dob'];
    mailid = json['mailid'];
    phonenumber = json['phonenumber'];
    password = json['password'];
    profileImage = json['profile_image'];
    bloodGroup = json['blood_group'] ?? "";
  }

  String? id;
  String? employeeCode;
  String? firstName;
  String? lastName;
  String? dob;
  String? mailid;
  String? phonenumber;
  String? password;
  String? profileImage;
  String? bloodGroup;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['employee_code'] = employeeCode;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['dob'] = dob;
    map['mailid'] = mailid;
    map['phonenumber'] = phonenumber;
    map['password'] = password;
    map['profile_image'] = profileImage;
    map['blood_group'] = bloodGroup;
    return map;
  }
}
