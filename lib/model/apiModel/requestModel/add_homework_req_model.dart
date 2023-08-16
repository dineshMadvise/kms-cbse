import 'package:msp_educare_demo/utils/const_utils.dart';

import '../responseModel/login_res_model.dart';

class AddHomeworkReqModel {
  AddHomeworkReqModel({
    this.teacherId,
    this.classId,
    this.sectionId,
    this.subjectId,
    this.hDate,
    this.completeDate,
    this.title,
    this.description,
    this.attachment,
  });

  String? teacherId;
  String? classId;
  String? sectionId;
  String? subjectId;
  String? hDate;
  String? completeDate;
  String? title;
  String? description;
  String? attachment;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    UserData userData = ConstUtils.getUserData();
    map['action'] = "addHomework";
    map['user_type'] = userData.usertype;
    map['user_id'] = userData.userid;
    map['teacher_id'] = teacherId;
    map['class_id'] = classId;
    map['section_id'] = sectionId;
    map['subject_id'] = subjectId;
    map['h_date'] = hDate;
    map['complete_date'] = completeDate;
    map['title'] = title;
    map['description'] = description ?? '';
    map['attachment'] = attachment;
    return map;
  }
}
