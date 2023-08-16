// ignore_for_file: avoid_print

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/add_expenses_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/exam_score_report_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/homework_report_req_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/model/repo/reports_attendance_repo.dart';

class ReportViewModel extends GetxController {
  final List _expansionPanelList = [];

  List get expansionPanelList => _expansionPanelList;

  void setExpansionPanelList(int index) {
    if (_expansionPanelList.contains(index)) {
      _expansionPanelList.remove(index);
    } else {
      _expansionPanelList.add(index);
    }
    update();
  }

  String _selectedFiles = '';

  String get selectedFiles => _selectedFiles;

  set selectedFiles(String value) {
    _selectedFiles = value;
    update();
  }

  void clearExpansionPanelList() {
    _expansionPanelList.clear();

    // update();
  }

  void initClearData() {
    editExpensesReportApiResponse = ApiResponse.initial('INITIAL');
    _selectedFiles = "";
    // update();
  }

  ApiResponse studAttendanceReportApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse staffAttendanceReportApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse examScoreReportApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse financialReportApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse payrollReportApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse homeworkReportsAttendanceApiResponse =
      ApiResponse.initial('INITIAL');

  ApiResponse expensesReportApiResponse = ApiResponse.initial('INITIAL');

  ApiResponse editExpensesReportApiResponse = ApiResponse.initial('INITIAL');

  /// Student Attendance
  Future<void> studAttendanceReport(
    DateTime dateTime,
  ) async {
    studAttendanceReportApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await ReportsRepo().studAttendanceReport(
        dateTime,
      );
      studAttendanceReportApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('studentAttendanceApiResponse ERROR :=> $e');
      studAttendanceReportApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// STAFF Attendance
  Future<void> staffAttendanceReport(
    DateTime dateTime,
  ) async {
    staffAttendanceReportApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await ReportsRepo().staffAttendanceReport(
        dateTime,
      );
      staffAttendanceReportApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('staffAttendanceReportApiResponse ERROR :=> $e');
      staffAttendanceReportApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// GET HOMEWORK REPORT
  Future<void> homeworkReportsAttendance(
      HomeworkReportReqModel reqModel) async {
    homeworkReportsAttendanceApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await ReportsRepo().homeworkReports(reqModel);
      homeworkReportsAttendanceApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('homeworkReportsAttendanceApiResponse ERROR :=> $e');
      homeworkReportsAttendanceApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// GET HOMEWORK REPORT
  Future<void> examScoreReportsAttendance(
      ExamScoreReportReqModel reqModel) async {
    examScoreReportApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await ReportsRepo().examScoreReports(reqModel);
      examScoreReportApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('examScoreReportReportApiResponse ERROR :=> $e');
      examScoreReportApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// GET FINANCIAL REPORT
  Future<void> getFinancialReportsAttendance() async {
    financialReportApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await ReportsRepo().financialReports();
      financialReportApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('financialReportApiResponse ERROR :=> $e');
      financialReportApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// GET PAYROLL REPORT
  Future<void> getPayrollReportsAttendance(DateTime date) async {
    payrollReportApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await ReportsRepo().payrollReport(date);
      payrollReportApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('payrollReportApiResponse ERROR :=> $e');
      payrollReportApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  ///  GET EXPENSES REPORT

  Future<void> getExpensesReport() async {
    expensesReportApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await ReportsRepo().expensesReport();
      expensesReportApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('ExpensesReportApiResposne Error :==>$e');
      expensesReportApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  ///     EDIT EXPENSES REPORT

  Future<void> saveExpenses(EditExpensesReqModel reqModel) async {
    editExpensesReportApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await ReportsRepo().saveExpenses(reqModel);
      editExpensesReportApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('Edit Expense Report Api ERROR :==>$e');
      editExpensesReportApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }
}
