import 'dart:developer';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_progress_report_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/stud_list_res_model.dart';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';

class GetProgressReportRepo extends BaseService {
  Future<GetProgressReportResModel> getProgressReportRepo() async {
    UserData userData = ConstUtils.getUserData();
    StudentData studentData = ConstUtils.getStudentData();
    Map<String, dynamic> body = {
      "action": "getProgressReport",
      "student_id": studentData.id ?? userData.userid,
      "user_type": userData.usertype
    };
    var response =
        await ApiService().getResponse(apiType: APIType.aPost, body: body);
    // if (response == null) {
    //   return null;
    // }
    final result = GetProgressReportResModel.fromJson(response);
    log("GetProgressReportResModel  REPO : => $response");
    return result;
  }
}
