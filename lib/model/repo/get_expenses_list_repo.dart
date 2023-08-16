import 'dart:developer';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_expenses_list_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';

class GetExpenseRepo extends BaseService {
  Future<GetExpensesListResModel> getExpenseList() async {
    UserData data = ConstUtils.getUserData();

    Map<String, dynamic> body = {
      "action": "getExpensesList",
      "user_type": data.usertype,
    };

    var response =
        await ApiService().getResponse(apiType: APIType.aPost, body: body);
    // if (response == null) {
    //   return null;
    // }
    final result = GetExpensesListResModel.fromJson(response);
    log("GetExpensesListResModel  REPO : => $response");
    return result;
  }
}
