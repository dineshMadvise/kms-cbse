import 'dart:developer';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_teacher_option_res_model.dart';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';

class GetTeacherOptionRepo extends BaseService {
  Future<GetTeacherOptionResModel> getTeacherOption() async {
    Map<String, dynamic> body = {
      "action": "getTeacherOption",
    };
    var response =
        await ApiService().getResponse(apiType: APIType.aPost, body: body);
    // if (response == null) {
    //   return null;
    // }
    final result = GetTeacherOptionResModel.fromJson(response);
    log("GetTeacherOptionResModel  REPO : => $response");
    return result;
  }
}
