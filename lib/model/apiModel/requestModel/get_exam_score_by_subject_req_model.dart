import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';

class GetExamScoreBySubjectReqModel {
  String? classId;
  String? sectionId;
  String? examId;
  String? subjectId;
  String? scoreType;

  GetExamScoreBySubjectReqModel(
      {
      this.classId,
      this.sectionId,
      this.examId,
      this.scoreType,
      this.subjectId});

  Map<String, dynamic> toJson() {
    UserData userData = ConstUtils.getUserData();
    return {
      "action": "getExamScoreforSelectedSubject",
      "user_id": userData.userid,
      "user_type": userData.usertype,
      "class_id": classId,
      "section_id": sectionId,
      "exam_id": examId,
      "subject_id": subjectId,
      "score_type": scoreType
    };
  }
}
