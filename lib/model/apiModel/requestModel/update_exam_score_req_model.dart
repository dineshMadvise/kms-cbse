import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';

class UpdateExamScoreReqModel {
  String? classId;
  String? sectionId;
  String? examId;
  String? subjectId;
  String? scoreType;
  List<ExamScore>? score;

  Map<String, dynamic> toJson() {
    UserData userData = ConstUtils.getUserData();
    return {
      "action": "updateExamScoreforSelectedSubject",
      "user_type": userData.usertype,
      "user_id": userData.userid,
      "class_id": classId,
      "section_id": sectionId,
      "exam_id": examId,
      "subject_id": subjectId,
      "score_type": scoreType,
      "score": score?.map((e) => e.toJson()).toList()
      // "score": [
      //   {"student_id": "6", "marks": "24"},
      //   {"student_id": "2", "marks": "25"}
      // ]
    };
  }
}

class ExamScore {
  String? studId;
  String? marks;

  ExamScore({this.marks, this.studId});

  ExamScore.fromJson(Map<String, dynamic> json) {
    studId = json['student_id'];
    marks = json['marks'];
  }

  Map<String, dynamic> toJson() => {'student_id': studId, 'marks': marks};
}
