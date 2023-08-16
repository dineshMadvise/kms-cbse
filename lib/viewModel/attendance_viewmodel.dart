// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/get_stud_att_list_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/save_attendance_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_attendance_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/model/repo/get_attendance_repo.dart';
import 'package:msp_educare_demo/model/repo/get_stud_att_list_repo.dart';
import 'package:msp_educare_demo/model/repo/save_attendance_repo.dart';
import 'package:msp_educare_demo/utils/const_utils.dart';
import 'package:msp_educare_demo/utils/dateformat_utils.dart';
import 'package:msp_educare_demo/utils/variable_utils.dart';

import '../model/apiModel/responseModel/get_stud_att_list_res_modeldart.dart';

class AttendanceViewModel extends GetxController {
  /// ATTENDANCE LIST SCREEN

  bool _isGetAttendanceLoading=false;

  bool get isGetAttendanceLoading => _isGetAttendanceLoading;

  set isGetAttendanceLoading(bool value) {
    _isGetAttendanceLoading = value;
    update();
  }

  AttendanceInfo? selectedAttendanceInfo;

  void setSelectedAttendanceInfo(AttendanceInfo? value) {
    selectedAttendanceInfo = value;
    update();
  }

  DateTime _selectedMonth = DateTime.now();

  DateTime get selectedMonth => _selectedMonth;

  set selectedMonth(DateTime value) {
    _selectedMonth = value;
    update();
  }

  int _extraDays = ConstUtils.dayIndex(DateFormatUtils.eeeeFormat(
      DateTime(DateTime.now().year, DateTime.now().month, 1)));

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
    isGetAttendanceLoading=true;
    selectedAttendanceInfo=null;
    getAttendanceList(date,isDateChange: true);
  }

  void backwardDate() {
    _selectedMonth = DateTime(
        _selectedMonth.year, _selectedMonth.month - 1, _selectedMonth.day);
    final date = DateTime(_selectedMonth.year, _selectedMonth.month, 1);
    _extraDays = ConstUtils.dayIndex(DateFormat('EEEE').format(date));
    isGetAttendanceLoading=true;
    selectedAttendanceInfo=null;
    getAttendanceList(date,isDateChange: true);
  }

  List<StudAttData> _selectedStudent = [];

  set selectedStudent(List<StudAttData> value) {
    if (_selectedStudent.isEmpty) {
      _selectedStudent = value;
    }
    // update();
  }

  void setStudentAttendance(StudAttData data) {
    final index =
        _selectedStudent.indexWhere((element) => element.id == data.id);
    if (index > -1) {
      _selectedStudent[index] = StudAttData.fromJson(data.toJson());
    } else {
      _selectedStudent.add(StudAttData.fromJson(data.toJson()));
    }
    update();
  }

  List<StudAttData> get selectedStudent => _selectedStudent;

  void clearSelectedStudent() {
    _selectedStudent.clear();
    update();
  }

  /// API CALLING .............................

  ApiResponse getAttendanceListApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse getStudAttendanceListApiResponse = ApiResponse.initial('INITIAL');
  ApiResponse saveAttendanceApiResponse = ApiResponse.initial('INITIAL');

  void resetSaveAttendance() {
    saveAttendanceApiResponse = ApiResponse.initial('INITIAL');
  }

  /// GET Attendance LIST
  Future<void> getAttendanceList(DateTime date,{bool isDateChange=false}) async {
    if(!isDateChange){
      getAttendanceListApiResponse = ApiResponse.loading('LOADING');
    }

    update();
    try {
      final response = await GetAttendanceRepo().getAttendance(date);
      getAttendanceListApiResponse = ApiResponse.complete(response);

    } catch (e) {
      print('getAttendanceListApiResponse ERROR :=> $e');
      getAttendanceListApiResponse = ApiResponse.error('ERROR');
    }
    _isGetAttendanceLoading=false;
    update();
  }

  /// GET STUD Attendance LIST
  Future<void> getStudAttendanceList(GetStudAttListReqModel reqModel) async {
    getStudAttendanceListApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await GetStudAttListRepo().getStudAttList(reqModel);
      getStudAttendanceListApiResponse = ApiResponse.complete(response);
      if (response.status == VariableUtils.ok) {
        _selectedStudent = response.data!;
      }
    } catch (e) {
      print('getStudAttendanceListApiResponse ERROR :=> $e');
      getStudAttendanceListApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// SAVE Attendance
  Future<void> saveAttendance(SaveAttendanceReqModel reqModel) async {
    saveAttendanceApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await SaveAttendanceRepo().saveAttendance(reqModel);
      saveAttendanceApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('saveAttendanceApiResponse ERROR :=> $e');
      saveAttendanceApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }
}
