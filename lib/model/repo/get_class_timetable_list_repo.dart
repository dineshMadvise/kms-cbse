import 'dart:developer';
import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/stud_list_res_model.dart';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';
import '../apiModel/responseModel/get_class_timetable_list_res_model.dart';

class GetClassTimeTableListRepo extends BaseService {
  Future<GetClassTimetableListResModel> getClassTimeTableList() async {
    UserData data = ConstUtils.getUserData();
    StudentData studentData = ConstUtils.getStudentData();
    Map<String, dynamic> body = {
      "action": "getClassTimeTableList",
      "user_id": data.userid,
      "user_type": data.usertype,
      "student_id":
          data.usertype == ConstUtils.kGetRoleIndex(VariableUtils.parent)
              ? studentData.id
              : "0"
    };
    var response =
        await ApiService().getResponse(apiType: APIType.aPost, body: body);
    // if (response == null) {
    //   return null;
    // }
    final result = GetClassTimetableListResModel.fromJson(response);
    log("GetClassTimetableListResModel  REPO : => $response");
    return result;
  }
}
