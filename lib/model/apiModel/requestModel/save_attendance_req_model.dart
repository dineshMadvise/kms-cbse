import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';

class SaveAttendanceReqModel {
  SaveAttendanceReqModel({
    this.classId,
    this.sectionId,
    this.aDate,
    this.attendance
  });

  String? classId;
  String? sectionId;
  List<StudAttendance>? attendance;

  String? aDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    UserData userData = ConstUtils.getUserData();
    map['action'] = "saveAttendance";
    map['user_type'] = userData.usertype;
    map['user_id'] = userData.userid;
    map['class_id'] = classId;
    map['section_id'] = sectionId;
    // map['student_id'] = studentId;
    map['attendance'] = attendance?.map((e) => e.toJson()).toList() ?? [];
    map['a_date'] = aDate;
    return map;
  }
}


class StudAttendance {
  String? studentId;
  String? status;

  StudAttendance({this.status, this.studentId});

  Map<String, dynamic> toJson() => {"student_id": studentId, "status": status};
}
