import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';

class SaveEnquiryReqModel {
  SaveEnquiryReqModel(
      {this.studentName,
      this.dob,
      this.nationality,
      this.classId,
      this.gender,
      this.age,
      this.parentName,
      this.phoneNo,
      this.area,
      this.id});

  SaveEnquiryReqModel.fromJson(dynamic json) {
    studentName = json['student_name'];
    dob = json['dob'];
    nationality = json['nationality'];
    classId = json['class_id'];
    gender = json['gender'];
    age = json['age'];
    parentName = json['parent_name'];
    phoneNo = json['phone_no'];
    area = json['area'];
  }

  String? studentName;
  String? dob;
  String? nationality;
  String? classId;
  String? gender;
  String? age;
  String? parentName;
  String? phoneNo;
  String? area;
  String? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    UserData userData = ConstUtils.getUserData();
    map['action'] = "saveEnquiry";
    map['user_type'] = userData.usertype;
    map['user_id'] = userData.userid;
    map['student_name'] = studentName;
    map['dob'] = dob;
    map['nationality'] = nationality;
    map['class_id'] = classId;
    map['gender'] = gender;
    map['age'] = age;
    map['parent_name'] = parentName;
    map['phone_no'] = phoneNo;
    map['area'] = area;
    return map;
  }

  Map<String, dynamic> updateToJson() {
    final map = <String, dynamic>{};
    UserData userData = ConstUtils.getUserData();
    map['action'] = "updateEnquiry";
    map['id'] = id;
    map['user_type'] = userData.usertype;
    map['user_id'] = userData.userid;
    map['student_name'] = studentName;
    map['dob'] = dob;
    map['nationality'] = nationality;
    map['class_id'] = classId;
    map['gender'] = gender;
    map['age'] = age;
    map['parent_name'] = parentName;
    map['phone_no'] = phoneNo;
    map['area'] = area;
    return map;
  }
}
