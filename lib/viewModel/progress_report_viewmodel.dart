// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:msp_educare_demo/model/apis/api_response.dart';
import 'package:msp_educare_demo/model/repo/get_progress_report_repo.dart';

class ProgressReportViewModel extends GetxController {
  ApiResponse getProgressReportApiResponse = ApiResponse.initial('INITIAL');

  /// GET PROGRESS REPORT
  Future<void> getProgressReport() async {
    getProgressReportApiResponse = ApiResponse.loading('LOADING');
    update();
    try {
      final response = await GetProgressReportRepo().getProgressReportRepo();
      getProgressReportApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print('getProgressReportApiResponse ERROR :=> $e');
      getProgressReportApiResponse = ApiResponse.error('ERROR');
    }
    update();
  }
}
