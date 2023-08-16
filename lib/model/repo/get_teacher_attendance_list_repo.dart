import 'dart:developer';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_teacher_attendance_list_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/dateformat_utils.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';

class GetTeacherAttendanceListRepo extends BaseService {
  Future<GetTeacherAttendanceListResModel> getTeacherAttendanceList(
      DateTime date) async {
    UserData data = ConstUtils.getUserData();

    Map<String, dynamic> body = {
      "action": "getTeacherAttendanceList",
      "user_type": data.usertype,
      "a_date": DateFormatUtils.yyyyMMDDFormat(date)
    };

    var response =
        await ApiService().getResponse(apiType: APIType.aPost, body: body);
    // if (response == null) {
    //   return null;
    // }
    final result = GetTeacherAttendanceListResModel.fromJson(response);
    log("GetTeacherAttendanceListResModel  REPO : => $response");
    return result;
  }
}
