import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';

class GetExamOptionReqModel {

  String? classId;
  String? sectionId;

  GetExamOptionReqModel({ this.classId, this.sectionId});

  Map<String, dynamic> toJson() {
    UserData userData = ConstUtils.getUserData();
    return {
      "action": "getExam",
      "user_type": userData.usertype,
      "class_id": classId,
      "section_id": sectionId
    };
  }
}
