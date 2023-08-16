import 'dart:developer';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_attendance_status_res_model.dart';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';

class GetAttendanceStatusRepo extends BaseService {
  Future<GetAttendanceStatusResModel> getAttendanceStatus() async {
    Map<String, dynamic> body = {
      "action": "getAttendanceStatus",
    };

    var response =
        await ApiService().getResponse(apiType: APIType.aPost, body: body);
    // if (response == null) {
    //   return null;
    // }
    final result = GetAttendanceStatusResModel.fromJson(response);
    log("GetAttendanceStatusResModel  REPO : => $response");
    return result;
  }
}
