import 'dart:developer';

import 'package:msp_educare_demo/model/apiModel/responseModel/common_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/stud_list_res_model.dart';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';

class GetAnnounceCountRepo extends BaseService {
  Future<CommonResModel> getAnnounceCount(String id) async {
    UserData data = ConstUtils.getUserData();
    StudentData studentData = ConstUtils.getStudentData();

    Map<String, dynamic> body = {
      "action": "getAnnouncecount",
      "user_type": data.usertype,
      "user_id": data.userid,
      "student_id":
          data.usertype == ConstUtils.kGetRoleIndex(VariableUtils.parent)
              ? studentData.id
              : "0",
      "announcement_id": id
    };

    var response =
        await ApiService().getResponse(apiType: APIType.aPost, body: body);
    final result = CommonResModel.fromJson(response);
    log("ADD CLAIM RESPONSE REPO : => $response");
    return result;
  }
}
