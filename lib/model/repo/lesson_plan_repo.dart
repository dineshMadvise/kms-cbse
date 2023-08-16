import 'dart:developer';

import 'package:msp_educare_demo/model/apiModel/requestModel/add_lesson_plan_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/update_lesson_plan_status_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/common_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_lesson_info_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_lesson_plan_list.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/stud_list_res_model.dart';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';

class LessonPlanRepo extends BaseService {
  Future<GetLessonPlanListResModel> getLessonPlanRepo() async {
    UserData data = ConstUtils.getUserData();
    StudentData studentData = ConstUtils.getStudentData();

    Map<String, dynamic> body = {
      "action": "getLessonPlan",
      "user_type": data.usertype,
      "user_id": data.userid,
      "student_id":
      data.usertype == ConstUtils.kGetRoleIndex(VariableUtils.parent)
          ? studentData.id
          : "0"
    };

    var response =
    await ApiService().getResponse(apiType: APIType.aPost, body: body);
    // if (response == null) {
    //   return null;
    // }
    final result = GetLessonPlanListResModel.fromJson(response);
    log("GetLessonPlanListResModel  REPO : => $response");
    return result;
  }

  Future<CommonResModel> updateLessonPlanStatusRepo(
      UpdateLessonPlanStatusReqModel reqModel) async {
    var response = await ApiService()
        .getResponse(apiType: APIType.aPost, body: reqModel.toJson());
    final result = CommonResModel.fromJson(response);
    log("UpdateLessonPlanStatusRepo REPO : => $response");
    return result;
  }

  Future<CommonResModel> addLessonPlanStatusRepo(
      AddLessonPlanReqModel reqModel) async {
    var response = await ApiService()
        .getResponse(apiType: APIType.aPost, body: reqModel.toJson());
    final result = CommonResModel.fromJson(response);
    log("AddLessonPlanStatusRepo REPO : => $response");
    return result;
  }

  Future<GetLessonInfoResModel> getLessonPlanInfoRepo(String lessonId)async{
    UserData data = ConstUtils.getUserData();

    Map<String,dynamic> body= {
      "action" : "getLessonPlanInfo",
      "user_type" : data.usertype,
      "user_id" : data.userid,
      "lesson_plan_id" : lessonId,

    };

    var response =
    await ApiService().getResponse(apiType: APIType.aPost, body: body);
    // if (response == null) {
    //   return null;
    // }
    final result = GetLessonInfoResModel.fromJson(response);
    log("GetLessonInfoResModel  REPO : => $response");
    return result;

  }Future<CommonResModel> deleteLessonPlanRepo(String lessonId)async{
    UserData data = ConstUtils.getUserData();

    Map<String,dynamic> body= {
      "action" : "deleteLessonPlan",
      "user_type" : data.usertype,
      "user_id" : data.userid,
      "lesson_plan_id" : lessonId,

    };

    var response =
    await ApiService().getResponse(apiType: APIType.aPost, body: body);
    // if (response == null) {
    //   return null;
    // }
    final result = CommonResModel.fromJson(response);
    log("CommonResModel  REPO : => $response");
    return result;

  }


}
