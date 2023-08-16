import 'dart:developer';
import 'package:msp_educare_demo/model/apiModel/requestModel/update_student_profile_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/update_staff_profile_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/common_res_model.dart';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';

/// ===================  UPDATE STUDENT PROFILE ====================== ///
class UpdateStudentProfileRepo extends BaseService {
  Future<CommonResModel> updateStudentProfileRepo(
      UpdateStudentProfileReqModel reqModel) async {
    var response = await ApiService()
        .getResponse(apiType: APIType.aPost, body: reqModel.toJson());
    final result = CommonResModel.fromJson(response);
    log("UpdateStudentProfileRepo RESPONSE REPO : => $response");
    return result;
  }
}
/// ===================  UPDATE STAFF PROFILE ====================== ///
class UpdateStaffProfileRepo extends BaseService {
  Future<CommonResModel> updateStaffProfileRepo(
      UpdateStaffProfileReqModel reqModel) async {
    var response = await ApiService()
        .getResponse(apiType: APIType.aPost, body: reqModel.toJson());
    final result = CommonResModel.fromJson(response);
    log("UpdateTeacherProfileRepo RESPONSE REPO : => $response");
    return result;
  }
}
