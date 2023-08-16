import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';

class GetExamSubjectOptionReqModel {
  String? classId;
  String? sectionId;
  String? examId;

  GetExamSubjectOptionReqModel({this.classId, this.sectionId, this.examId});

  Map<String, dynamic> toJson() {
    UserData userData = ConstUtils.getUserData();
    return {
      "action": "getExamSubject",
      "user_id": userData.userid,
      "user_type": userData.usertype,
      "class_id": classId,
      "section_id": sectionId,
      "exam_id": examId
    };
  }
}
