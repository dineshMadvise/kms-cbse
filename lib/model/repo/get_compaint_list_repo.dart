import 'dart:developer';

import 'package:msp_educare_demo/model/apiModel/responseModel/get_compaint_list_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/stud_list_res_model.dart';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';

class GetComplaintListRepo extends BaseService {
  Future<GetComplaintListResModel> getComplaintList(
      {bool isFeedback = false}) async {
    UserData data = ConstUtils.getUserData();
    StudentData studentData = ConstUtils.getStudentData();
    Map<String, dynamic> body = {
      "action": "getComplaintList",
      "user_id": data.userid,
      "user_type": data.usertype,
      "type": isFeedback ? "feedback" : "complaint",
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
    final result = GetComplaintListResModel.fromJson(response);
    log("GetComplaintListResModel  REPO : => $response");
    return result;
  }
}
