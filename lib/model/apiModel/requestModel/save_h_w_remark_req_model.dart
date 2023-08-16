import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';

class SaveHWRemarkReqModel {
  SaveHWRemarkReqModel({
    this.homeworkId,
    this.parentId,
    this.studentId,
    this.remark,
  });

  String? homeworkId;
  String? parentId;
  String? studentId;
  String? remark;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    UserData userData = ConstUtils.getUserData();
    map['action'] = "saveHWremark";
    map['user_type'] = userData.usertype;
    map['homework_id'] = homeworkId;
    map['parent_id'] = parentId;
    map['student_id'] = studentId;
    map['remark'] = remark;
    return map;
  }
}
