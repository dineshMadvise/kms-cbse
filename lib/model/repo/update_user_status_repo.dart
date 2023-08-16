// ignore_for_file: avoid_print

import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';
import '../../utils/const_utils.dart';
import '../apiService/base_service.dart';

class UpdateUserStatusRepo extends BaseService {
  Future<dynamic> updateUserStatus({required String status}) async {
    UserData data = ConstUtils.getUserData();

    Map<String, dynamic> body = {
      "action": "update_user_status",
      "user_id": data.userid,
      "user_type": data.usertype,
      "status": status
    };
    var response =
        await ApiService().getResponse(apiType: APIType.aPost, body: body);
    print('updateUserStatus response:=>$response');

    return response;
  }
}
