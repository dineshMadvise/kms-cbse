import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/stud_list_res_model.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';

class AddLeaveReqModel {
  AddLeaveReqModel({
    this.leaveType,
    this.fromDate,
    this.toDate,
    this.reason,
    this.attachment,
  });

  String? leaveType;
  String? fromDate;
  String? toDate;
  String? reason;
  String? attachment;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    StudentData studentData = ConstUtils.getStudentData();
    UserData userData = ConstUtils.getUserData();

    map['action'] = 'addLeaveRequest';
    map['user_id'] = userData.userid;
    map['user_type'] = userData.usertype;
    map['student_id'] =
        userData.usertype == ConstUtils.kGetRoleIndex(VariableUtils.parent)
            ? studentData.id
            : "0";
    map['leave_type'] = leaveType;
    map['from_date'] = fromDate;
    map['to_date'] = toDate;
    map['reason'] = reason;
    map['attachment'] = attachment;
    return map;
  }
}
