import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';

class GetStudAttListReqModel {
  GetStudAttListReqModel({
    this.classId,
    this.sectionId,
    this.aDate,
  });

  String? classId;
  String? sectionId;
  String? aDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    UserData userData = ConstUtils.getUserData();

    map['action'] = 'getStudentAttendanceList';
    map['user_type'] = userData.usertype;
    map['class_id'] = classId;
    map['section_id'] = sectionId;
    map['a_date'] = aDate;
    return map;
  }
}
