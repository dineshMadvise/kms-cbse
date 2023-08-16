import 'dart:developer';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';
import '../apiModel/responseModel/get_edit_expenses_type_res_model.dart';

class GetEditTypeRepo extends BaseService {
  Future<GetEditExpensesTypeResModel> getEditType() async {
    Map<String, dynamic> body = {
      "action" : "getExpenseTypeOption"
    };

    var response = await ApiService().getResponse(apiType: APIType.aPost, body: body);

    final result = GetEditExpensesTypeResModel.fromJson(response);
    log("GetEditExpensesTypeResModel REPO: => $response");

    return result;
  }
}
