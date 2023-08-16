class StudentDetailResModel {
  StudentDetailResModel({
    this.data,
    this.status,
  });

  StudentDetailResModel.fromJson(dynamic json) {
    if (json['DATA'] != null) {
      if (json['DATA'] is List<dynamic>) {
        json['DATA'].forEach((v) {
          data?.add(StudentDetailData.fromJson(v));
        });
      } else {
        msg = json['DATA'];
      }
    }
    status = json['status'];
  }

  List<StudentDetailData>? data = [];
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

class StudentDetailData {
  StudentDetailData(
      {this.id,
      this.studentId,
      this.className,
      this.sectionName,
      this.dob,
      this.bloodGroup,
      this.fatherName,
      this.fatherMailid,
      this.fatherPhonenumber,
      this.password,
      this.profileImage,
      this.name});

  StudentDetailData.fromJson(dynamic json) {
    id = json['id'];
    studentId = json['student_id'];
    className = json['class_name'] ?? '';
    sectionName = json['section_name'] ?? "";
    dob = json['dob'];
    bloodGroup = json['blood_group'] ?? "";
    fatherName = json['father_name'];
    fatherMailid = json['father_mailid'];
    fatherPhonenumber = json['father_phonenumber'];
    password = json['password'];
    profileImage = json['profile_image'];
    name = json['name'];
  }

  String? id;
  String? studentId;
  String? className;
  String? sectionName;
  String? dob;
  String? bloodGroup;
  String? fatherName;
  String? fatherMailid;
  String? fatherPhonenumber;
  String? password;
  String? profileImage;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['student_id'] = studentId;
    map['class_name'] = className;
    map['section_name'] = sectionName;
    map['dob'] = dob;
    map['blood_group'] = bloodGroup;
    map['father_name'] = fatherName;
    map['father_mailid'] = fatherMailid;
    map['father_phonenumber'] = fatherPhonenumber;
    map['password'] = password;
    map['profile_image'] = profileImage;
    map['name'] = name;
    return map;
  }
}
