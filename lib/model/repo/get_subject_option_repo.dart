import 'dart:developer';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_subject_option_res_model.dart';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';

class GetSubjectOptionRepo extends BaseService {
  Future<GetSubjectOptionResModel> getSubjectOption(
      {required String classId, required String teacherId}) async {
    Map<String, dynamic> body = {
      "action": "getTeacherSubjectdependentOption",
      "class_id": classId,
      "teacher_id": teacherId
    };
    var response =
        await ApiService().getResponse(apiType: APIType.aPost, body: body);
    // if (response == null) {
    //   return null;
    // }
    final result = GetSubjectOptionResModel.fromJson(response);
    log("GetSubjectOptionResModel  REPO : => $response");
    return result;
  }
}
