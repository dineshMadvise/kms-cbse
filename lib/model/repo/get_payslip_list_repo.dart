import 'dart:developer';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_payslip_list_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';

class GetPaySlipListRepo extends BaseService {
  Future<GetPayslipListResModel> getPaySlipList() async {
    UserData data = ConstUtils.getUserData();

    Map<String, dynamic> body = {
      "action": "getPayslipList",
      "user_type": data.usertype,
      "user_id": data.userid
    };

    var response =
        await ApiService().getResponse(apiType: APIType.aPost, body: body);
    // if (response == null) {
    //   return null;
    // }
    final result = GetPayslipListResModel.fromJson(response);
    log("GetPayslipListResModel  REPO : => $response");
    return result;
  }
}
