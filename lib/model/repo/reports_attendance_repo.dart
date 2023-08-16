// ignore_for_file: avoid_print

import 'dart:developer';
import 'package:msp_educare_demo/model/apiModel/requestModel/add_expenses_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/exam_score_report_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/homework_report_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/common_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/exam_score_report_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/expenses_report_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_financial_report_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_homework_list_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_payroll_report_res_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/staff_attendance_report_res_model.dart';
import '../../utils/const_utils.dart';
import '../../utils/dateformat_utils.dart';
import '../../utils/enum_utils.dart';
import '../apiModel/responseModel/stud_attendance_report_res_model.dart';
import '../apiService/api_service.dart';
import '../apiService/base_service.dart';

class ReportsRepo extends BaseService {
  /// ====================== STUD REPORT ====================== ///
  Future<StudAttendanceReportResModel> studAttendanceReport(
    DateTime date,
  ) async {
    Map<String, dynamic> body = {
      "action": "studentAttendanceReport",
      "user_type": ConstUtils.getUserData().usertype,
      "a_date": DateFormatUtils.ddMMYYYY2Format(date),
    };

    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      body: body,
    );
    final result = StudAttendanceReportResModel.fromJson(response);
    log("ReportsAttendanceResModel  REPO : => $response");
    return result;
  }

  /// ====================== STAFF REPORT ====================== ///

  Future<StaffAttendanceReportResModel> staffAttendanceReport(
    DateTime date,
  ) async {
    Map<String, dynamic> body = {
      "action": "staffAttendanceReport",
      "user_type": ConstUtils.getUserData().usertype,
      "a_date": DateFormatUtils.ddMMYYYY2Format(date),
    };

    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      body: body,
    );
    final result = StaffAttendanceReportResModel.fromJson(response);
    log("StaffAttendanceReportResModel  REPO : => $response");
    return result;
  }

  /// ====================== HOMEWORK REPORT ====================== ///

  Future<GetHomeworkListResModel> homeworkReports(
      HomeworkReportReqModel reqModel) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      body: reqModel.toJson(),
    );
    final result = GetHomeworkListResModel.fromJson(response);
    log("HomeworkReportResModel  REPO : => $response");
    return result;
  }

  /// ====================== EXAM SCORE REPORT ====================== ///

  Future<ExamScoreReportResModel> examScoreReports(
      ExamScoreReportReqModel reqModel) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      body: reqModel.toJson(),
    );
    final result = ExamScoreReportResModel.fromJson(response);
    log("ExamScoreReportResModel  REPO : => $response");
    return result;
  }

  /// ====================== FINANCIAL REPORT ====================== ///

  Future<GetFinancialReportResModel> financialReports() async {
    var response = await ApiService().getResponse(
        apiType: APIType.aPost, body: {"action": "getFinancialReport"});
    final result = GetFinancialReportResModel.fromJson(response);
    log("GetFinancialReportResModel  REPO : => $response");
    return result;
  }

  /// ====================== FINANCIAL REPORT ====================== ///

  Future<GetPayrollReportResModel> payrollReport(DateTime date) async {
    print(
        ' DateFormatUtils.MMMYYYYFormat(DateTime.now())=>${DateFormatUtils.MMMFormat(date)}');
    var response = await ApiService().getResponse(
        apiType: APIType.aPost,
        body: {
          "action": "payrollReport",
          "month": DateFormatUtils.MMMFormat(date)
        });
    final result = GetPayrollReportResModel.fromJson(response);
    log("GetFinancialReportResModel  REPO : => $response");
    return result;
  }

  ///======================= Expenses REPORT ==========================///

  Future<GetExpensesReportResModel> expensesReport() async {
    Map<String, dynamic> body = {
      "action": "getExpensesList",
      "user_type": ConstUtils.getUserData().usertype,
    };
    var response =
        await ApiService().getResponse(apiType: APIType.aPost, body: body);

    final result = GetExpensesReportResModel.fromJson(response);
    log('GetExpensesReportResModel Repo :==>$response');
    return result;
  }

  ///===========================EDIT EXPENSES REPORT ====================///

  Future<CommonResModel> saveExpenses(EditExpensesReqModel reqModel) async {
    var response = await ApiService()
        .getResponse(apiType: APIType.aPost, body: reqModel.toJson());
    final result = CommonResModel.fromJson(response);
    log("saveExpenses RESPONSE REPO : => $response");
    return result;
  }
}
