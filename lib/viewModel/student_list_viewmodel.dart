// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:msp_educare_demo/model/apiModel/responseModel/stud_list_res_model.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/model/repo/get_stud_list_repo.dart';

class StudentListViewModel extends GetxController {
  /// API CALL START ........................................

  ApiResponse studentListApiResponse = ApiResponse.initial('INITIAL');

  /// GET DASHBOARD DATA
  Future<void> getStudList() async {
    studentListApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      StudListResModel? response = await GetStudListRepo().getStudList();
      studentListApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('studentListApiResponse ERROR :=> $e');
      studentListApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }
}
