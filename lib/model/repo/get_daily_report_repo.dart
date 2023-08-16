import 'dart:developer';
import 'package:msp_educare_demo/model/apiModel/responseModel/daily_report_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/login_res_model.dart';
import 'package:msp_educare_demo/model/apiService/api_service.dart';
import 'package:msp_educare_demo/model/apiService/base_service.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/dateformat_utils.dart';
import 'package:msp_educare_demo/utils/enum_utils.dart';

class GetDailyReportRepo extends BaseService {
  Future<DailyReportResModel> getDailyReport(DateTime date) async {
    UserData data = ConstUtils.getUserData();

    Map<String, dynamic> body = {
      "action": "dailyreport",
      "user_type": data.usertype,
      "date": DateFormatUtils.ddMMYYYY2Format(date)
    };

    var response =
        await ApiService().getResponse(apiType: APIType.aPost, body: body);
    final result = DailyReportResModel.fromJson(response);
    log("DailyReportResModel  REPO : => $response");
    return result;
  }
}
