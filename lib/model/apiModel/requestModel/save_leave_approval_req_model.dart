import 'package:msp_educare_demo/utils/const_utils.dart';

import '../responseModel/login_res_model.dart';

class SaveLeaveApprovalReqModel {
  SaveLeaveApprovalReqModel({
    this.approvedReason,
    this.leaveId,
    this.status,
  });

  String? approvedReason;
  String? leaveId;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    UserData userData = ConstUtils.getUserData();
    map['action'] = 'saveLeaveApproval';
    map['user_type'] = userData.usertype;
    map['user_id'] = userData.userid;
    map['approved_reason'] = approvedReason;
    map['leave_id'] = leaveId;
    map['status'] = status;
    return map;
  }
}
