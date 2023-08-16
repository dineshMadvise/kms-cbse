import 'dart:developer';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';
import '../apiModel/responseModel/get_edit_expenses_status_res_model.dart';


class GetEditStatusRepo extends BaseService {
  Future<GetEditExpensesStatusResModel> getEditStatus() async {
    Map<String, dynamic> body = {
      "action": "getExpensePaymentStatus",
    };

    var response = await ApiService().getResponse(apiType: APIType.aPost, body: body);

    final result = GetEditExpensesStatusResModel.fromJson(response);
    log("GetEditExpensesOption REPO: => $response");

    return result;
  }
}
