import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';

class SaveTeacherAttendanceReqModel {
  SaveTeacherAttendanceReqModel({
    this.aDate,
    this.attendance,
  });

  String? aDate;
  List<Attendance>? attendance;

  Map<String, dynamic> toJson() {
    UserData userData = ConstUtils.getUserData();
    final map = <String, dynamic>{};
    map['action'] = "saveTeacherAttendance";
    map['user_type'] = userData.usertype;
    map['user_id'] = userData.userid;
    map['a_date'] = aDate;
    map['attendance'] = attendance?.map((e) => e.toJson()).toList() ?? [];
    return map;
  }
}

class Attendance {
  String? staffId;
  String? status;

  Attendance({this.status, this.staffId});

  Map<String, dynamic> toJson() => {"staff_id": staffId, "status": status};
}
