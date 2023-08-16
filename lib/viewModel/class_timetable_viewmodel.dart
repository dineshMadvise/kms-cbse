// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/model/repo/get_class_timetable_list_repo.dart';

class ClassTimeTableViewModel extends GetxController {
  ApiResponse getClassTimeTableListApiResponse = ApiResponse.initial('INITIAL');

  /// GET IN SCHOOL
  Future<void> getClassTimeTableList() async {
    getClassTimeTableListApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response =
          await GetClassTimeTableListRepo().getClassTimeTableList();
      getClassTimeTableListApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('getClassTimeTableListApiResponse ERROR :=> $e');
      getClassTimeTableListApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }
}
