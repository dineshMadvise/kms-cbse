import 'dart:developer';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_transport_info_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/stud_list_res_model.dart';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';

class GetTransportInfoRepo extends BaseService {
  Future<GetTransportInfoResModel> getTransportInfo() async {
    UserData data = ConstUtils.getUserData();
    StudentData studentData = ConstUtils.getStudentData();

    Map<String, dynamic> body = {
      "action": "getTransportInfo",
      "user_type": data.usertype,
      "user_id": data.userid,
      "student_id":
          data.usertype == ConstUtils.kGetRoleIndex(VariableUtils.parent)
              ? studentData.id
              : "0",
    };

    var response =
        await ApiService().getResponse(apiType: APIType.aPost, body: body);
    final result = GetTransportInfoResModel.fromJson(response);
    log("ADD GetTransportInfoResModel RESPONSE REPO : => $response");
    return result;
  }
}
