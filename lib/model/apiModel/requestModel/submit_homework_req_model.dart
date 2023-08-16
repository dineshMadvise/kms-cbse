import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/stud_list_res_model.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';

class SubmitHomeworkReqModel {
  SubmitHomeworkReqModel({
    this.homeworkId,
    this.attachment,
  });

  String? homeworkId;
  String? attachment;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    UserData data = ConstUtils.getUserData();
    StudentData studentData = ConstUtils.getStudentData();
    map['action'] = "submitHomework";
    map['user_type'] = data.usertype;
    map['user_id'] = data.userid;
    map['homework_id'] = homeworkId;
    map['student_id'] =
        data.usertype == ConstUtils.kGetRoleIndex(VariableUtils.parent)
            ? studentData.id
            : "0";
    map['attachment'] = attachment;
    return map;
  }
}
