import 'package:msp_educare_demo/utils/const_utils.dart';

import '../responseModel/login_res_model.dart';
import '../responseModel/stud_list_res_model.dart';

/// action : "addComplaint"
/// user_id : "12"
/// user_type : "2"
/// student_id : "24"
/// department_id : "5"
/// suggestion : "pls maintain rest rooms properly"
/// attachment : "V2ViZWFzeXN0ZXAgOik="

class AddComplaintReqModel {
  AddComplaintReqModel({
    String? departmentId,
    String? suggestion,
    String? attachment,
    String? type,
  });

  String? departmentId;
  String? suggestion;
  String? attachment;
  String? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    UserData userData = ConstUtils.getUserData();
    StudentData studentData = ConstUtils.getStudentData();
    map['action'] = 'addComplaint';
    map['user_id'] = userData.userid;
    map['user_type'] = userData.usertype;
    map['student_id'] = studentData.id;
    map['department_id'] = departmentId;
    map['suggestion'] = suggestion;
    map['attachment'] = attachment;
    map['type'] = type;
    return map;
  }
}
