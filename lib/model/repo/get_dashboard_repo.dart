import 'dart:developer';
import 'package:msp_educare_demo/model/apiModel/responseModel/dashboard_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';

class GetDashBoardDataRepo extends BaseService {
  Future<DashboardResModel> getDashboard({String? userId}) async {
    UserData data = ConstUtils.getUserData();
    Map<String, dynamic> body = {
      "action": "getPermission",
      "role_id": data.roleid,
      "user_id": userId ?? data.userid
    };
    print('USER ID :$userId  ${data.userid}');
    var response =
        await ApiService().getResponse(apiType: APIType.aPost, body: body);
    // if (response == null) {
    //   return null;
    // }
    final result = DashboardResModel.fromJson(response);
    log("DashboardResModel  REPO : => $response");
    return result;
  }
}
