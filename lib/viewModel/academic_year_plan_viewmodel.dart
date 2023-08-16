// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_academic_year_plan_list.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/model/repo/get_academic_year_plan_repo.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';

class AcademicYearPlanVideModel extends GetxController {
  ApiResponse getAcademicYearPlanListApiResponse =
      ApiResponse.initial('INITIAL');

  /// GET ACADEMIC YEAR PLAN LIST
  Future<void> getAcademicYearPlanList() async {
    getAcademicYearPlanListApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response =
          await GetAcademicYearPlanListRepo().getAcademicYearPlanListRepo();
      getAcademicYearPlanListApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('getAcademicYearPlanListApiResponse ERROR :=> $e');
      getAcademicYearPlanListApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// FUNCTIONAL VARIABLES...

  DateTime _selectedMonth = DateTime.now();

  DateTime get selectedMonth => _selectedMonth;

  set selectedMonth(DateTime value) {
    _selectedMonth = value;
    update();
  }

  int _totalDays = ConstUtils.kTotalDayInMonth;

  int get totalDays => _totalDays;

  set totalDays(int value) {
    _totalDays = value;
    update();
  }

  int _extraDays = ConstUtils.dayIndex(DateFormat('EEEE')
      .format(DateTime(DateTime.now().year, DateTime.now().month, 1)));

  int get extraDays => _extraDays;

  set extraDays(int value) {
    _extraDays = value;
    update();
  }

  void forwardDate() {
    _selectedMonth = DateTime(
        _selectedMonth.year, _selectedMonth.month + 1, _selectedMonth.day);
    final date = DateTime(_selectedMonth.year, _selectedMonth.month, 1);
    _extraDays = ConstUtils.dayIndex(DateFormat('EEEE').format(date));
    getTotalDaysForMonth();
  }

  void backwardDate() {
    _selectedMonth = DateTime(
        _selectedMonth.year, _selectedMonth.month - 1, _selectedMonth.day);
    final date = DateTime(_selectedMonth.year, _selectedMonth.month, 1);
    _extraDays = ConstUtils.dayIndex(DateFormat('EEEE').format(date));
    getTotalDaysForMonth();
  }

  void getTotalDaysForMonth() {
    totalDays = DateTime(_selectedMonth.year, _selectedMonth.month + 1, 0).day;
  }

  CalenderData? selectedCalenderDate;

  void setCalenderDate(CalenderData data) {
    selectedCalenderDate = data;
    update();
  }
}
