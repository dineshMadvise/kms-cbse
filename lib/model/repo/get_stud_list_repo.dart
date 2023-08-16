import 'dart:developer';
import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/stud_list_res_model.dart';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';

class GetStudListRepo extends BaseService {
  Future<StudListResModel> getStudList() async {
    UserData data = ConstUtils.getUserData();
    Map<String, dynamic> body = {
      "action": "getStudentList",
      "user_type": data.usertype,
      "user_id": data.userid
    };
    var response =
        await ApiService().getResponse(apiType: APIType.aPost, body: body);
    // if (response == null) {
    //   return null;
    // }
    final result = StudListResModel.fromJson(response);
    log("StudListResModel  REPO : => $response");
    return result;
  }
}
