// ignore_for_file: unused_local_variable

import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';

import '../responseModel/stud_list_res_model.dart';

class AddAnnouncementReqModel {
  AddAnnouncementReqModel({
    this.studId,
    this.sectionId,
    this.classId,
    this.publishTo,
    this.aDate,
    this.title,
    this.description,
    this.attachment,
  });

  String? sectionId;
  String? studId;
  String? classId;
  String? publishTo;
  String? aDate;
  String? title;
  String? description;
  String? attachment;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    UserData userData = ConstUtils.getUserData();
    StudentData studentData = ConstUtils.getStudentData();
    map['action'] = 'addAnnouncement';
    map['user_id'] = userData.userid;
    map['user_type'] = userData.usertype;
    map['student_id'] = studId;
    map['section_id'] = sectionId;
    map['class_id'] = classId;
    map['publish_to'] = publishTo;
    map['a_date'] = aDate;
    map['title'] = title;
    map['description'] = description;
    map['attachment'] = attachment;
    return map;
  }
}
