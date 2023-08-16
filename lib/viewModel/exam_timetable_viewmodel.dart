// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/model/repo/get_exam_timetable_list_repo.dart';

class ExamTimetableViewModel extends GetxController {
  ApiResponse getExamTimeTableListApiResponse = ApiResponse.initial('INITIAL');

  /// GET EXAM TIME TABLE LIST
  Future<void> getExamTimeTableList() async {
    getExamTimeTableListApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await GetExamTimeTableListRepo().getExamTimeTableList();
      getExamTimeTableListApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('getExamTimeTableListApiResponse ERROR :=> $e');
      getExamTimeTableListApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }
}
