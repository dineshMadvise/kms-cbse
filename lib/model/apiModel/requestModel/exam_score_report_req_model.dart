import 'package:msp_educare_demo/utils/const_utils.dart';

class ExamScoreReportReqModel {
  ExamScoreReportReqModel({
    this.classId,
    this.sectionId,
    this.examId,
    this.studentId,
  });

  ExamScoreReportReqModel.fromJson(dynamic json) {
    classId = json['class_id'];
    sectionId = json['section_id'];
    examId = json['exam_id'];
    studentId = json['student_id'];
  }
  String? classId;
  String? sectionId;
  String? examId;
  String? studentId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['action'] = "getExamScoreReport";
    map['user_type'] = ConstUtils.getUserData().usertype;
    map['class_id'] = classId;
    map['section_id'] = sectionId;
    map['exam_id'] = examId;
    map['student_id'] = studentId;
    return map;
  }
}
