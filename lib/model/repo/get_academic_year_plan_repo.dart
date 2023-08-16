import 'dart:developer';

import 'package:msp_educare_demo/model/apiModel/responseModel/get_academic_year_plan_list.dart';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';

class GetAcademicYearPlanListRepo extends BaseService {
  Future<GetAcademicYearPlanListResModel> getAcademicYearPlanListRepo() async {
    Map<String, dynamic> body = {
      "action": "getAcademicyearplan",
    };

    var response =
        await ApiService().getResponse(apiType: APIType.aPost, body: body);
    // if (response == null) {
    //   return null;
    // }
    final result = GetAcademicYearPlanListResModel.fromJson(response);
    log("GetAcademicYearPlanListResModel  REPO : => $response");
    return result;
  }
}
