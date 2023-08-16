import 'dart:developer';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_section_option_res_model.dart';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';

class GetSectionOptionRepo extends BaseService {
  Future<GetSectionOptionResModel> getSectionOption(String classId) async {
    Map<String, dynamic> body = {
      "action": "getTeacherSectiondependentOption",
      "class_id": classId
    };
    var response =
        await ApiService().getResponse(apiType: APIType.aPost, body: body);
    // if (response == null) {
    //   return null;
    // }
    final result = GetSectionOptionResModel.fromJson(response);
    log("GetSectionOptionResModel  REPO : => $response");
    return result;
  }
}
