import 'dart:developer';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_multiple_class_stud_option_res_model.dart';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';

class GetMultiClassStudOptionRepo extends BaseService {
  Future<GetMultipleClassStudOptionResModel> getMultiClassStudOption(
      String classId) async {
    Map<String, dynamic> body = {
      "action": "getMultipleClassStudentOption",
      "class_id": classId
    };
    var response =
        await ApiService().getResponse(apiType: APIType.aPost, body: body);
    // if (response == null) {
    //   return null;
    // }
    final result = GetMultipleClassStudOptionResModel.fromJson(response);
    log("GetMultipleClassStudOptionResModel  REPO : => $response");
    return result;
  }
}

class GetStudOptionBasedOnClassSectionRepo extends BaseService {
  Future<GetMultipleClassStudOptionResModel> getStudOptionBasedOnClassSection({
    required String classId,
    required String sectionId,
  }) async {
    Map<String, dynamic> body = {
      "action": "getStudentBaseonClassSection",
      "user_type": ConstUtils.getUserData().usertype,
      "section_id": sectionId,
      "class_id": classId,
    };
    var response =
        await ApiService().getResponse(apiType: APIType.aPost, body: body);
    // if (response == null) {
    //   return null;
    // }
    final result = GetMultipleClassStudOptionResModel.fromJson(response);
    log("GetStudOptionBasedOnClassSectionRepo  REPO : => $response");
    return result;
  }
}
