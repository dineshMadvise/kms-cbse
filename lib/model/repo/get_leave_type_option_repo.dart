import 'dart:developer';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_leave_type_option_res_model.dart';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';

class GetLeaveTypeOptionRepo extends BaseService {
  Future<GetLeaveTypeOptionResModel> getLeaveTypeOption() async {
    Map<String, dynamic> body = {
      "action": "getLeaveTypeOption",
    };
    var response =
        await ApiService().getResponse(apiType: APIType.aPost, body: body);
    // if (response == null) {
    //   return null;
    // }
    final result = GetLeaveTypeOptionResModel.fromJson(response);
    log("GetLeaveTypeOptionResModel  REPO : => $response");
    return result;
  }
}
