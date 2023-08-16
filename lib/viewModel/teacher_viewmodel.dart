import 'package:get/get.dart';
import 'package:msp_educare_demo/model/apiModel/requestModel/save_teacher_attendance_req_model.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/get_teacher_attendance_list_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/model/repo/get_teacher_attendance_list_repo.dart';
import 'package:msp_educare_demo/model/repo/save_teacher_attendance_repo.dart';

class TeacherAttendanceViewModel extends GetxController {
  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  set selectedDate(DateTime value) {
    _selectedDate = value;
    update();
  }

  List<TeacherData> _selectedTeacher = [];

  List<TeacherData> get selectedTeacher => _selectedTeacher;

  set selectedTeacher(List<TeacherData> value) {
    if (_selectedTeacher.isEmpty) {
      _selectedTeacher = value;
    }
    update();
  }

  void setTeacherAttendance(TeacherData data) {
    final index =
        _selectedTeacher.indexWhere((element) => element.id == data.id);
    print('DATA ;=>${_selectedTeacher[index].toJson()}');
    if (index > -1) {
      _selectedTeacher[index] = TeacherData.fromJson(data.toJson());
    } else {
      _selectedTeacher.add(TeacherData.fromJson(data.toJson()));
    }
    print('AFTER DATA ;=>${_selectedTeacher[index].toJson()}');
    update();
  }

  void clearSelectedTeacher() {
    _selectedTeacher.clear();
    update();
  }

  /// API CALLING .............................

  ApiResponse getTeacherAttendanceListApiResponse =
      ApiResponse.initial('INITIAL');
  ApiResponse saveTeacherAttendanceApiResponse = ApiResponse.initial('INITIAL');

  /// GET TEACHER ATT DATA
  Future<void> getTeacherAttendanceList(DateTime date) async {
    getTeacherAttendanceListApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response =
          await GetTeacherAttendanceListRepo().getTeacherAttendanceList(date);
      getTeacherAttendanceListApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('getTeacherAttendanceListApiResponse ERROR :=> $e');
      getTeacherAttendanceListApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }

  /// SAVE TEACHER ATT
  Future<void> saveTeacherAttendance(
      SaveTeacherAttendanceReqModel reqModel) async {
    saveTeacherAttendanceApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response =
          await SaveTeacherAttendanceRepo().saveTeacherAttendanceRepo(reqModel);
      saveTeacherAttendanceApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('saveTeacherAttendanceApiResponse ERROR :=> $e');
      saveTeacherAttendanceApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }
}
