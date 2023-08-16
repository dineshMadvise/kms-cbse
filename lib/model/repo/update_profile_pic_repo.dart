// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps

import 'dart:developer';
import 'package:msp_educare_demo/model/apiModel/responseModel/common_res_model.dart';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';

/// ===================  UPDATE STUDENT PROFILE ====================== ///
class UpdateStudentProfilePicRepo extends BaseService {
  Future<bool> updateStudentProfilePicRepo(String img) async {
    final Map<String, dynamic> body = {
      "action": "updateStudentPicture",
      "user_id": ConstUtils.getStudentData().id,
      "profile": img
    };
    print('REQ MODEL :=>${body}');
    var response =
        await ApiService().getResponse(apiType: APIType.aPost, body: body);
    final result = CommonResModel.fromJson(response);
    log("UpdateStudentProfileRepo RESPONSE REPO : => $response");
    if(result.status==VariableUtils.ok){
      return true;
    }
    return false;
  }
}

/// ===================  UPDATE STAFF PROFILE ====================== ///
class UpdateStaffProfilePicRepo extends BaseService {
  Future<bool> updateStaffProfilePicRepo(String img) async {
    final Map<String, dynamic> body = {
      "action": "updateStaffPicture",
      "user_id": ConstUtils.getUserData().userid,
      "profile": img
    };
    print('REQ MODEL :=>${body}');
    var response =
        await ApiService().getResponse(apiType: APIType.aPost, body: body);
    final result = CommonResModel.fromJson(response);
    log("UpdateTeacherProfileRepo RESPONSE REPO : => $response");
    if(result.status==VariableUtils.ok){
      return true;
    }
    return false;
  }
}
