import 'dart:developer';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_event_list_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/stud_list_res_model.dart';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';

class GetEventListRepo extends BaseService {
  Future<GetEventListResModel> getEventList() async {
    UserData data = ConstUtils.getUserData();
    StudentData studentData = ConstUtils.getStudentData();

    print('STUDE ID :${studentData.id}');

    Map<String, dynamic> body = {
      "action": "getEventList",
      "user_type": data.usertype,
      "user_id": data.userid,
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
    final result = GetEventListResModel.fromJson(response);
    log("GetEventListResModel  REPO : => $response");
    return result;
  }
}
