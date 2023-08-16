import 'dart:developer';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_department_option_res_model.dart';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';

class GetDepartmentOptionRepo extends BaseService {
  Future<GetDepartmentOptionResModel> getDepartmentOption() async {
    Map<String, dynamic> body = {
      "action": "getDepartmentOption",
    };
    var response =
        await ApiService().getResponse(apiType: APIType.aPost, body: body);
    // if (response == null) {
    //   return null;
    // }
    final result = GetDepartmentOptionResModel.fromJson(response);
    log("GetDepartmentOptionResModel  REPO : => $response");
    return result;
  }
}
