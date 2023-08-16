import 'package:msp_educare_demo/utils/const_utils.dart';

class HomeworkReportReqModel {
  HomeworkReportReqModel({
      this.classId,
      this.sectionId, 
      this.date,});

  HomeworkReportReqModel.fromJson(dynamic json) {
    classId = json['class_id'];
    sectionId = json['section_id'];
    date = json['date'];
  }
  String? classId;
  String? sectionId;
  String? date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['action'] = "getHomeworkReport";
    map['user_type'] = ConstUtils.getUserData().usertype;
    map['class_id'] = classId;
    map['section_id'] = sectionId;
    map['date'] = date;
    return map;
  }
}