import 'dart:developer';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_teacher_class_option_res_model.dart';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';

class GetTeacherClassOptionRepo extends BaseService {
  Future<GetTeacherClassOptionResModel> getTeacherClassOption(
      String teacherId) async {
    Map<String, dynamic> body = {
      "action": "getTeacherClassOption",
      "teacher_id": teacherId
    };
    var response =
        await ApiService().getResponse(apiType: APIType.aPost, body: body);
    // if (response == null) {
    //   return null;
    // }
    final result = GetTeacherClassOptionResModel.fromJson(response);
    log("GetTeacherClassOptionResModel  REPO : => $response");
    return result;
  }
}
