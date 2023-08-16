// ignore_for_file: avoid_print

import 'dart:developer';
import 'package:msp_educare_demo/model/apiModel/responseModel/student_detail_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/staff_detail_res_model.dart';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';

/// ============================== TEACHER DETAIL ============================== ///
class TeacherDetailRepo extends BaseService {
  Future<TeacherDetailResModel> teacherDetailRepo(String userId) async {
    Map<String, dynamic> body = {
      "action": "getStaffProfile",
      "user_id": userId
    };
    var response =
        await ApiService().getResponse(apiType: APIType.aPost, body: body);
    print('RES....... :=>$response');
    final result = TeacherDetailResModel.fromJson(response);
    log("TeacherDetailResModel RESPONSE REPO : => $response");
    return result;
  }
}

/// ============================== STUDENT DETAIL ============================== ///
class StudentDetailRepo extends BaseService {
  Future<StudentDetailResModel> studentDetailRepo(String userId) async {
    Map<String, dynamic> body = {
      "action": "getStudentProfile",
      "user_id": userId
    };
    var response =
        await ApiService().getResponse(apiType: APIType.aPost, body: body);
    print('RES....... :=>$response');
    final result = StudentDetailResModel.fromJson(response);
    log("StudentDetailResModel RESPONSE REPO : => $response");
    return result;
  }
}
